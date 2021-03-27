library(recommenderlab) #Bibliotecas utilizadas para carregar dados e montar recomendações
library(tidyverse)
library(data.table)

setwd("C:/Users/MATEUS/Documents/R/dados") #Local de arquivo de treinamento

dados <- fread("dadosTreinamento.txt", header = TRUE, sep = "\t", fill = TRUE) #Dados carregados em variável

names(dados)[2:3] <- c("IdArtist", "IdUser")

dadosGrupo <- group_by(dados, IdUser, IdArtist) #Agrupando os dados

dadosGrupo2 <- summarise(dadosGrupo, count = n()) #Gerando tabela com soma da quantidade de vezes que cada usuário ouviu determinado artista
dadosGrupo2 <- as.data.frame(dadosGrupo2) #Convertendo dadosGrupo2 para data.frame

matrizAfinidade <- as(dadosGrupo2, "realRatingMatrix") #Matriz real de dados

Rec.model<-Recommender(matrizAfinidade, method = "UBCF")

usuarios <- length(unique(dadosGrupo2$IdUser))

listaRecomendacoes <- vector("list", usuarios)

for (i in 1:usuarios) {
  itemRecomendado <- predict(Rec.model, matrizAfinidade[i,], n=5)
  listaRecomendacoes[[i]] <- as((itemRecomendado), "list")
}

#Lembrete1: para extrair as 5 recomendações de um usuário qualquer, utilizar listaRecomendacoes[i]. i = indice do usuario específico.
#Lembrete2: para extrair uma recomendação específica de qualquer usuário (por exemplo, o usuário número 7687), utilizar listaRecomendacoes[[1]]$`7687`[1]
#Lembrete3: para extrair o id de um usuario específico a partir da listaRecomendacoes, utilizar a função names. Exemplo: names(listaRecomendacoes[[1]])
#Lembrete4: para extrair a lista de todos os usuários no vetor listaRecomendacoes, utilizar a função sapply. Exemplo: sapply(listaRecomendacoes, names)
#Lembrete5: para extrair as informações do data.frame dados, sobre o album recomendado, utilizar subset(seuDataFrame, seuDataFrame$colunaID == valorID). Exemplo: subset(dados, dados$`album-id` == listaRecomendacoes[[1]]$`7687`[1])