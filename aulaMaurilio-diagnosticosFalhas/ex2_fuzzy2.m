clear all;
close all;
npoints = 6;
Xt = linspace(1, 6, npoints);
Yt = linspace(1, 6, npoints);
Zt = linspace(1, 6, npoints);
[Xt, Yt, Zt] = meshgrid(Xt,Yt,Zt);
outTrn = (1+Xt.^0.5+Yt.^(-1)+Zt.^(-1.5)).^2;
trnData = [Xt(:) Yt(:) Zt(:) outTrn(:)];

npoints = 5;
Xc = linspace(1.5, 5.5, npoints);
Yc = linspace(1.5, 5.5, npoints);
Zc = linspace(1.5, 5.5, npoints);
[Xc, Yc, Zc] = meshgrid(Xc,Yc,Zc);
outChk = (1+Xc.^0.5+Yc.^(-1)+Zc.^(-1.5)).^2;
chkData = [Xc(:) Yc(:) Zc(:) outChk(:)];

numMFs = 2;
mfType = 'gbellmf';

inFis = genfis1(trnData, numMFs, mfType);

nepocas = 200; % numero de epocas
tegoal = 0; % Objetivo do Erro 
iss = 0.1;%tamanho de degrau inicial 
ssd = 0.9;% Taxa de decremento
ssi = 1.1;%Taxa de incremento
%[epoca erro tamanho_inicial tamanho_taxa_descida  tamanho_taxa_incremento]
trnOpt = [nepocas tegoal iss ssd ssi]; 
%[numero_entrada_saida valor_erro tamanho_cada_parametro resultado_final]
dispOpt = [1 1 1 1];  
%dados de validacao 
%chkData = [X Y Z]
%1-Hubrid default 0 - Back-propagation
%optMethod =  1;

[toutFis terror step coutFis cerror] = anfis(trnData,inFis,trnOpt,dispOpt, chkData);
z_hat = evalfis([Xt(:) Yt(:) Zt(:)], toutFis);
z_hav = evalfis([Xc(:) Yc(:) Zc(:)], coutFis);



figure
subplot(221); plotmf(inFis, 'input', 1);
title('Inicial X');
xlabel('X');
ylabel('Grau Pertinência')
subplot(222); plotmf(inFis, 'input', 2);
title('Inicial Y');
xlabel('Y');
ylabel('Grau Pertinência')
subplot(223); plotmf(inFis, 'input', 3);
title('Inicial Z');
xlabel('Z');
ylabel('Grau Pertinência')
suptitle('Grafico I - Pertinencia');

figure
subplot(221); plotmf(toutFis, 'input', 1);
title('Final X');
xlabel('X');
ylabel('Grau Pertinência')
subplot(222); plotmf(toutFis, 'input', 2);
title('Final Y');
xlabel('Y');
ylabel('Grau Pertinência')
subplot(223); plotmf(toutFis, 'input', 3);
title('Final Z');
xlabel('Z');
ylabel('Grau Pertinência')
suptitle('Grafico II - Pertinencia');

figure
plot(terror);
xlabel('Numero de Epoca'); ylabel('Erro');
hold on;
plot(cerror);
legend('Treinamento', 'Validação');
title('Grafico III - Curva de Erro')
xlabel('Numero de Epoca'); 
ylabel('Erro');


MSEt = mean((z_hat-outTrn(:)).^2);
MSEv = mean((z_hav-outChk(:)).^2);
RMSEt = sqrt(mean((z_hat-outTrn(:)).^2));
RMSEv = sqrt(mean((z_hav-outChk(:)).^2));

APEt = mean((abs(outTrn(:)-z_hat))./abs(outTrn(:)))*100;
APEv = mean((abs(outChk(:)-z_hav))./abs(outChk(:)))*100;