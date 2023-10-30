%pag 372
clear all;
close all;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
X = linspace(-10, 10, 100)';
Y = linspace(-10, 10, 100)';
[X Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);
%figure
%surf(X,Y,Z);
X = X(:);
Y = Y(:);
Z = Z(:);
net = feedforwardnet(20);
[net, tr] = train(net, X, Z);