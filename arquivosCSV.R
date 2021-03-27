library(recommenderlab) #Bibliotecas utilizadas para carregar dados e montar recomendações
library(tidyverse)
library(data.table)
library(igraph)

setwd("C:/Users/MATEUS/Documents/R/dados") #Local de arquivo de treinamento

dadosBand <- fread("Band.csv", header = TRUE, sep = ",")
dadosMusicalArtist <- fread("MusicalArtist.csv", header = TRUE, sep = ",")
dadosGenero <- fread("MusicGenre.csv", header = TRUE, sep = ",")

linhas <- c(1:3) #vetor para descartar linhas desnecessárias da tabela
dadosBandOrg <- dadosBand[-linhas,]
dadosMusicalArtistOrg <- dadosMusicalArtist[-linhas,]
dadosGeneroOrg <- dadosGenero[-linhas,]

names(dadosBandOrg)[2] <- c("nome") 
names(dadosBandOrg)[43] <- c("genero")
names(dadosMusicalArtistOrg)[2] <- c("nome") 
names(dadosMusicalArtistOrg)[43] <- c("genero")
names(dadosGeneroOrg)[2] <- c("genero") 
names(dadosGeneroOrg)[9] <- c("subgenero")

dadosFiltradosBand <- subset(dadosBandOrg, select = c(nome, genero))
dadosFiltradosMusicalArtist <- subset(dadosMusicalArtistOrg, select = c(nome, genero))
dadosFiltradosGenre <- subset(dadosGeneroOrg, select = c(genero, subgenero))

dadosUnidos <- rbind(dadosFiltradosBand, dadosFiltradosMusicalArtist)

matrizGeneros <- matrix(data = 0, nrow = 1229, ncol = 1229)


#grafo <- fread("generosFinal.csv", header = TRUE, sep = ",")
#grafo <- as.matrix(grafo)
#g <- graph.adjacency(grafo, mode="undirected", weighted = TRUE)
