from bs4 import BeautifulSoup
import requests
import re
import pandas as pd

#Define Node List
  #ALTERED RUSSIAN FEDERATION, SLOVAK REPUBLIC
node_list = ["Austria", "Belgium", "Bulgaria", "Croatia", "Czech Republic", "Cyprus", 
"Denmark", "Estonia", "Finland", "France", "Germany", "Greece", 'Hungary', "Iceland", 
"Ireland", "Israel", "Italy", "Latvia", "Luxembourg", 'Netherlands', 'Norway','Poland', 
"Portugal", "Romania", "Russian Federation", "Slovak Republic", "Slovenia", "Spain", "Sweden", "Switzerland", 
"Turkey", 'United Kingdom', "Ukraine"]

#Create edgelist df
edge_list_df = pd.DataFrame(columns = ["Country 1", "Country 2"])
edge_attributes_df = pd.DataFrame(columns = ["Trade", "Share Percent"]) 

#Get data from website

#I personally iterated this changing country name and link everytime.. that sucked!

url = "https://wits.worldbank.org/countrysnapshot/en/UKR"
country_name = "Ukraine"
html_content = requests.get(url).text
soup = BeautifulSoup(html_content, "lxml")
tables = soup.find_all("table", {'class':"table-striped"})
tables[4]

partners_df = pd.read_html(str(tables[4]))
partners_df =  pd.DataFrame(partners_df[0])

for index, row in partners_df.iterrows():
  for node in node_list:
    if row["Market"] == node:
      edge_list = [country_name, node]
      attribute_list = [row["Trade (US$ Mil)"], row["Partner share(%)"]]
      
      edge_list_df.loc[len(edge_list_df)] = edge_list
      edge_attributes_df.loc[len(edge_attributes_df)] = attribute_list
      
print(edge_list_df)
print(edge_attributes_df)

edge_list_df.to_csv("trade_edge_list", header = True, index = False)
edge_attributes_df.to_csv("trade_edge_attributes", header = True, index = False)
