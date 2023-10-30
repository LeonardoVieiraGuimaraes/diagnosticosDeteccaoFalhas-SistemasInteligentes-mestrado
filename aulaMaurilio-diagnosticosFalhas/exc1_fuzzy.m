%pag 372
clear all;
close all;
%16 regras 4 fun��es para cada variavel 72 parametros 24 premissias 48
%consequentes

% Constru��es dos dados de entrada
npoints = 100;
X = linspace(-10, 10, npoints);
Y = linspace(-10, 10, npoints);
[X,Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);

numMFs = 4;% Quantidade de regra para cada entrada. 
mfType = 'gbellmf'; %fun��o de pertinencia 
% trimf
% trapmf
% gaussmf
% sigmf
trnData = [X(:) Y(:) Z(:)];
initFis = genfis1(trnData, numMFs, mfType); %Parametros de configura��o da rede
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
%Raiz erro medio quadr�tico
RMSE = sqrt(MSE);

figure
surf(X,Y,Z);
title('Grafico I - Fun��o Sinc 2 Dimens�es');
ylabel('Y');
xlabel('X');
zlabel('Z');

figure
subplot(221); plotmf(initFis, 'input', 1);
title('Inicial X');
xlabel('X');
ylabel('Grau Pertin�ncia')
subplot(222); plotmf(initFis, 'input', 2);
title('Inicial Y');
xlabel('Y');
ylabel('Grau Pertin�ncia')
subplot(223); plotmf(fis, 'input', 1);
title('Final X');
xlabel('X');
ylabel('Grau Pertin�ncia')
subplot(224); plotmf(fis, 'input', 2);
title('Final Y');
xlabel('Y');
ylabel('Grau Pertin�ncia')
suptitle('Grafico II - Pertin�ncia');

figure
plot(error);
ylabel('Erro');
xlabel('Epoca');
title('Grafico III - Fun��o de Erro');

figure
surf(X,Y,reshape(z_hat,npoints,npoints));
title('Grafico IV - Aproxima��o da Fun��o Sinc 2 Dimens�es');
ylabel('Y');
xlabel('X');
zlabel('Z');



