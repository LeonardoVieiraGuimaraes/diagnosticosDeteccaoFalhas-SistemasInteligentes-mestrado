function [ Ysv Eqmv  ] = anfis2_opr(C, Sigma, P, Q, Xv, Yv)

% _________________ ANFIS2_OPR _________________
%   Adaptative Neurofuzzy Inference System V.2  
%              (funcao de operacao)              
%       
% (c) Prof. Maurílio J. Inácio  
% Eng. de Sistemas / Unimontes -  2016
%
% [ Ysv Eqmv  ] = anfis2_opr(C, Sigma, P, Q, Xv, Yv)
%
% Ysv = saida de validacao
% Eqmv = erro quadratico medio de validacao
% C, Sigma, P, Q = parametros da rede
% Xv = amostras de dados de entrada de validacao
% Yv = amostras de dados de saida de validacao
%
% Implementado em OCTAVE (ver. 4.0.3)

%close all;
%clc;
more off;

fprintf('\n_________________ ANFIS2_OPR _________________');
fprintf('\n  Adaptative Neurofuzzy Inference System V.2  ');
fprintf('\n              (funcao de operacao)            ');
fprintf('\n                                              ');
fprintf('\n(c) Prof. Maurílio J. Inácio                  ');
fprintf('\nEng. de Sistemas / Unimontes -  2016          ');

% Parâmentros iniciais
N = size(Xv, 2);  % Numero de entradas
M = size(C, 2);  % Numero de funcoes de pertinencia
Npv = size(Xv,1); % Numero de amostras de dados de treinamento

Eqmv = 0;

% Loop de validacao
for k = 1 : Npv
    
    % Calculo a saida
    [ Ysv(k) Y W B ] = Calcula_Saida(M, N, Xv(k,:), P, Q, C, Sigma);
    
    % Calcula erro quadratico medio de validacao
    Eqmv = Eqmv + (1 ./(2 .* Npv)) .* sum((Ysv(k) - Yv(k)) .^2);
    
end

return;

% Funcao Calcula_Saida
function [ Ys Y W b ] = Calcula_Saida(M, N, X, P, Q, C, Sigma);
  sWjYj = 0;
  sWj = 0;
  for j = 1 : M
      som = 0;
      prod = 1;
      for i = 1 : N
          som = som + P(i,j) * X(i);         
          prod = prod .* (exp( -1/2 .* (((X(i) - C(i,j)) ./ Sigma(i,j)) .^ 2)));
      end
     Y(j) = som + Q(j);
     W(j) = prod;
     sWjYj = sWjYj + (W(j) .* Y(j));
     sWj = sWj + W(j);
  end
  Ys = sWjYj ./ sWj;
  b = sWj;
return;