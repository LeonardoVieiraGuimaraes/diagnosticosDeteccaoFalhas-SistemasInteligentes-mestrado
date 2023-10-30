% Teste da Rede Neurofuzzy ANFIS2 (aproximacao da funcao sen(x^2)-x)

gera_sen;

[ Yst Eqmt C Sigma P Q ] = anfis2_trn(5, 500, 0.001, 1e-6, Xt, Yt, 1);

figure;
plot(Yt);
hold on
plot(Yst,'r');
title('Y - Treinamento');
legend('Yt','Yst');

[ Ysv Eqmv  ] = anfis2_opr(C, Sigma, P, Q, Xv, Yv);

figure;
plot(Yv);
hold on
plot(Ysv,'r');
title('Y - Validacao');
legend('Yv','Ysv');


