clear;
close all;
a = 500;

y = zeros(1,500);
for k = 2:501
    u(k) = sin(2*pi*k/250);
    f(k) = 0.6.*sin(pi*u(k)) + 0.3*sin(3*pi*u(k)) + 0.1.*sin(5*pi*u(k));%saida dedejada
    y(k+1) = 0.3*y(k) + 0.6*y(k-1) + f(k); % amostra de entrada
end

for k = 502:701
    u(k) = 0.5*sin(2*pi*k/250) + 0.5*sin(2*pi*k/25);
    f(k) = 0.6.*sin(pi*u(k)) + 0.3*sin(3*pi*u(k)) + 0.1.*sin(5*pi*u(k));
    y(k+1) = 0.3*y(k) + 0.6*y(k-1) + f(k);
end


trnData = [y(1,2:end-1); y(1,3:end)];
outData = f(1,2:end);


trainFcn = 'trainlm';
net = feedforwardnet(20, trainFcn);

net.trainParam.epochs = 300;
net.trainParam.goal = 0;
%net.trainParam.mc = 0.9;
net.trainParam.max_fail = 100000;
%net.trainParam.max_perf_inc = 1.04
%net.trainParam.min_grad
%net.trainParam.show = 25
net.trainParam.lr = 0.1;
net.divideParam.trainRatio= 1; % we use 70% of the data for training 
net.divideParam.valRatio= 0; % 30% is for validation
net.divideParam.testRatio= 0; % 0% for testing

[net,tr] = train(net,trnData,outData);
z_hat = net(trnData);
perf = perform(net,z_hat,outData);

view(net)
MSE = mean((f(2:end) - z_hat).^2);
RMSE = sqrt(MSE);

figure
plot(u)
title('Grafico I - Função u(k)');
ylabel('u(k)');
xlabel('k - tempo');

figure
plot(f)
title('Grafico II - f(u(k))');
xlabel('k - tempo');
ylabel('f(u(k))');

figure
plot(y(1,1:end-2))
title('Grafico III - y(k)');
xlabel('k - tempo');
ylabel('y(k)');

figure 
plot(z_hat);
title('Grafico IV - Saida do Treinamento');
xlabel('k - tempo');
ylabel('y(k)');

figure
plotperform(tr)
title('Grafico V - Erro Medio Quadratico')
ylabel('erro')
xlabel('epoca')