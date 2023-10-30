# -*- coding: utf-8 -*-
"""
Created on Wed Sep 24 19:36:09 2014

@author: LEONARDO
"""
from __future__ import division
from sklearn import *

from perceptron import perceptron
from numpy import *
from math import *
class gauss(object):

    def gaussclass(self,numeropadroes, medias, desviopadrao):
        dimensao = len(medias)#tamanho do veto medias
        x = random.randn(dimensao, numeropadroes) #Monta matriz como valores aleatorios entre 0 e 1 com linha = dimensão e coluna = numerospadrões
        m = tile(medias, numeropadroes) #faz repetição da matriz medias com n = numeros padrões vezes
        classe = m + desviopadrao*x #Gera a distribuição Gaussiana com 2 parametros e numerosadrões de amostras
        return classe

    def executar(self):#faz a execuação de usuario onde constroi as duas classses usando gaussclass
        amostra = input("Digite quantos amostra---------------->")
        a = input("Digite a media classe a -------------->")
        b = input("Digite a media classe b -------------->")
        desvio = input("Digite o desvio padrao --------------->")
        classea = self.gaussclass(amostra, [[a],[a]], desvio)#cria uma classe com media a
        classeb = self.gaussclass(amostra, [[b],[b]], desvio)#cria uma classe com media b
        classea = array(classea)#tranfroma a lista em um array
        classeb = array(classeb)#tranfroma a lista em um array
        da = [1]*len(classea[0])#cria os valores esperados para classe a, sendo 1
        db = [0]*len(classeb[0])#cria os valores epserados para classe b, sendo 9
        dclasse = concatenate((da,db), axis = 0)#crias a matrizes de valores esperados
        #print(dclasse)
        classe = concatenate((classea,classeb), axis=0)#Cria a matriz de classe
        classe = matrix(classe)#tranforma a lista classe  em um array
        dclasse = matrix(dclasse)#tranforma a lista de valores epserados em um array
        #print classe
        return classe, dclasse

#Nao inicia quando e chamado fora do bloco. Quando e chamado como uma biblioteca    
if __name__=="__main__":#faz  a execução da class gaussclass
    

    p = gauss()
    x,y = p.executar()
    x = array(x)
    y = array(y)
    print(x,y)
    # Import Library
    # Import other necessary libraries like pandas, numpy...

    # Load Train and Test datasets
    # Identify feature and response variable(s) and values must be numeric and numpy arrays
    x_train = x
    y_train = y
    x_test = x
    # Create linear regression object
    linear = linear_model.LinearRegression()
    # Train the model using the training sets and check score
    linear.fit(x_train, y_train)
    linear.score(x_train, y_train)
    # Equation coefficient and Intercept
    print('Coefficient: \n', linear.coef_)
    print('Intercept: \n', linear.intercept_)
    # Predict Output
    predicted = linear.predict(x_test)


