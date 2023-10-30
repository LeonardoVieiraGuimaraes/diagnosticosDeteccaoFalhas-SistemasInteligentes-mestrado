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
X = X(:);
Y = Y(:);
Z = Z(:);
%m = length(X);
%idc = randperm(m)'; 
%X = X(idc,:);
%Y = Y(idc,:);
%Z = Z(idc,:);

net = network;

%net = network(2,2,[1;0],[1 1;1 0],[0 0; 1 0],[0 1]);

%net = fitnet(10,'traingdm');
%net = feedforwardnet(10,'traingdm');
net.numInputs = 2;
net.numLayers = 2;
net.biasConnect(1) = 1;
net.biasConnect(2) = 1;
%net.biasConnect(3) = 1;
net.inputConnect(1,1) = 1;
net.inputConnect(1,2) = 1;
net.layerConnect = [0 0; 1 0];
net.outputConnect = [0 1];
%net.performFcn = 'mse';
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'logsig';
net.trainFcn = 'trainlm';
%net.Layers{1}.size = 10;
%net.inputConnect(2,1) = 1;
%net.inputConnect(2,2) = 1;

%net.layerConnect = [0 0 0; 0 0 0; 0 0 0];
%net.outputConnect = [0 1];




net = configure(net,{X;Y},Z);

net = train(net,{X;Y});
view(net)
y = net({X;Y});
perf = perform(net,y,Z)
figure
plot3(X,Y,y{1,1})

