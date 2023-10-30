close all; 
clear all;

X = 0.0000001:((2*pi-0.0000001)/1000):2*pi;
Y = -0.2172:(1+0.2172)/1000:1;
Yd = sin(X)./X;

xbaixa = gaussmf(X, [0.6671 0]);
xpoucobaixa = gaussmf(X,  [0.6671 1.571]);
xpoucoalta = gaussmf(X,   [0.6671 3.142]);
xalta = gaussmf(X,  [0.6671 4.712]);

%sugeno de ordem zero
z1 = -0.5/pi*X + 1;
z2 = -1.2/pi*X + 1.3;
z3 = -0.05/pi*X-0.005;
z4 = 0.5/pi*X - 1;
 
for i = 1:length(X);
    w1 = xbaixa(1,i);
    w2 = xpoucobaixa(1,i);
    w3 = xpoucoalta(1,i);
    w4 = xalta(1,i);    
    Y2(1,i) = (w1.*z1(1,i)  + w2.*z2(1,i)+ z3(1,i).*w3 +w4.*z4(1,i))/(w1+w2+w3+w4);
end

EQM_sugeno = (1/length(Yd))*sum((Y2-Yd).^2);



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
plot(X,Yd, 'linewidth',3);
hold on;
plot(X,z1, 'linewidth',3);
hold on;
plot(X,z2, 'linewidth',3);
hold on;
plot(X,z3, 'linewidth',3);
hold on;
plot(X,z4, 'linewidth',3);
title('Funções de Y');
ylabel('U(y)');
xlabel('y');
legend('Y1','Y2','Y3','Y4');
ylim([-0.5 1.5]);


figure(3)
plot(X,Y2, 'linewidth',3);
hold on;
plot(X,Yd, 'linewidth',3);
ylabel('Y');
xlabel('X');
title('Aproximação da Função Sinc');
legend('Função Encontrada', 'Função Desejada');
