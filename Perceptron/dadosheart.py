# -*- coding: utf-8 -*-
"""
Created on Sun Sep 28 00:59:26 2014

@author: LEONARDO
"""
from __future__ import division
import sys
from perceptron import perceptron
from numpy import array, argsort, loadtxt

class heart(object):
    def dadosheart(self):    
        heart = open("arquivos/heart.txt", "r")#abre o arquivo heart.txt
        dados = loadtxt("arquivos/heart.txt")#retorna uma matriz dos valores do heart.txt
        heart.close()
        dados = dados[dados[:,-1].argsort(),]#ordena a matriz em ordem crescente com realação a ultima coluna
        dados = array(dados)#transforma uma lista em um array
        dados = dados.T#Faz a transporta da matriz obtida do heart.txt
        valord = dados[len(dados)-1, 0:(len(dados[0]))]-1#Retira da matriz dado o valor desejado 
        entrada = dados[0:len(dados)-1, 0:(len(dados[0]))]#Retira a matriz o valor de entrada, portanto retira o valor desejado
        self.entrada = array(entrada)#converte a lista entrada em array
        self.valord = array(valord)#converte a lista valord em array
        print self.entrada
    def executar(self):
        reposta = raw_input("Pressione 1 para executar o treinamento---->")
        if reposta == '1':
            q = input("Digite a quantidade de repeticoes---------->") 
            p = perceptron()
            p.treinamento(self.entrada, self.valord, q)
            reposta = raw_input("Pressione 1 para executar a validacao--->")
            if reposta == '1':        
                p.validacao(self.entrada, self.valord)
            reposta = raw_input("Pressione 1 para plotar o erro---------->")
            if reposta == '1': 
                p.ploterro()
#Nao inicia quando e chamado fora do bloco. Quando e chamado como uma biblioteca    
if __name__=="__main__":#faz  a execução da class heart
    while True:    
        p = heart()
        p.dadosheart()
        p.executar()