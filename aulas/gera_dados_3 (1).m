% Gera dados para clustering com 3 classes

close all;
clear;
clc;

% par�metros
m1 = [1 3]; % m�dia da classe 1
m2 = [2 5]; % m�dia da classe 2
m3 = [4 4]; % m�dia da classe 3
var1 = [0.1 0.1]; % vari�ncia da classe 1
var2 = [0.1 0.1]; % vari�ncia da classe 2
var3 = [0.1 0.1]; % vari�ncia da classe 3
nc1 = 100; % n�mero de padr�es da classe 1
nc2 = 100; % n�mero de padr�es da classe 2
nc3 = 100; % n�mero de padr�es da classe 3
nc = nc1 + nc2 + nc3; % n�mero total de padr�es

for k = 1 : nc1
    c1(k,:) = [(m1(1)+sqrt(var1(1))*randn) (m1(2)+sqrt(var1(2))*randn)]; % classe 1 
end

for k = 1 : nc2
    c2(k,:) = [(m2(1)+sqrt(var2(1))*randn) (m2(2)+sqrt(var2(2))*randn)]; % classe 2   
end

for k = 1 : nc3
    c3(k,:) = [(m3(1)+sqrt(var3(1))*randn) (m3(2)+sqrt(var3(2))*randn)]; % classe 3   
end

% plota as classes e os centros de classes
figure
plot(c1(:,1),c1(:,2),'bo');
hold on;
plot(c2(:,1),c2(:,2),'ro');
plot(c3(:,1),c3(:,2),'go');
plot(m1(1),m1(2),'k*');
plot(m2(1),m2(2),'k*');
plot(m3(1),m3(2),'k*');
legend('Cluster1', 'Cluster2', 'Cluster3');
title('Clusters');

X = [c1 ; c2; c3]; % dados de entrada
y1(1:nc1) = 1;
y2(1:nc2) = 2;
y3(1:nc3) = 3;
Y = [y1, y2, y3]';
idc = randperm(nc1+nc2+nc3); % �ndices permutados aleatoriamente
X = X(idc,:); % dados de entrada distribuidos randomicamente
Y = Y(idc);
