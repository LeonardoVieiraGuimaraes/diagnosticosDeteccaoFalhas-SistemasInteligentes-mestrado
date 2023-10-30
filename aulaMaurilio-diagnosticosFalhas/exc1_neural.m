%pag 372
clear all;
close all;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
npoints = 100;
X = linspace(-10, 10, npoints);
Y = linspace(-10, 10, npoints);
[X,Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);

input = [X(:) Y(:)]';
output = Z(:)';

trainFcn = 'trainlm';
net = feedforwardnet(20,trainFcn);

% 'trainlm'	 Levenberg-Marquardt
% 'trainbr'	Bayesian Regularization
% 'trainbfg'	 BFGS Quasi-Newton
% 'trainrp'	 Resilient Backpropagation
% 'trainscg'	 Scaled Conjugate Gradient
% 'traincgb'	Conjugate Gradient with Powell/Beale Restarts
% 'traincgf'	Fletcher-Powell Conjugate Gradient
% 'traincgp'	Polak-Ribiére Conjugate Gradient
% 'trainoss'	One Step Secant
% 'traingdx'	Variable Learning Rate Gradient Descent
% 'traingdm'	Gradient Descent with Momentum'traingd'

net.trainParam.epochs = 600;
net.trainParam.goal = 3*10^-4;
net.trainParam.mc = 0.1;
%net.trainParam.max_fail = 6000;
net.divideParam.trainRatio= 1; % we use 70% of the data for training 
net.divideParam.valRatio= 0; % 30% is for validation
net.divideParam.testRatio= 0; % 0% for testing
%net.trainParam.max_perf_inc = 1.04
%net.trainParam.min_grad = 1*10^-100
%net.trainParam.show = 25;
%net.trainParam.lr = 0.1;

[net,tr] = train(net,input,output);
z_hat = net(input);
figure 
view(net)
%Erro Medio Quadratico
MSE = mean((z_hat'-Z(:)).^2);
%Raiz erro medio quadrático
RMSE = sqrt(MSE);

figure
surf(X,Y,Z);
title('Grafico I - Função Sinc 2 Dimensões');
ylabel('Y');
xlabel('X');
zlabel('Z');

figure
plotperform(tr);
title('Grafico V - Erro por epoca');
ylabel('Erro');
xlabel('Epoca');

figure
surf(X,Y,reshape(z_hat,npoints,npoints));
title('Grafico VI - Aproximação da Função Sinc 2 Dimensões');
ylabel('Y');
xlabel('X');
zlabel('Z');

