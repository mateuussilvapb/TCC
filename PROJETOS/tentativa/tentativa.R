library(recommenderlab) #Bibliotecas utilizadas para carregar dados e montar recomenda��es
library(tidyverse)
library(data.table)

setwd("C:/Users/MATEUS/Documents/R/dados") #Local de arquivo de treinamento

dados <- fread("dadosTreinamento.txt", header = TRUE, sep = "\t", fill = TRUE) #Dados carregados em vari�vel

names(dados)[2:3] <- c("IdArtist", "IdUser")

dadosGrupo <- group_by(dados, IdUser, IdArtist) #Agrupando os dados

dadosGrupo2 <- summarise(dadosGrupo, count = n()) #Gerando tabela com soma da quantidade de vezes que cada usu�rio ouviu determinado artista
dadosGrupo2 <- as.data.frame(dadosGrupo2) #Convertendo dadosGrupo2 para data.frame

matrizAfinidade <- as(dadosGrupo2, "realRatingMatrix") #Matriz real de dados

Rec.model<-Recommender(matrizAfinidade, method = "UBCF")

usuarios <- length(unique(dadosGrupo2$IdUser))

listaRecomendacoes <- vector("list", usuarios)

for (i in 1:usuarios) {
  itemRecomendado <- predict(Rec.model, matrizAfinidade[i,], n=5)
  listaRecomendacoes[[i]] <- as((itemRecomendado), "list")
}

#Lembrete1: para extrair as 5 recomenda��es de um usu�rio qualquer, utilizar listaRecomendacoes[i]. i = indice do usuario espec�fico.
#Lembrete2: para extrair uma recomenda��o espec�fica de qualquer usu�rio (por exemplo, o usu�rio n�mero 7687), utilizar listaRecomendacoes[[1]]$`7687`[1]
#Lembrete3: para extrair o id de um usuario espec�fico a partir da listaRecomendacoes, utilizar a fun��o names. Exemplo: names(listaRecomendacoes[[1]])
#Lembrete4: para extrair a lista de todos os usu�rios no vetor listaRecomendacoes, utilizar a fun��o sapply. Exemplo: sapply(listaRecomendacoes, names)
#Lembrete5: para extrair as informa��es do data.frame dados, sobre o album recomendado, utilizar subset(seuDataFrame, seuDataFrame$colunaID == valorID). Exemplo: subset(dados, dados$`album-id` == listaRecomendacoes[[1]]$`7687`[1])