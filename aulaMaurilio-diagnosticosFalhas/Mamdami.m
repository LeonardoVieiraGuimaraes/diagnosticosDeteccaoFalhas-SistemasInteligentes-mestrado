close all; 
clear all;

X = 0.0000001:((2*pi-0.0000001)/1000):2*pi;
Y = -0.2172:(1+0.2172)/1000:1;
Yd = sin(X)./X;

xbaixa = gaussmf(X, [0.6671 0]);
xpoucobaixa = gaussmf(X,  [0.6671 1.571]);
xpoucoalta = gaussmf(X,   [0.6671 3.142]);
xalta = gaussmf(X,  [0.6671 4.712]);

ybaixa = gaussmf(Y, [0.1 -0.2122]);
ypoucobaixa = gaussmf(Y,  [0.05 0]);
ypoucoalta = gaussmf(Y,   [0.05 0.6366]);
yalta= gaussmf(Y, [0.05 1]);

%mandami
for i = 1:length(X)
    r1 = min(xbaixa(1,i),yalta);
    r2 = min(xpoucobaixa(1,i),ypoucoalta);
    r3 = min(xpoucoalta(1,i),ypoucobaixa);
    r4 = min(xalta(1,i),ybaixa);
    r = [r1; r2; r3; r4];
    u = max(r);
    Y1(1,i) = sum(u.*Y)/sum(u);  
end

EQM_mandami = (1/length(Yd))*sum((Y1-Yd).^2);


figure(1)
plot(X,xbaixa, 'linewidth',3);
hold on;
plot(X,xpoucobaixa, 'linewidth',3);
hold on;
plot(X,xpoucoalta, 'linewidth',3);
hold on;
plot(X,xalta, 'linewidth',3);
title('Pertinencia X');
ylabel('U(X)');
xlabel('X');
legend('A1','A2','A3','A4');

figure(2)
plot(Y,ybaixa, 'linewidth',3);
hold on;
plot(Y,ypoucobaixa, 'linewidth',3);
hold on;
plot(Y,ypoucoalta, 'linewidth',3);
hold on;
plot(Y,yalta, 'linewidth',3);
title('Pertinencia Y');
ylabel('U(Y)');
xlabel('Y');
legend('B1','B2','B3','B4');

figure(3)
plot(X,Y1, 'linewidth',3);
hold on;
plot(X,Yd, 'linewidth',3);
ylabel('Y');
xlabel('X');
title('Aproximação da Função Sinc');
legend('Função Encontrada', 'Função Desejada');






