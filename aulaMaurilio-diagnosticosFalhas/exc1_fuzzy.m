%pag 372
clear all;
close all;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias 48
%consequentes

% Construções dos dados de entrada
npoints = 100;
X = linspace(-10, 10, npoints);
Y = linspace(-10, 10, npoints);
[X,Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);

numMFs = 4;% Quantidade de regra para cada entrada. 
mfType = 'gbellmf'; %função de pertinencia 
% trimf
% trapmf
% gaussmf
% sigmf
trnData = [X(:) Y(:) Z(:)];
initFis = genfis1(trnData, numMFs, mfType); %Parametros de configuração da rede
%[epoca erro tamanho_inicial tamanho_taxa_descida  tamanho_taxa_incremento]
trnOpt = [250 0 0.1 0.9 1.1]; 
%[numero_entrada_saida valor_erro tamanho_cada_parametro resultado_final]
dispOpt = [1 1 1 1];  
%dados de validacao 
%chkData = [X Y Z]
%1-Hubrid default 0 - Back-propagation
%optMethod =  1;
[fis,error] = anfis(trnData,initFis,trnOpt,dispOpt);
z_hat = evalfis([X(:) Y(:)], fis);
%Erro Medio Quadratico
MSE = mean((z_hat-Z(:)).^2);
%Raiz erro medio quadrático
RMSE = sqrt(MSE);

figure
surf(X,Y,Z);
title('Grafico I - Função Sinc 2 Dimensões');
ylabel('Y');
xlabel('X');
zlabel('Z');

figure
subplot(221); plotmf(initFis, 'input', 1);
title('Inicial X');
xlabel('X');
ylabel('Grau Pertinência')
subplot(222); plotmf(initFis, 'input', 2);
title('Inicial Y');
xlabel('Y');
ylabel('Grau Pertinência')
subplot(223); plotmf(fis, 'input', 1);
title('Final X');
xlabel('X');
ylabel('Grau Pertinência')
subplot(224); plotmf(fis, 'input', 2);
title('Final Y');
xlabel('Y');
ylabel('Grau Pertinência')
suptitle('Grafico II - Pertinência');

figure
plot(error);
ylabel('Erro');
xlabel('Epoca');
title('Grafico III - Função de Erro');

figure
surf(X,Y,reshape(z_hat,npoints,npoints));
title('Grafico IV - Aproximação da Função Sinc 2 Dimensões');
ylabel('Y');
xlabel('X');
zlabel('Z');



