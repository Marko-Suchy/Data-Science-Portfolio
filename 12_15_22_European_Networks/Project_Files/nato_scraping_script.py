from bs4 import BeautifulSoup
import requests
import re
import pandas as pd

node_list = ["Austria", "Belgium", "Bulgaria", "Croatia", "Czech Republic", "Cyprus", 
"Denmark", "Estonia", "Finland", "France", "Germany", "Greece", 'Hungary', "Iceland", 
"Ireland", "Israel", "Italy", "Latvia", "Luxembourg", 'Netherlands', 'Norway','Poland', 
"Portugal", "Romania", "Russia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", 
"Turkey", 'United Kingdom', "Ukraine"]

#Make Master Lists!
  #Type can be nato war or supporting

edge_list_df = pd.DataFrame(columns = ["Country 1", "Country 2"])
edge_attribute_df = pd.DataFrame(columns = ["type"])


nato_url = "https://en.wikipedia.org/wiki/Member_states_of_NATO"
html_content = requests.get(nato_url).text
soup = BeautifulSoup(html_content, "lxml")
tables = soup.find_all("table")

nato_df = pd.read_html(str(tables[0]))
nato_df =  pd.DataFrame(nato_df[0])

nato_df = nato_df.drop(["Flag", "Map", "Capital", "Accession[9]", "Population[a]", "Area[11]"], axis=1)


member_states = []
for node in node_list:
  for index, row in nato_df.iterrows():
    if row["Member state"] == node:
      member_states.append(node)
      
len(member_states)
for index in range(len(member_states)):
  country1 = member_states[index]
  for country2 in member_states[index:len(member_states)]:
    edge_pair = [country1, country2]
    edge_list_df.loc[len(edge_list_df)] = edge_pair
    edge_attribute_df.loc[len(edge_attribute_df)] = "nato"
    
    
print(edge_list_df)
print(edge_attribute_df)

edge_list_df.to_csv("military_edge_list", header = True, index = False)
edge_attribute_df.to_csv("military_edge_attribute", header = True, index = False)
    
    
    
    

