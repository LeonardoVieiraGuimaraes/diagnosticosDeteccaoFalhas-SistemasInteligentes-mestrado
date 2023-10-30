function [ Yst Eqmt C Sigma P Q ] = anfis2_trn(M, Nep, Alpha, Epsilon, Xt, Yt, Graf)

% _________________ ANFIS2_TRN _________________
%   Adaptative Neurofuzzy Inference System V.2  
%             (funcao de treinamento)     
%       
% (c) Prof. Maurílio J. Inácio  
% Eng. de Sistemas / Unimontes -  2016
%
% [ Yst Eqmt C Sigma P Q ] = anfis2_trn(M, Nep, Alpha, Xt, Yt, Graf)
%
% Yst = saida de treinamento
% Eqmt = erro quadratico medio por epoca de treinamento
% C, Sigma, P, Q = paramentros da rede
% M = Numero de funcoes de pertinencias
% Nep = Numero de epocas
% Alpha = taxa de aprendizagem
% Epsilon = limiar de erro
% Xt = amostras de dados de entrada de treinamento
% Yt = amostras de dados de saida de treinamento
% Graf = exibir gráficos (0 = não, 1 = sim)
%
% Implementado em OCTAVE (ver. 4.0.3)

%close all;
%clc;
more off;

fprintf('\n_________________ ANFIS2_TRN _________________');
fprintf('\n  Adaptative Neurofuzzy Inference System V.2  ');
fprintf('\n            (funcao de treinamento)           ');
fprintf('\n                                              ');
fprintf('\n(c) Prof. Maurílio J. Inácio                  ');
fprintf('\nEng. de Sistemas / Unimontes -  2016          ');

% Parâmentros iniciais
N = size(Xt, 2);  % Numero de entradas
Npt = size(Xt,1); % Numero de amostras de dados de treinamento
Xmin = min(Xt);
Xmax = max(Xt);
Yst = 0;

% Inicializacaoo dos parametros da rede
for j = 1 : M
    for i = 1 : N
        C(i,j) = (Xmax(i) - Xmin(i)) * rand + Xmin(i);
        Sigma(i,j) = 1 * rand + 0.001;
        P(i,j) = 2 * rand -1;
    end
    Q(j) = 2 * rand -1;
end

if (Graf == 1)
  % Exibe grafico das funcoes de pertinencias iniciais
  figure;
  H1 = axes;
  T = 'Funcoes de pertinencias iniciais';
  Plota_MF(H1, T, M, N, Xt, C, Sigma); 
end

% Loop de epocas
ep = 1;
while (ep <= Nep)

    if (mod(ep,10) == 0)
      fprintf('\nEpoca = %d',ep);
    end
     
    % Loop de treinamento
    for k = 1 : Npt
             
        % fase forward
        [ Yst(k) Y W b ] = Calcula_Saida(M, N, Xt(k,:), P, Q, C, Sigma);
                                          
        % Calculo do erro
        E = 1/2 .* ((Yst(k) - Yt(k)) .^2);
               
        % fase backward
        dEdYs = Yst(k) - Yt(k);
        for j = 1 : M
            dYsdW(j) = (Y(j) - Yst(k)) ./ b;
            dYsdY(j) = W(j) ./ b;         
            dYjdQ(j) = 1;
            dEdQ(j) = dEdYs .* dYsdY(j) .* dYjdQ(j);
            for i = 1 : N
                dWjdC(i,j) = W(j) .* (Xt(k,i) - C(i,j)) ./ (Sigma(i,j) .^ 2);
                dEdC(i,j) = dEdYs .* dYsdW(j) .* dWjdC(i,j);
                dYjdP(i,j) = Xt(k,i);
                dEdP(i,j) = dEdYs .* dYsdY(j) .* dYjdP(i,j);
                dWjdSigma(i,j) = W(j) .* 3/2 .* ((Xt(k,i) - C(i,j)) .^ 2) ./ (Sigma(i,j) .^3);
                dEdSigma(i,j) = dEdYs .* dYsdW(j) .* dWjdSigma(i,j);
            end
        end
                          
        % Ajuste dos parametros da rede
        for j = 1 : M
            for i =1 : N
                P(i,j) = P(i,j) - (Alpha .* dEdP(i,j));           
                C(i,j) = C(i,j) - (Alpha .* dEdC(i,j));
                Sigma(i,j) = Sigma(i,j) - (Alpha .* dEdSigma(i,j));              
            end
            Q(j) = Q(j) - (Alpha .* dEdQ(j));
        end
        
    end 
    
    % Calcula erro quadratico medio por epoca de treinamento
    Eqmt(ep) = (1 ./(2 .* Npt)) .* sum((Yst' - Yt) .^2);
    
    if (ep > 1)
      if (norm(Eqmt(ep) - Eqmt(ep-1)) < Epsilon)
        break;
      end
    end
    
    ep = ep + 1;
    
end

if (Graf == 1)
  % Exibe grafico de desempenho
  figure;
  H2 = axes;
  plot(H2, Eqmt,'r');
  title('Desempenho');
  legend('EQM treino');
  xlabel('Epoca');
  ylabel('EQM');

  % Exibe grafico das funcoes de pertinencias finais
  figure;
  H3 = axes;
  T = 'Funcoes de pertinencias finais';
  Plota_MF(H3, T, M, N, Xt, C, Sigma); 
end

return;

% Funcao Plota_MF
function Plota_MF(H, T, M, N, X, C, Sigma) 
  % Exibe grafico das funcoes de pertinencias
  Xmin = min(X);
  Xmax = max(X);  
  for i = 1 : N  
      z = min(Xmin) : 0.001 : max(Xmax);
      for j = 1 : M      
          fp(:,j) = (exp( -1/2 .* (((z - C(i,j)) ./ Sigma(i,j)) .^ 2)));          
      end
      subplot(1,N,i);
      plot(z,fp);
      title([T, ' - X(', int2str(i), ')']);
      hold on;
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