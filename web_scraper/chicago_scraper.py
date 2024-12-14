import pandas as pd
import numpy as np
import time
import platform
from dotenv import load_dotenv
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.common.exceptions import NoSuchElementException
import os
from supabase import create_client, Client
from datetime import datetime
import pytz

from utils.const.chicago_scraper_constants import CONTRACTOR, DARWIN_DRIVER, LICENSES, WINDOWS_DRIVER

def setup_driver() -> webdriver.Chrome:
    current_os = platform.system()

    if current_os == "Windows":
        service = Service(executable_path=WINDOWS_DRIVER)  
    elif current_os == "Darwin": 
        service = Service(executable_path=DARWIN_DRIVER)  
    else:
        raise Exception("Unsupported operating system")

    options = webdriver.ChromeOptions()
    options.add_argument("--headless=new")

    driver = webdriver.Chrome(options=options, service=service) 

    return driver

def fetch_table_data(pages: int, driver: webdriver.Chrome) -> pd.DataFrame:
    url = "https://webapps1.chicago.gov/licensedcontractors/all"

    driver.get(url)
    
    try:
        table = driver.find_element(By.ID, 'paginatedTable')
    except NoSuchElementException:
        print("Table was not found")

    try:
        titles = table.find_elements(By.TAG_NAME, 'th')
        table_titles = [title.text for title in titles]
    except NoSuchElementException:
        print("Table titles were not found")

    table_content = []
    wait = WebDriverWait(driver, 5)
    current = 0
    pages_requested = pages - 1

    table_rows = wait.until(expected_conditions.presence_of_all_elements_located((By.CSS_SELECTOR,'table#paginatedTable tbody tr')))
    for row in table_rows:
        row_data = [item.text for item in row.find_elements(By.TAG_NAME, 'td')] 
        table_content.append(row_data)

    while current < pages_requested: 
        try :
            next_bttn = driver.find_element(By.ID, 'paginatedTable_next')
            next_bttn.find_element(By.TAG_NAME, 'a').click()
            time.sleep(2)
            table_rows = wait.until(expected_conditions.presence_of_all_elements_located((By.CSS_SELECTOR,'table#paginatedTable tbody tr')))
            for row in table_rows:
                row_data = [item.text for item in row.find_elements(By.TAG_NAME, 'td')]             
                table_content.append(row_data)
            current +=1
        except Exception as e:
            break
    return table_content, table_titles

def processing_data(content: pd.DataFrame, table_titles: list[str]) -> pd.DataFrame:
    data = pd.DataFrame(np.array(content), columns = table_titles)
    data['Tags'] = data['License Type'].apply(lambda x: "General" if "General Contractor" in x 
                                            else "Electrical" if "Electrical Contractor" in x 
                                            else "Elevator Mechanic" if "Elevator Mechanic Contractor" in x 
                                            else "Mason" if "Mason Contractor" in x 
                                            else "Plumbing" if "Plumbing Contractor" in x 
                                            else "")
    return data

def update_database(data: pd.DataFrame, supabase):
    contractor_table = supabase.table(CONTRACTOR).select().execute().data
    licenses_table = supabase.table(LICENSES).select().execute().data 

    existing_contractors = {row["company_name"]: row for row in contractor_table}
    existing_licenses = {(row["contractor_id"], row["license_number"], row["license_type"], row["town"]) : row for row in licenses_table}

    current_time = datetime.now(pytz.utc).isoformat()

    for ind in data.index:
        company_name = data['Name'][ind]
        addr = data['Address'][ind]
        phone = data['Phone'][ind]

        license_number = data['License Number'][ind]
        license_type = data['License Type'][ind]
        license_expiration = data['License Expiration Date'][ind] or None
        insurance_expiration = data['Insurance / Bond Expiration Date'][ind] or None
        is_active = data['License Inactive?'][ind]
        parts = addr.split(",")
        town = parts[-2] if len(parts) >= 3 else None

        if company_name in existing_contractors:
            contractor = existing_contractors[company_name]
            contractor_id = contractor['id']

            if contractor['address'] != addr or contractor['phone'] != phone:
                supabase.table(CONTRACTOR).update({
                    "address": addr,
                    "phone": phone,
                    "updated_at": current_time,
                }).eq("id", contractor_id).execute()

        else:
            contractor = supabase.table(CONTRACTOR).insert({
                "company_name": company_name,
                "address": addr,
                "phone": phone,
                "created_at": current_time,
                "updated_at": current_time,
            }).execute()
            contractor_id = contractor['id']
        license_key = (contractor_id, license_number, license_type, town)
        if license_key in existing_licenses:
            print(f"exists{license_key}")
            license_entry = existing_licenses[license_key]
            response = supabase.table(LICENSES).update({
                "license_expiration": license_expiration,
                "insurance_expiration": insurance_expiration,
                "is_active": is_active,
                "updated_at": current_time,
            }).eq('id', license_entry['id']).execute()
            print(response)
        else:
            print(f"doesnt exist{license_key}")
            supabase.table(LICENSES).insert({
                "license_number": license_number,
                "license_type": license_type,
                "town": town,
                "license_expiration": license_expiration,
                "insurance_expiration": insurance_expiration,
                "is_active": is_active,
                "contractor_id": contractor_id,
                "created_at": current_time,
                "updated_at": current_time,
            }).execute()

def main(pages:int):
    load_dotenv()

    url = os.environ.get("SUPABASE_URL")
    if not url:
        raise Exception("SUPABASE_URL not set")
    
    key = os.environ.get("SUPABASE_SR")
    if not key: 
        raise Exception("SUPABASE_SR not set")
    
    supabase = create_client(url, key)

    driver = setup_driver()
    data, titles = fetch_table_data(pages,driver) 
    process_data = processing_data(data, titles)
    update_database(process_data, supabase)
    driver.quit()

if __name__ == "__main__":
    pages = input("How many pages would you like to scrape?") or "1"
    main(int(pages))


