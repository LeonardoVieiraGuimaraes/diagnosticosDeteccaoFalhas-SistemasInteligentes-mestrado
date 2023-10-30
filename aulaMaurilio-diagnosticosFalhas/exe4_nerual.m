clear all;
close all;
%x varia de -17 a 2000
%x = zeros(1,2018);
tau = 17;
D = 4;
P = 6;
load mgdata.dat
time = mgdata(:,1)';
x = mgdata(:, 2)';

t = 118:617;
trnData = [x(t-(D-1)*P); x(t-(D-2)*P); x(t-(D-3)*P);x(t)];
outData = x(t+P);
t = 618:1117;
chkData = [x(t-(D-1)*P); x(t-(D-2)*P); x(t-(D-3)*P);x(t)];
OutChk = x(t+P);

trainFcn = 'trainlm';
net = feedforwardnet(20,trainFcn);

net.trainParam.epochs = 500;
net.trainParam.goal = 0;
%net.trainParam.mc = 0.9;
net.trainParam.max_fail = 500;
%net.trainParam.max_perf_inc = 1.04
%net.trainParam.min_grad
%net.trainParam.show = 25
net.trainParam.lr = 0.1;

net.divideParam.trainRatio= 0.5; % we use 70% of the data for training 
net.divideParam.valRatio= 0.5; % 30% is for validation
net.divideParam.testRatio= 0; % 0% for testing
aa = [trnData chkData]
[net tr] = train(net,[trnData chkData],[outData OutChk]);
z_hat = net(trnData);
z_hac = net(chkData);

t = 118:1117;

t = 118:1117;
erro = x(t+6)-[z_hat z_hac];
RMSE = sqrt(mean(erro.^2));
RMSEtrn = sqrt(mean((erro(1:500)).^2));
RMSEchk = sqrt(mean((erro(501:1000)).^2));

view(net)

figure
plot(time,x)
title('Grafico I - Serie Temporal')
xlabel('Tempo - Segundos');
ylabel('X(t)');

figure
plot(t,x(t+6))
hold on
plot(t(1:500),z_hat,'--');
hold on
plot(t(501:1000),z_hac,'--');
title('Grafico II - Previsão de Uma Serie Temporal');
xlabel('Tempo - Segundos');
ylabel('X(t)');
legend('Desejado', 'Treinamento', 'Validação');

figure
plot(erro);
title('Grafico III - Erro');
xlabel('Tempo - Segundos');
ylabel('Erro');

figure
plotperform(tr);
title('Grafico IV - Erro Medio Quadratico');
xlabel('Tempo - Segundos');
ylabel('Erro');
legend('Treinamento', 'Validação');



