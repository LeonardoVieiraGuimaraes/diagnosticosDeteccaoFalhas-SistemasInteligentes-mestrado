%pag 372
clear all;
close all;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
X = linspace(-10, 10, 100)';
Y = linspace(-10, 10, 100)';
[X Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);
figure
surf(X,Y,Z);
numMFs = 9;
mfType = 'gbellmf';

trnData = [X(:) Y(:) Z(:)];
initFis = genfis1(trnData, numMFs, mfType);
%[epoca erro tamanho_inicial tamanho_taxa_descida  tamanho_taxa_incremento]
trnOpt = [10 0 0.1 0.9 1.1]; 
%[numero_entrada_saida valor_erro tamanho_cada_parametro resultado_final]
dispOpt = [1 1 1 1];  
%dados de validacao 
%chkData = [X Y Z]
%1-Hubrid default 0 - Back-propagation
%optMethod =  1;
[fis,error, stepsize] = anfis(trnData,initFis,trnOpt,dispOpt);
z_hat = evalfis([X(:) Y(:)], fis);
figure
plot3(trnData(:,1),trnData(:,2),z_hat);
figure
plot(error)




