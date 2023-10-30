%Rede neural do tipo de Mem�ria Matricial 
%Problema de recupera��o do valor de tens�o de um circuito resistivo 
%Autores:   J�natas Souza
%           Leonardo Vieira Guimaraes
%           Walen Nobre Cruz

clear all
x = rand(3);
%x = [1 1 5; 4 3 5;2 3 5] %% Corrente 1 , Resistencia 1 - Corrente 2, Resistencia 2) %% 
y = [1 12 6] %% Tensao de saida 1, Tensao de Saida 2 $$
M = y*x 
[q,r]=qr(x)
M = y*q
Y1 = M*(x(1,:)*pinv(r))' %% Tensao de saida 1 %%
Y2 = M*(x(2,:)*pinv(r))' %% Tensao de saida 2 %%

%% Adcionando mais valores a matriz
%% Adcionando valores a sa�da
%% Consegue-se recuperar os resultados de tensao
M*([3 4 5]*pinv(r))' %% Prova-se que sua generaliza��o � ruim, resultado deveria ser 20.. %%
 

