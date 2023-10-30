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
X = X(:)';
Y = Y(:)';
Z = Z(:)';
%m = length(X);
%idc = randperm(m)'; 
%X = X(idc,:)';
%Y = Y(idc,:)';
%Z = Z(idc,:)';
input = [X;Y];
net = feedforwardnet([10 20]);
net.trainParam.epochs = epoca;
net.trainParam.goal = 10^-4;
net.trainParam.mc = 0.9;
net.trainParam.lr = 0.1;
net = train(net,input,Z);
view(net)
y = net(input);
perf = perform(net,y,Z);
figure
plot3(X,Y,y)