clear all;
close all;
npoints = 6;
Xt = linspace(1, 6, npoints);
Yt = linspace(1, 6, npoints);
Zt = linspace(1, 6, npoints);
[Xt, Yt, Zt] = meshgrid(Xt,Yt, Zt);
outTrn = (1+Xt.^0.5+Yt.^(-1)+Zt.^(-1.5)).^2;
trnData = [Xt(:) Yt(:) Zt(:)]';
outData = outTrn(:)';

npoints= 5;
Xc = linspace(1.5, 5.5, npoints);
Yc = linspace(1.5, 5.5, npoints);
Zc = linspace(1.5, 5.5, npoints);
[Xc, Yc, Zc] = meshgrid(Xc,Yc,Zc);
outChk = (1+Xc.^0.5+Yc.^(-1)+Zc.^(-1.5)).^2;
chkData = [Xc(:) Yc(:) Zc(:)]';
OutChk = outChk(:)';

trainFcn = 'trainlm';
net = feedforwardnet(4, trainFcn);
view(net)
net.trainParam.epochs = 200; %maximo numero de epocas
net.trainParam.goal = 0;%Parada
net.trainParam.max_fail = 1000;%Quantidade maxima de validação
net.trainParam.lr = 0.1; %Taxa de aprendizado
%net.trainParam.time  % maximo de tempo em segundos
%net.trainParam.mc = 0.9; %Momento constante
%net.trainParam.showWindow = false;
%net.trainParam.max_perf_inc = 1.04
%net.trainParam.min_grad %Gradiente de desempenho mínimo
%net.trainParam.show = 25
%net.divideFcn= 'dividerand'; % divide the data randomly 
net.divideParam.trainRatio= 0.63; % we use 70% of the data for training 
net.divideParam.valRatio= 0.37; % 30% is for validation
net.divideParam.testRatio= 0; % 0% for testing

[net tr] = train(net,[trnData chkData],[outData OutChk]);
y = net(trnData);
outsim = sim(net,chkData);

MSEt = mean((y-outData).^2);
MSEv = mean((outsim-OutChk).^2);
RMSEt = sqrt(MSEt);
RMSEv = sqrt(MSEv);

APEt = mean((abs(outData-y))./abs(outData))*100;
APEv = mean((abs(OutChk-outsim))./abs(OutChk))*100;

figure
plotperform(tr);
xlabel('Época'); 
ylabel('Erro');
title('Grafico III - Curva do Erro');


