from bs4 import BeautifulSoup
import requests
import re
import pandas as pd

#Make a list of node names to make the countries!
  #AlTERED NODES: GREECE, CZECH REPUBLIC, UITED KINGDOM
node_list = ["Austria", "Belgium", "Bulgaria", "Croatia", "Czech Republic", "Cyprus", 
"Denmark", "Estonia", "Finland", "France", "Germany", "Greece", 'Hungary', "Iceland", 
"Ireland", "Israel", "Italy", "Latvia", "Luxembourg", 'Netherlands', 'Norway','Poland', 
"Portugal", "Romania", "Russia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", 
"Turkey", 'United Kingdom', "Ukraine"]

#Create Master DF
node_atttibute_df = pd.DataFrame(columns = ["node", "democracy_index", "press_freedom", "GDP", "population"])

for index in range(len(node_list)):
  node_atttibute_df.insert(index, "node", node_list[index], allow_duplicates = False)


#Democracy index!
democracy_index_url = "https://en.wikipedia.org/wiki/Democracy_Index"
html_content = requests.get(democracy_index_url).text
democracy_index_soup = BeautifulSoup(html_content, "html.parser")
tables = democracy_index_soup.find_all("table")

print(democracy_index_soup)

democracy_index_table = democracy_index_soup.find('table', {'class':"wikitable"})
democracy_index_tables = democracy_index_soup.find_all("table", {'class':"wikitable"})
print(len(democracy_index_tables))
print(democracy_index_tables[3])

democracy_index_df = pd.read_html(str(democracy_index_tables[3]))
democracy_index_df =  pd.DataFrame(democracy_index_df[0])


print(democracy_index_df)
democracy_index_df.head()
democracy_index_df = democracy_index_df.drop(["Region", "2021 rank", "Regime type", "2020", "2019", "2018", "2017", "2016","2015", "2014", "2013", "2012", "2011", "2010", "2008", "2006"], axis = 1)


testnodelist = []
clean_democracy_index_df = pd.DataFrame(columns = ["node", "democracy_index"])
for index, row in democracy_index_df.iterrows():
  for node in node_list:
    if row["Country"] == node:
      data_list = [node, row["2021"]]
      #print(data_list)
      clean_democracy_index_df.loc[len(clean_democracy_index_df)] = data_list
      
print(clean_democracy_index_df)
      
      
#Press Freedom Index

pressFreedom_url = "https://en.wikipedia.org/wiki/Press_Freedom_Index#:~:text=The%20Press%20Freedom%20Index%20is,records%20in%20the%20previous%20year."
html_content2 = requests.get(pressFreedom_url).text
pressFreedom_soup = BeautifulSoup(html_content2, "html.parser")
tables2 = pressFreedom_soup.find_all("table")

tables2[1]
pressFreedom_df = pd.read_html(str(tables2[1]))
pressFreedom_df = pd.DataFrame(pressFreedom_df[0])

pressFreedom_df = pressFreedom_df.drop(["2019[5]", "2018[6]","2017[7]", "2016[8]"], axis = 1 )

clean_pressFreedom_df = pd.DataFrame(columns = ["node", "press_freedom"])
for index, row in pressFreedom_df.iterrows():
  for node in node_list:
    if row["Country"] == node:
      data_list = [node, row["2020[4]"][5:-1]]
      clean_pressFreedom_df.loc[len(clean_pressFreedom_df)] = data_list
      
print(clean_pressFreedom_df)

#Make popultion Dataframe

population_url = "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
html_content3 = requests.get(population_url).text
population_soup = BeautifulSoup(html_content3, "html.parser")
tables3 = population_soup.find_all("table")

population_df = pd.read_html(str(tables3[0]))
population_df = pd.DataFrame(population_df[0])
population_df.columns = population_df.columns.droplevel(0)



population_df = population_df.drop(["Rank", "Notes", 'Date'], axis = 1)
population_df.columns
population_df = population_df.drop(index = "Source (official or from the United Nations)", axis = 1)


clean_population_df = pd.DataFrame(columns = ["node", "population"])
for index, row in population_df.iterrows():
  for node in node_list:
    if row["Country / Dependency"] == node:
      data_list = [node, row["Numbers"]]
      clean_population_df.loc[len(clean_population_df)] = data_list
      
print(clean_population_df)

#GDP dataframe (in US million)
GDP_url = "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)"
html_content4 = requests.get(GDP_url).text
GDP_soup = BeautifulSoup(html_content4, "html.parser")
tables4 = GDP_soup.find_all("table")

GDP_df = pd.read_html(str(tables4[2]))
GDP_df = pd.DataFrame(GDP_df[0])
GDP_df.columns = GDP_df.columns.droplevel(1)

GDP_df.columns = ['Country/Territory', 'UN Region', 'IMF[1]2', 'IMF[1]', 'World Bank[13]',
       'World Bank[13]2', 'United Nations[14]', 'United Nations[14]2']


clean_GDP_df = pd.DataFrame(columns = ["node", "GDP"])
for index, row in GDP_df.iterrows():
  for node in node_list:
    if row["Country/Territory"] == node:
      data_list = [node, row["World Bank[13]"]]
      clean_GDP_df.loc[len(clean_GDP_df)] = data_list
      
print(clean_GDP_df)


#Sort and comboine dataframes
sorted_democracy_index_df = clean_democracy_index_df.sort_values("node")
sorted_pressFreedom_df= clean_pressFreedom_df.sort_values("node")
sorted_population_df = clean_population_df.sort_values("node")
sorted_GDP_df = clean_GDP_df.sort_values("node")
      
master_df = sorted_democracy_index_df
master_df = master_df.merge(sorted_pressFreedom_df)
master_df = master_df.merge(sorted_population_df)
master_df = master_df.merge(sorted_GDP_df)

master_df.to_csv('node_attributes', header = True, index = False)
