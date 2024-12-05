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


'''processing data here'''

def processing_data(content: pd.DataFrame, table_titles: list[str]) -> pd.DataFrame:
    data = pd.DataFrame(np.array(content), columns = table_titles)
    data['Tags'] = data['License Type'].apply(lambda x: "General" if "General Contractor" in x 
                                            else "Electrical" if "Electrical Contractor" in x 
                                            else "Elevator Mechanic" if "Elevator Mechanic Contractor" in x 
                                            else "Mason" if "Mason Contractor" in x 
                                            else "Plumbing" if "Plumbing Contractor" in x 
                                            else "")
    print(data)
    return data


def update_database(data: pd.DataFrame, supabase):
    for ind in data.index: #data.index is the label for each row, so for every one index in the dataframe
        '''check if company_name exists in contractors table'''
        addr = data['Address'][ind]
        parts = addr.split(",")

        town = parts[-2] if len(parts) >= 3 else None

        license_number = data['License Number'][ind]
        license_type = data['License Type'][ind]
        license_expiration = data['License Expiration Date'][ind]
        insurance_expiration = data['Insurance / Bond Expiration Date'][ind]
        is_active = data['License Inactive?'][ind]

        if license_expiration is None or license_expiration.strip() == "":
            license_expiration = None
        if insurance_expiration is None or insurance_expiration.strip() == "": 
            insurance_expiration = None

        list_company_names = supabase.table(CONTRACTOR).select("id").eq("company_name", data['Name'][ind]).execute()
        if list_company_names.data: 
            contractor_ids = supabase.table(CONTRACTOR).select("id").eq("company_name", data['Name'][ind]).execute()

            contractor_id = contractor_ids.data[0]['id']

            supabase.table(CONTRACTOR).update({
                "company_name": data['Name'][ind],
                "address": data['Address'][ind],
                "phone": data['Phone'][ind],
                "updated_at": datetime.now(pytz.utc).isoformat()
            }).eq("id", contractor_id).execute()
            '''for each license assoicated with the contractor i have to check if a matching entry exists in the licenses table'''
            license_data = supabase.table(LICENSES).select("*").eq("contractor_id", contractor_id).eq("license_number", license_number).eq("license_type", license_type).eq("town",town).execute()
            if license_data.data: #checks if their is a matching entry that exist in the licenses table
                supabase.table(LICENSES).update({
                "license_number": license_number,
                "license_type": license_type,
                "town": town,
                "license_expiration": license_expiration,
                "insurance_expiration": insurance_expiration,
                "is_active": is_active,
                "contractor_id": contractor_id,
                "updated_at": datetime.now(pytz.utc).isoformat()
                }).eq("id", contractor_id).execute()
            else:
                supabase.table(LICENSES).insert({
                "license_number": license_number,
                "license_type": license_type,
                "town": town,
                "license_expiration": license_expiration,
                "insurance_expiration": insurance_expiration,
                "is_active": is_active,
                "contractor_id": contractor_id,
                }).execute()
        else:
            '''if it doesnt exist add a new contractor'''
            supabase.table(CONTRACTOR).insert({
                "company_name": data['Name'][ind],
                "address": data['Address'][ind],
                "phone": data['Phone'][ind]
                }).execute()
            #obtain generated id 
            contractor_ids = supabase.table(CONTRACTOR).select("id").eq("company_name", data['Name'][ind]).execute()
            contractor_id = contractor_ids.data[0]['id']
            '''inster the license code here too'''
            supabase.table(LICENSES).insert({
                "license_number": license_number,
                "license_type": license_type,
                "town": town,
                "license_expiration": license_expiration,
                "insurance_expiration": insurance_expiration,
                "is_active": is_active,
                "contractor_id": contractor_id,
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
    pages = input("How many pages would you like to scrape? ")
    main(int(pages))



'''
- add a default for pages (set it to 1 page), 
'''