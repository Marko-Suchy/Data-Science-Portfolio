import pandas as pd


node_list = ["Austria", "Belgium", "Bulgaria", "Croatia", "Czech Republic", "Cyprus", 
"Denmark", "Estonia", "Finland", "France", "Germany", "Greece", 'Hungary', "Iceland", 
"Ireland", "Israel", "Italy", "Latvia", "Luxembourg", 'Netherlands', 'Norway','Poland', 
"Portugal", "Romania", "Russia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", 
"Turkey", 'United Kingdom', "Ukraine"]

df = pd.read_csv("alliance_v4.1_by_dyad.csv")

#FILTER FOR ALLIANCES THAT DO NOT HAVE AN END DATE
df = df[df["dyad_end_year"].isnull()]

edge_list = pd.DataFrame(columns = ["country 1", "country 2"])
edge_attributes = pd.DataFrame(columns = ["defense", "neutrality", "nonaggression", "entente", "asymmetric"])

#Get Edge List data frame!
for index, row in df.iterrows():
  if row["state_name1"] in node_list and row["state_name2"] in node_list:
    data = [row["state_name1"], row["state_name2"]]
    edge_list.loc[len(edge_list.index)] = data

#Get edge attributes
for index, row in df.iterrows():
  if row["state_name1"] in node_list and row["state_name2"] in node_list:
    data = [row["defense"], row["neutrality"], row["nonaggression"], row["entente"], row["asymmetric"]]
    edge_attributes.loc[len(edge_attributes.index)] = data

joined_df = edge_list.join(edge_attributes)

#COMBINE rows
#combined_df = joined_df.groupby(["country 1"]).sum()

# for index, row in combined_df.iterrows():
#   #Iterate form index to the rest
#   if row["defense"] > 1:
#     row["defense"] = 1


#sort edge list and export it! 
  #Actually it doesn't need to be sorted ... just ligned up
print(edge_list)
print(edge_attributes)
edge_list.to_csv("alliance_edge_list", header = True, index = False)
edge_attributes.to_csv("alliance_edge_attributes", header = True, index = False)

joined_df = edge_list.join(edge_attributes)
joined_df.to_csv("joined_df", index = False)
print(joined_df)

