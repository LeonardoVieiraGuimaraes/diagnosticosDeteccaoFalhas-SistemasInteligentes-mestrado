%pag 372
clear all;
close all;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
X = (-10:20/100:10)';
Y = (-10:20/100:10)';



[x y] = meshgrid(X,Y);
Z = (sin(x).*sin(y))./(x.*y);
for k=1:length(Z)
    
    plot3(x(:,k), y(:,k), Z(:,k));
    hold on
end
