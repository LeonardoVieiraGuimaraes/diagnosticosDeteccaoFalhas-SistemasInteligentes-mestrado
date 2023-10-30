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
net=feedforwardnet(10);
net.numInputs = 2;


net= train(net,{X;Y},Z);
view(net)
[y tr] = net({X;Y});
perf = perform(net,y,Z);
figure
plot3(X,Y,y{1,1})


