clear;
close all;

y = zeros(1,500);
for k = 2:501
    u(k) = sin(2*pi*k/250);
    f(k) = 0.6.*sin(pi*u(k)) + 0.3*sin(3*pi*u(k)) + 0.1.*sin(5*pi*u(k));%saida dedejada
    y(k+1) = 0.3*y(k) + 0.6*y(k-1) + f(k); % amostra de entrada
end

for k = 502:701
    u(k) = 0.5*sin(2*pi*k/250) + 0.5*sin(2*pi*k/25);
    f(k) = 0.6.*sin(pi*u(k)) + 0.3*sin(3*pi*u(k)) + 0.1.*sin(5*pi*u(k));
    y(k+1) = 0.3*y(k) + 0.6*y(k-1) + f(k);
end

trnData = [y(2:end-1); y(3:end); f(1,2:end)]';
numMFs = 7;
mfType = 'gbellmf';

inFis = genfis1(trnData, numMFs, mfType);
nepocas = 300;
tegoal = 0;
iss = 0.1;
ssd = 0.9;
ssi = 1.1;
%[epoca erro tamanho_inicial tamanho_taxa_descida  tamanho_taxa_incremento]
trnOpt = [nepocas tegoal iss ssd ssi]; 
%[numero_entrada_saida valor_erro tamanho_cada_parametro resultado_final]
dispOpt = [1 1 1 1];  
%dados de validacao 
%chkData = [X Y Z]
%1-Hubrid default 0 - Back-propagation
%optMethod =  1;
[toutFis terror step] = anfis(trnData,inFis,trnOpt,dispOpt);
z_hat = evalfis([y(1,2:end-1); y(1,3:end)]', toutFis);

%in_range = getfis(in_fismat, 'inrange');
%mf_type = getfis(in_fismat, 'inmftypes');
%mf_para = getfis(in_fismat, 'inmfparams');
%d = evalmmf(
%getfis(

MSE = mean((f(2:end)' - z_hat).^2);
RMSE = sqrt(MSE);

figure
plot(u)
title('Grafico I - Função u(k)');
ylabel('u(k)');
xlabel('k - tempo');

figure
plot(f)
title('Grafico II - f(u(k))');
xlabel('k - tempo');
ylabel('f(u(k))');

figure
plot(y(1,1:end-2))
title('Grafico III - y(k)');
xlabel('k - tempo');
ylabel('y(k)');

figure
subplot(221); plotmf(inFis, 'input', 1);
title('Inicial y(k)')
xlabel('y(x)');
ylabel('Pertinência');
subplot(222); plotmf(inFis, 'input', 2);
title('Inicial y(k+1)')
xlabel('y(x)');
ylabel('Pertinência');
subplot(223); plotmf(toutFis, 'input', 1);
title('Final y(k)')
xlabel('y(x)');
ylabel('Pertinência');
subplot(224); plotmf(toutFis, 'input', 2);
title('Final y(k+1)');
xlabel('y(x)');
ylabel('Pertinência');
suptitle('Grafico IV - Regras de Fuzzificação')

figure 
plot(z_hat);
title('Grafico V - Saida do Treinamento');
xlabel('k - tempo');
ylabel('f(k)');

figure
plot(terror)
title('Grafico VI - Erro Medio Quadratico')
ylabel('erro')
xlabel('epoca')


%subplot(223); plotmf(toutFis, 'input', 2);


