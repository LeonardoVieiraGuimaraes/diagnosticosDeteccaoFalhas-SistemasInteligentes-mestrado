
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
X = linspace(-10, 10, 11);
Y = linspace(-10, 10, 11);
[X Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);
net = feedforwardnet(20); 
view(net)

