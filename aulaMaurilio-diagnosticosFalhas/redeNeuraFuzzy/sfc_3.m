function [ C ] = sfc_3(X)

%% __________________ SFC_3 __________________
%  Sistema Fuzzy para Classificacao de Padroes             
%        (para 2 classes e com 16 regras)         
%
% (c) Prof. Maurílio J. Inácio  
% Eng. de Sistemas / Unimontes -  2016
%
% [ C ] = sfc_3(X)
%
% C = vetor de indice da classe
% X = vetor de entrada de dados
%
% Implementado em OCTAVE (ver. 4.0.3)
%

clc;
close all;
more off;

fprintf('\n __________________ SFC_3 __________________');
fprintf('\n Sistema Fuzzy para Classificacao de Padroes');  
fprintf('\n       (para 2 classes e com 16 regras)     ');  
fprintf('\n                                            ');
fprintf('\n (c) Prof. Maurílio J. Inácio               '); 
fprintf('\n Eng. de Sistemas / Unimontes - 2016        ');

%% Paramentros iniciais

nd = size(X,1); % número de dados de entrada

% Parametros das funcoes de pertinencia triangulares da entrada x1
F11 = [-1 0 1]; % pequeno
F12 = [0 1 2]; % medio baixo
F13 = [1 2 3]; % medio alto
F14 = [2 3 4]; % grande

% Parametros das funcoes de pertinencia triangulares da entrada x2
F21 = [0 1 2]; % pequeno
F22 = [1 2 3]; % medio baixo
F23 = [2 3 4]; % medio alto
F24 = [3 4 5]; % grande

for (k = 1 : nd)
  
  % fuzzyficacao
  mu_x11 = trimf(X(k), F11);
  mu_x12 = trimf(X(k), F12);
  mu_x13 = trimf(X(k), F13);  
  mu_x14 = trimf(X(k), F14);  
  mu_x21 = trimf(X(k), F21);
  mu_x22 = trimf(X(k), F22);
  mu_x23 = trimf(X(k), F23);
  mu_x24 = trimf(X(k), F24);
  
  % calculo da agregacao dos antecedentes das regras (op. produto)
  mu_r1 = mu_x11 * mu_x21; % x1 eh pequeno e x2 eh pequeno
  mu_r2 = mu_x11 * mu_x22; % x1 eh pequeno e x2 eh medio baixo
  mu_r3 = mu_x11 * mu_x23; % x1 eh pequeno x2 eh medio alto
  mu_r4 = mu_x11 * mu_x24; % x1 eh pequeno e x2 eh grande
  mu_r5 = mu_x12 * mu_x21; % x1 eh medio baixo e x2 eh pequeno
  mu_r6 = mu_x12 * mu_x22; % x1 eh medio baixo e x2 eh medio baixo
  mu_r7 = mu_x12 * mu_x23; % x1 eh medio baixo e x2 eh medio alto
  mu_r8 = mu_x12 * mu_x24; % x1 eh medio baixo e x2 eh grande
  mu_r9 = mu_x13 * mu_x21; % x1 eh medio alto e x2 eh pequeno
  mu_r10 = mu_x13 * mu_x22; % x1 eh medio alto e x2 eh medio baixo
  mu_r11 = mu_x13 * mu_x23; % x1 eh medio alto e x2 eh medio alto
  mu_r12 = mu_x13 * mu_x24; % x1 eh medio alto e x2 eh grande
  mu_r13 = mu_x14 * mu_x21; % x1 eh grande e x2 eh pequeno
  mu_r14 = mu_x14 * mu_x22; % x1 eh grande e x2 eh medio alto
  mu_r15 = mu_x14 * mu_x23; % x1 eh grande e x2 eh medio baixo
  mu_r16 = mu_x14 * mu_x24; % x1 eh grande e x2 eh grande
  
  % calculo da agregacao das regras (op. maximo)
  mu_y1 = max([mu_r9 mu_r10 mu_r11 mu_r12 mu_r13 mu_r14 mu_r15 mu_r16]); % classe 1
  mu_y2 = max([mu_r1 mu_r2 mu_r3 mu_r4 mu_r5 mu_r6 mu_r7 mu_r8]); % classe 2
    
  % defuzzyficacao
  [val idc] = max([mu_y1 mu_y2]);
  
  % saida do sistema (indice da classe)
  C(k) = idc;
  
end