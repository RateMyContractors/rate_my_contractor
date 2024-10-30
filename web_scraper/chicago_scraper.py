import pandas as pd
import numpy as np
import time
import platform
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions


current_os = platform.system()

if current_os == "Windows":
    service = Service(executable_path="drivers/chromedriver.exe")  
elif current_os == "Darwin": 
    service = Service(executable_path="drivers/chromedriver")  
else:
    raise Exception("Unsupported operating system")


options = webdriver.ChromeOptions()
options.add_argument("--headless=new")

driver = webdriver.Chrome(options=options, service=service)
url = "https://webapps1.chicago.gov/licensedcontractors/all"

driver.get(url)
table = driver.find_element(By.ID, 'paginatedTable')
titles = table.find_elements(By.TAG_NAME, 'th')
table_titles = [title.text for title in titles]

table_content = []
wait = WebDriverWait(driver, 5)
current = 1
max = 3

table_rows = wait.until(expected_conditions.presence_of_all_elements_located((By.CSS_SELECTOR,'table#paginatedTable tbody tr')))

for row in table_rows:
    row_data = [item.text for item in row.find_elements(By.TAG_NAME, 'td')] 
    table_content.append(row_data)

while current < max: 
    try :
        next_bttn = driver.find_element(By.ID, 'paginatedTable_next')
        next_bttn.find_element(By.TAG_NAME, 'a').click()
        time.sleep(2)
        current +=1
        table_rows = wait.until(expected_conditions.presence_of_all_elements_located((By.CSS_SELECTOR,'table#paginatedTable tbody tr')))
        for row in table_rows:
            row_data = [item.text for item in row.find_elements(By.TAG_NAME, 'td')]             
            table_content.append(row_data)
    except Exception as e:
        break

data = pd.DataFrame(np.array(table_content), columns = table_titles)
data['Tags'] = data['License Type'].apply(lambda x: "General" if "General Contractor" in x 
                                        else "Electrical" if "Electrical Contractor" in x 
                                        else "Elevator Mechanic" if "Elevator Mechanic Contractor" in x 
                                        else "Mason" if "Mason Contractor" in x 
                                        else "Plumbing" if "Plumbing Contractor" in x 
                                        else "")

print(data)
data.to_csv('contractor.csv', index=False)
driver.quit()


