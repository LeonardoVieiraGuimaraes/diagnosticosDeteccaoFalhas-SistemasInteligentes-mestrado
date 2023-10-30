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

dados = [zero; um; dois; treis; quatro; cinco; seis ;sete ; oito; nove];
idc = randperm(1600); % Permutados aleatoriamente
dados = dados(idc,:); % dados de entrada distribuidos randomicamente

trnData = dados(1:1000,1:6);
outData = dados(1:1000,7);
chkData = dados(1001:1600,1:6);
OutChk = dados(1001:1600,7);


numMFs = 2;
mfType = 'gbellmf';

inFis = genfis1([trnData outData], numMFs, mfType);
nepocas = 300;
tegoal = 0;
iss = 0.1;
ssd = 0.9;
ssi = 1.1;

trnOpt = [nepocas tegoal iss ssd ssi]; 

dispOpt = [1 1 1 1];  

a = [trnData outData];

[toutFis terror step coutFis cerror] = anfis([trnData outData],inFis,trnOpt,dispOpt,[chkData OutChk]);

z_hat = evalfis(trnData, toutFis);
z_hac = evalfis(chkData, coutFis);

MSEtrn = terror(end);
MSEchk = cerror(end);

figure
plot(terror);
hold on
plot(cerror);
title('Grafico IV - Erro Medio Quadratico');
xlabel('Tempo - Segundos');
ylabel('Erro');
legend('Treinamento', 'Validação');


