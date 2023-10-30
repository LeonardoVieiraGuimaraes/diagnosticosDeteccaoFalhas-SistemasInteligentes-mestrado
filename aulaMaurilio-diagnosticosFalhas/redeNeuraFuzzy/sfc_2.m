function [ C ] = sfc_2(X)

%% __________________ SFC_2 __________________
%  Sistema Fuzzy para Classificacao de Padroes             
%        (para 2 classes e com 4 regras)         
%
% (c) Prof. Maurílio J. Inácio  
% Eng. de Sistemas / Unimontes -  2016
%
% [ C ] = sfc_2(X)
%
% C = vetor de indice da classe
% X = vetor de entrada de dados
%
% Implementado em OCTAVE (ver. 4.0.3)
%

clc;
close all;
more off;

fprintf('\n __________________ SFC_2 __________________');
fprintf('\n Sistema Fuzzy para Classificacao de Padroes');  
fprintf('\n       (para 2 classes e com 4 regras)      ');  
fprintf('\n                                            ');
fprintf('\n (c) Prof. Maurílio J. Inácio               '); 
fprintf('\n Eng. de Sistemas / Unimontes - 2016        ');


%% Paramentros iniciais

nd = size(X,1); % número de dados de entrada

% Parametros das funcoes de pertinencia triangulares da entrada x1
F11 = [0 1 2]; % pequeno
F12 = [1 2 3]; % grande

% Parametros das funcoes de pertinencia triangulares da entrada x2
F21 = [1 2 3]; % pequeno
F22 = [2 3 4]; % grande

for (k = 1 : nd)
  
  % fuzzyficacao
  mu_x11 = trimf(X(k), F11);
  mu_x12 = trimf(X(k), F12);
  mu_x21 = trimf(X(k), F21);
  mu_x22 = trimf(X(k), F22);
  
  % calculo da agregacao dos antecedentes das regras (op. produto)
  mu_r1 = mu_x11 * mu_x21; % x1 eh pequeno e x2 eh pequeno
  mu_r2 = mu_x11 * mu_x22; % x1 eh pequeno e x2 eh grande
  mu_r3 = mu_x12 * mu_x21; % x1 eh grande e x2 eh pequeno
  mu_r4 = mu_x12 * mu_x22; % x1 eh grande e x2 eh grande
  
  % calculo da agregacao das regras (op. maximo)
  mu_y1 = max([mu_r3 mu_r4]); % classe 1
  mu_y2 = max([mu_r1 mu_r2]); % classe 2
  
  % defuzzyficacao
  [val idc] = max([mu_y1 mu_y2]);
  
  % saida do sistema (indice da classe)
  C(k) = idc;
  
end
  