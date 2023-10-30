# -*- coding: utf-8 -*-
"""
Created on Sun Sep 28 21:25:03 2014

@author: LEONARDO
"""

from dadosheart import heart
from gaussclasse import gauss

while (True):
    print("O problema 1 voce deverar digitar as medias,  quantidades de amostras")
    print("e o desvio. Com os dados  teremos uma  matriz de  valores aleatorios.")
    print("Neste problema voce poderar fazer o treinamento a validacao e receber")
    print("a porcetagem de  acertos e os pesos salvo na pasta arquivo. E poderar")
    print("fazer teste com e  sem  superposicao e plotar os grafico de erro e da")
    print("reta salvo na pasta arquivo \n")
    print("O problmea 2  ira ler os valores  do  arquivo/heart.txt retornado uma")
    print("matriz. Este sistema ira realizar o treinamento a validacao e receber")
    print("a porcentagem de acertos,  pessos e plotar o grafico do erro salvo na")
    print("pasta arquivo\n")
    print("A taxa de aprendizagem tem o valor 0.01\n")
    print("Os pesos e o bias tem valores aleatorios entre 0 e 1\n")
    print("Os graficos imprime todos os valores do erro e 	pesos, portanto para")
    print("portanto pode ser que voce precise dar um  zoon nos graficos para ver")
    print("os valores de erro e peso com mais detalhes\n")

    resposta = raw_input("Digite 1 para o problema 1, 2 para o problema 2 e 3 para sair--------->")
    
    if resposta == '1':
        p = gauss()
        p.executar()
    if resposta == '2':
        d = heart()
        d.dadosheart()
        d.executar()
    if resposta == '3':
        break  
    