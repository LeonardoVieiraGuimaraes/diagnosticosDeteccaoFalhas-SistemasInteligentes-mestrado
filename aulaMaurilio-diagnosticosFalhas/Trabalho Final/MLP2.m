clear all;
close all;
%Obtenção das amostras 
um = load('um.txt');
um = um(:,1:168);
um(:,169) = 1; 

zero = load('zero.txt');
zero = zero(:,1:168);
zero(:,169) = 0; 

dois = load('dois.txt');
dois = dois(:,1:168);
dois(:,169) = 2; 

treis = load('treis.txt');
treis = treis(:,1:168);
treis(:,169) = 3; 

quatro = load('quatro.txt');
quatro = quatro(:,1:168);
quatro(:,169) = 4; 

cinco = load('cinco.txt');
cinco = cinco(:,1:168);
cinco(:,169) = 5;

seis = load('seis.txt');
seis = seis(:,1:168);
seis(:,169) = 6; 

sete = load('sete.txt');
sete = sete(:,1:168);
sete(:,169) = 7; 

oito = load('oito.txt');
oito = oito(:,1:168);
oito(:,169) = 8; 

nove = load('nove.txt');
nove = nove(:,1:168);
nove(:,169) = 1; 
%realocando os danos um uma matriz de dados
dados = [zero; um; dois; treis; quatro; cinco; seis ;sete ; oito; nove];
idc = randperm(1600); % Ã­ndices permutados aleatoriamente

dados = dados(idc,:); % dados de entrada distribuidos randomicamente

trnData = dados(1:1000,1:168)';
outData = dados(1:1000,169)';
chkData = dados(1001:1600,1:168)';
OutChk = dados(1001:1600,169)';

trainFcn = 'traingdx';
net = feedforwardnet([20 30],trainFcn);

net.trainParam.epochs = 500;
net.trainParam.goal = 0;
net.trainParam.mc = 0.9;
net.trainParam.max_fail = 500;
%net.trainParam.max_perf_inc = 1.04
net.trainParam.min_grad = 10^-100;
%net.trainParam.show = 25
net.trainParam.lr = 0.1;

net.divideParam.trainRatio= 0.375; % we use 70% of the data for training 
net.divideParam.valRatio= 0.625; % 30% is for validation
net.divideParam.testRatio= 0; % 0% for testing

[net tr] = train(net,[trnData chkData],[outData OutChk]);
z_hat = net(trnData);
z_hac = net(chkData);

erro = [z_hat z_hac];
MSEtrn = mean((erro(1:500)).^2);
MSEchk = mean((erro(501:1000)).^2);

view(net)


figure
plotperform(tr);
title('Grafico IV - Erro Medio Quadratico');
xlabel('Tempo - Segundos');
ylabel('Erro');
legend('Treinamento', 'Validação');





