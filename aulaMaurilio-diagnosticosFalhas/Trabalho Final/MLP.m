clear all;
close all;
%Obtenção das amostras 
um = load('um.txt');
zero = load('zero.txt');
dois = load('dois.txt');
treis = load('treis.txt');
quatro = load('quatro.txt');
cinco = load('cinco.txt');
seis = load('seis.txt');
sete = load('sete.txt');
oito = load('oito.txt');
nove = load('nove.txt');
%realocando os danos um uma matriz de dados
dados = [zero; um; dois; treis; quatro; cinco; seis ;sete ; oito; nove];
[m, n] = size(dados);
idc = randperm(m); % Permutação 
dados = dados(idc,:); % Dados de entrada

%Criação de dados de entrada e saida para treinamento
trnData = dados(1:1000,1:6)';
outData = dados(1:1000,7)';

%Criação de dados de entrada e daida para validação
chkData = dados(1001:1600,1:6)';
OutChk = dados(1001:1600,7)';

%configuração e configuração da Rede MLP 
trainFcn = 'traingdx';
net = feedforwardnet(200,trainFcn);

net.trainParam.epochs = 2000;
net.trainParam.goal = 0;
net.trainParam.mc = 0.9;
net.trainParam.max_fail = 500;
net.trainParam.min_grad = 10^-100;
net.trainParam.lr = 0.1;

net.divideParam.trainRatio= 0.625; % we use 70% of the data for training 
net.divideParam.valRatio= 0.375; % 30% is for validation
net.divideParam.testRatio= 0; % 0% for testing

[net tr] = train(net,[trnData chkData],[outData OutChk]);
z_hat = net(trnData);
z_hac = net(chkData);

%Erro médio quadratico
MSEtrn = tr.perf(end)
MSEchk = tr.vperf(end)

view(net)

figure
plotperform(tr);
title('Grafico IV - Erro Medio Quadratico');
xlabel('Tempo - Segundosé');
ylabel('Erro');
legend('Treinamento', 'Validação');





