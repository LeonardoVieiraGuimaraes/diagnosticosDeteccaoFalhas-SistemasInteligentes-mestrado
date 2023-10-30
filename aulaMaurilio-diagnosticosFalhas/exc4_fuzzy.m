clear;
close all;
%x varia de -17 a 2000
%x = zeros(1,2018);
tau = 17;
D = 4;
P = 6;
load mgdata.dat
time = mgdata(:,1)';
x = mgdata(:, 2)';

t = 118:617;
trnData = [x(t-(D-1)*P); x(t-(D-2)*P); x(t-(D-3)*P);x(t); x(t+P)]';
t = 618:1117;
chkData = [x(t-(D-1)*P); x(t-(D-2)*P); x(t-(D-3)*P);x(t); x(t+P)]';

numMFs = 2;
mfType = 'gbellmf';

inFis = genfis1(trnData, numMFs, mfType);
nepocas = 500;
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

[toutFis terror step coutFis cerror] = anfis(trnData,inFis,trnOpt,dispOpt, chkData);
t = 118:617;
z_hat = evalfis([x(t-(D-1)*P); x(t-(D-2)*P); x(t-(D-3)*P);x(t)]', toutFis);
t = 618:1117;
z_hac = evalfis([x(t-(D-1)*P); x(t-(D-2)*P); x(t-(D-3)*P);x(t)]', coutFis);

z_hat = z_hat';
z_hac = z_hac';

erro = [z_hat z_hac];
RMSEtrn = (mean((erro(1:500)).^2));
RMSEchk = (mean((erro(501:1000)).^2));


figure
plot(time,x)
title('Grafico I - Serie Temporal')
xlabel('Tempo - Segundos');
ylabel('X(t)');

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
plot(t,x(t+6))
hold on
plot(t(1:500),z_hat,'--');
hold on
plot(t(501:1000),z_hac,'--');
title('Grafico II - Previsão de Uma Serie Temporal');
xlabel('Tempo - Segundos');
ylabel('X(t)');
legend('Desejado', 'Treinamento', 'Validação');


figure
plot(erro);
title('Grafico III - Erro');
xlabel('Tempo - Segundos');
ylabel('Erro');

figure
plot(terror);
hold on
plot(cerror);
title('Grafico IV - Erro Medio Quadratico');
xlabel('Tempo - Segundos');
ylabel('Erro');
legend('Treinamento', 'Validação');


