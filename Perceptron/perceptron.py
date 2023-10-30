# -*- coding: utf-8 -*-
"""
Created on Fri Sep 26 19:08:07 2014

@author: LEONARDO
"""

from __future__ import division
from numpy import matrix, arange, concatenate, loadtxt, amax
from numpy.random import random_sample, shuffle
from matplotlib.pyplot import *
from math import *

class perceptron(object):

    def execucao(self, x):      #recebe cada entrada das amostras   
        x = matrix(x)           #Realiza o produto escalar entre os pesos e de cada entrada 
        u = matrix(self.w)*x
        u = u[0,0]              #Faz a verificação de u e determina y
        if u >= 0:
            y = 1
        if u < 0:
            y = 0
        return y    
      
    def validacao(self, xvalidacao, d):     #Recebe o x para validação e o valor que se espera da amostra  
        yvalidacao = [0]*len(xvalidacao[0])#inicializa o vetor obtido y
        bias = [-1]*len(xvalidacao[0])#determina o tamanho da bias sendo seus valores igual a -1
        xvalidacao = concatenate((xvalidacao,[bias]), axis=0) #concateção do vetor de entrada com o bias     
        xvalidacao = matrix(xvalidacao)#converte lista para matrix
        cont = 0 
        for j in range(0,len(yvalidacao)):#Faz a execuação de cada valor para verificar a qual classe pertence
            yvalidacao[j] = self.execucao(xvalidacao[0:len(xvalidacao),j])
            if yvalidacao[j] == d[j]:#Conta quando do valor esperado for igual ao desejado
                cont = cont + 1         
        print "valores validaddos---------", yvalidacao #imprime os valores validados
        print "Porcentagem de validacao---", (cont/len(yvalidacao))*100 #imprime a porcentagem de validações             
        return yvalidacao
        
    def treinamento(self, x, d, q):#Recebe as entradas, o valor esperado e quantidades de iterações
        errosepocas = open("arquivos/ErrosEpocas.txt","w")#Inicializa os arquivos ErrosEpocas.txt e Pesos.txt
        pesos = open("arquivos/Pesos.txt","w")
        self.x = x #Torna a entradas como variavel global
        n = 0.01
              
        bias = [-1]*len(d)#Crias o vetor bias igual a -1 referenta ao tamanho da amostra
        x = concatenate((x,[bias]), axis=0)#Faz a concatenação entre as entradas e o bias
        x = matrix(x)#transforma entrada x em uma matriz
        y = [0]*len(d)#inicializa o vetro esperado y com valores igual a 0
        e = [0]*len(d)#inicializa uma lista de erro e com valores igual a 0
        w = random_sample(len(x))#inicializa os pesos w para valores aleatorios entre 0 e 1 e torna o w global
        self.w = w/4 #divide os valores dos peso deixand ainda menor o seu valor      
        p = arange(len(d))#cira lista p de 0 até a quantidade de amostras, com numeros inteiros
        shuffle(p)#Mistura aleatoriamente os valores contido nas lista p, nesta parte onde temos as amostras aleatorias
        iteracao = 0#inicializa a iteração que a epocas que serão realizadas
       
        for k in range(0, q):#For de 0 até o valor determinado pelo usuarios de epocas
            vetorerro = 0          
            cont = 0#inicializa o cont para a contagem de valores esperado igual ao obtido
            for j in p:#realiza o for para cada valor da lista p
                iteracao = iteracao + 1 # contagem das quantiades de epocas
                y[j] = self.execucao(x[0:len(x),j])#chama a função para obtenção do obtido y
                e[j] = d[j] - y[j]#obtem o erro
                vetorerro = vetorerro + pow(e[j],2)#obtem o erro quadrado medio de cada epoca
                pesos = open("arquivos/Pesos.txt", "a+")#salva os pesos w em Pesos.txt
                pesos.write(str(self.w) +"\n")
                pesos.close()
                for i in range(0, len(self.w)):#ajusta os pesos, para cada epoca. sendo e = 0 nao ocorrera ajuste.
                    self.w[i] = self.w[i] + e[j]*n*x[i,j]   
                if y[j] == d[j]:#Se o valor obtido for igual ao desejado faz a contagem
                    cont = cont + 1
            
            vetorerro = vetorerro/len(d)
            errosepocas = open("arquivos/ErrosEpocas.txt", "a+")#salva os vetorerro em ErrosEpocas.txt
            errosepocas.write(str(vetorerro) + "\n" )
            errosepocas.close() 
            if cont == len(d):# se a contagem for igual a quantidade de amostras para o primeiro for
                break
        if iteracao == (q)*len(d): # Se a iteração obtida for igual a possiveis iterrações imprime
            print "As amostras podem ter  superposicao ou"
            print "a quantidade de itercacoes foi pequena"
        print "Possiveis iterecoes---------------------", (q)*len(d)
        print "Iteracoes Realizadas--------------------", iteracao
        print "Treinamento executado vetor de pesos ---", self.w
        
    def ploterro(self):  #Abre o arquivo ErrosEpocas.txt e plota o grafico
        figure(1)
        valoreserro = loadtxt("arquivos/ErrosEpocas.txt")    
        xlabel('Iteracao')
        ylabel('Erro Medio')
        title('Erro Quadrado Medio')
        grid(True)
        eixo = amax(valoreserro) + 2
        ylim(-1,eixo)
        plot(valoreserro, "ro")
        savefig('arquivos/Erro.png')#salva na pasta arquivo o grafico gerado
        show()


        
    def plotretapesso(self):#Plota as amostras e a reta de decisão
        figure(2)
        xlabel('X2')
        ylabel('X1')
        title('Reta do Peso')
        grid(True)
        eixo = amax(self.x) + 2
        ylim(-1,eixo)
        xlim(-1,eixo)
        if self.w[0] == 0:#Equação da retas com os pesos obtidos para w[0] = 0
            x1 = arange(-100,100,0.01)
            x2 = self.w[2]/self.w[1]
            plot(x1,x2, self.x[0], self.x[1], "ro")
        else:#Equação da retas com os pesos obtidos para w[0] diferente de 0
            x2 = arange(-100,100,0.01)
            x1 = -(self.w[1]/self.w[0])*x2 + self.w[2]/self.w[0]
            plot(x1,x2, self.x[0], self.x[1], "ro")
        savefig('arquivos/Pesso.png') #salva o grafico gerado na pasta arquivos
        show()
        
    
if __name__=="__main__":#Simulação do  Perceptron com a entrada AND

    x = [[0,0,1,1], [0,1,0,1]]
    x = array(x)
    d = [0,1,1,1]
    d = array(d)
    p = perceptron()
    p.treinamento(x, d, 50)
    p.ploterro()
    p.plotretapesso()
    l = p.validacao([[1,0,0,1,0,0], [1,0,0,1,1,1]], [1,0,0,1,1,1])
    print l