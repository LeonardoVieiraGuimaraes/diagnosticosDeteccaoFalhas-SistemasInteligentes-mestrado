% Gera Funcaoo sen(x^2) - x

clear;
close all;
clc;

% Dados para treinamento
Xt = (0:0.02:3)';
npt = length(Xt);
Yt = sin(Xt.^2) - Xt;
Xt = [Xt, Xt.^2];
ruido = 0.0*(2*rand(npt,1)-1);
Yt = Yt + ruido;
subplot(2,1,1);
plot(Yt);
axis ([0, npt, min(Yt), max(Yt)]);
legend('Yt+ruido');

% Dados para  validacao
Xv = (0:0.04:3)';
Yv = sin(Xv.^2) - Xv;
Xv = [Xv, Xv.^2];
subplot(2,1,2);
axis ([0, npt, min(Yt), max(Yt)]);
plot(Yv,'r');
legend('Yv');