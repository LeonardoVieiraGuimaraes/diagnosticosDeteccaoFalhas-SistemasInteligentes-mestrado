%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
clear all;
close all;

X = (-10:20/100:10)';
Y = (-10:20/100:10)';



Z = (sin(X).*sin(Y))./(X.*Y);

[X Y Z] = meshgrid(X,Y,Z);