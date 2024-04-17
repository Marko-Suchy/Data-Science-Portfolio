
library(statnet)
library(intergraph)

cultural_exchange_edgelist <- read.csv("cultural_exchange_edgelist")
cultural_strength <- read.csv("cultural_exchange_strength")

#Quantize strength (For now don't use this section, but it's cool to keep here)
for (row in 1:nrow(cultural_strenth[1])) {
  #ifelse(cultural_stregth[row, 1] > 0.7, cultural_stregth[row, 1], cultural_stregth[row, 1]<-0)
}
print(cultural_strength)

#Create and Plot network
EUnetwork <- as.network(cultural_exchange_edgelist)
  #Make Strength edge attribute
set.edge.attribute(EUnetwork, "weight", cultural_stregth[['strength']])
strength <- get.edge.attribute(EUnetwork, "weight")

#Set edge opacity and color and width

EUnetwork.ecol <- ifelse(EUnetwork %e% "weight" < .85, 
                         gray(1 - (EUnetwork %e% "weight"), alpha = (EUnetwork %e% "weight")^3), 
                         rgb(1, 0, 0, alpha = 1))
EUnetwork.ewidth <- ifelse(EUnetwork %e% "weight" < .85, 0, 5)

#Set intensity of color 
  #Make a vertex attribute for intensity
  set.vertex.attribute(EUnetwork, "avg_strength", 
                       value = sum(get.edge.value(EUnetwork, "strength")))
  #get the edges connected to a node
  get.vertex.attribute(EUnetwork, "avg_strength")
  #Sum the strength attribute of these edges

  #Set the vertex atrribute 

for (vertex in get.vertex.attribute(EUnetwork, "vertex.names")) {
  print(vertex)
  edge_data <- get.edges(EUnetwork, vertex)
  class(edge_data)
  #print(edge_sum)
}


#Plot the thang
op <- par(mar=c(0,0,0,0))
gplot(EUnetwork, gmode = "graph", displaylabels = TRUE, label.pos = 2, boxed.labels = T,
      label.border = 1,
      edge.col = EUnetwork.ecol, label.cex = .7)
par(op)
print(cultural_stregth[['strength']])

#Okay make it an igraph object
detach("package:statnet")
detach("package:sna")
library(igraph)
igraphNetwork <- asIgraph(EUnetwork)

strength(igraphNetwork) - min(strength(igraphNetwork))

weights <- strength(igraphNetwork) 
igraphNetwork_withWeights <- set_vertex_attr(igraphNetwork, "avg_weight", value = weights)

EUnet_withWeigths <- asNetwork(igraphNetwork_withWeights)
detach("package:igraph")
library(statnet)
print(EUnet_withWeigths)
set.vertex.attribute(EUnetwork, "avg_weight", weights - min(weights) + .1)
get.vertex.attribute(EUnetwork, "avg_weight")


EU.btwn <- betweenness(EUnetwork, gmode = "graph")
EU.clsns <- closeness(EUnetwork, gmode = "graph")
EUnetwork.vcol <- rgb(max(EU.btwn), max(EU.btwn) - EU.btwn, max(EU.btwn), maxColorValue = max(EU.btwn))

op <- par(mar=c(0,0,0,0))

gplot(EUnetwork, gmode = "graph", displaylabels = TRUE, label.pos = 2, boxed.labels = T,
      label.pad = .25, pad =  0,label.border = 1, edge.col = EUnetwork.ecol, edge.lwd = EUnetwork.ewidth,
      label.cex = .7, vertex.col = EUnetwork.vcol, edge.curve = T,
      vertex.cex = get.vertex.attribute(EUnetwork, "avg_weight")/3)

par(op)

print(EUnetwork)
