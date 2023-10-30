% Gera falhas no sistema de acionamento C.C.

close all;
clear;
clc;

fprintf('\n___ GERA FALHAS NO SISTEMA DE ACIONAMENTO C.C.\n')

% variaveis de entrada e saida do sistema
X = [];
Y = [];

% fator de seleção de intervalo
sel_int = 0.50;

% Primeira falha
fprintf('\n* Escolha a 1a falha ...\n\n')
Xaux = [];
Yaux = [];
[Xaux, Yaux] = motor_cc;
X1 = Xaux((sel_int*end:end),3:5);
X = [X ; X1]; 
Y1 = [ones(size(X1,1),1) zeros(size(X1,1),1) zeros(size(X1,1),1) zeros(size(X1,1),1)];
Y = [Y ; Y1];

% Segunda falha
fprintf('\n* Escolha a 2a falha ...\n\n')
Xaux = [];
Yaux = [];
[Xaux, Yaux] = motor_cc;
X2 = Xaux((sel_int*end:end),3:5);
X = [X ; X2]; 
Y2 = [zeros(size(X2,1),1) ones(size(X2,1),1) zeros(size(X2,1),1) zeros(size(X2,1),1)];
Y = [Y ; Y2];

% Terceira falha
fprintf('\n* Escolha a 3a falha ...\n\n')
Xaux = [];
Yaux = [];
[Xaux, Yaux] = motor_cc;
X3 = Xaux((sel_int*end:end),3:5);
X = [X ; X3]; 
Y3 = [zeros(size(X3,1),1) zeros(size(X3,1),1) ones(size(X3,1),1) zeros(size(X3,1),1)];
Y = [Y ; Y3];

% Quarta falha
fprintf('\n* Escolha a 4a falha ...\n\n')
Xaux = [];
Yaux = [];
[Xaux, Yaux] = motor_cc;
X4 = Xaux((sel_int*end:end),3:5);
X = [X ; X4]; 
Y4 = [zeros(size(X4,1),1) zeros(size(X4,1),1) zeros(size(X4,1),1) ones(size(X4,1),1)];
Y = [Y ; Y4];