library(recommenderlab, tidyverse, dplyr) #Bibliotecas utilizadas para carregar dados e montar recomenda��es

install.packages("recommenderlab")
setwd("C:/Users/MATEUS/Documents/R/dados") #Local de arquivo de treinamento


dadosMatriz <- as(dados, "realRatingMatrix") #Matriz real de dados

Rec.model<-Recommender(dadosMatriz[1:5000], method = "UBCF") # (Rec.model?); (dadosMatriz [1,5000]?); (method = UBCF: acredito ser o m�todo utilizado para fazer a filtragem 'User based colaborative filtering'.)

itemRecomendado <- predict(Rec.model, dadosMatriz[1,], n=5) # Linhas 11 e 12, n�o entendo o que fazem.
as(itemRecomendado, "list")

itemRecomendadoTop3 <- bestN(itemRecomendado, n = 3) # Pelo que li, algo sobre os 3 itens recomendados ou algo do tipo.
as(itemRecomendadoTop3, "list")

previsaoAfinidadeItemRecomendado <- predict(Rec.model, dadosMatriz[1,], type="ratings") # Linhas 17 e 18, n�o entendo o que fazem.
as (previsaoAfinidadeItemRecomendado, "list")