% Diagnostico de falhas no sistema de acionamento C.C. com Rede Neurofuzzy
% (para 4 tipos de falhas)

close all;
clc;
more off;

fprintf('\n___ DIAGNOSTICO DE FALHAS NO SISTEMA DE ACIONAMENTO C.C. COM REDE NEUROFUZZY ___\n')


% normalização dos dados de entrada
for (i = 1 : size(X,1))
    for (j = 1 : size(X,2))
        % dados normalizados
        X(i,j) = (X(i,j) - min(X(:,j))) / (max(X(:,j)) - min(X(:,j))); 
    end
end

% selecao do conjunto de dados
idcsel = round(linspace(1,size(X,1),0.1*size(X,1)));   
Xsel = X(idcsel,:);
Ysel = Y(idcsel,:);

% randomizacao do conjunto de dados aleatoriamente
idcperm = randperm(size(Xsel,1));
Xperm = Xsel(idcperm,:);
Yperm = Ysel(idcperm,:);

% divisao do conjunto de dados em treinamento e validacao
nt = floor(size(Xperm,1)*80/100);
nv = floor(size(Xperm,1)*20/100);

% conjunto de dados de treinamento
Xt = Xperm(1:nt,:);
Yt = Yperm(1:nt,:); 

% conjunto de dados de validacao
Xv = Xperm(nt+1:nt+nv,:);
Yv = Yperm(nt+1:nt+nv,:);

fprintf('\nTreinamento da rede ...\n');

% treinamento da rede da falha 1
[ Yst1 Eqmt1 C1 Sigma1 P1 Q1 ] = anfis2_trn(2, 100, 0.001, 1e-6, Xt, Yt(:,1), 0);

% treinamento da rede da falha 2
[ Yst2 Eqmt2 C2 Sigma2 P2 Q2 ] = anfis2_trn(2, 100, 0.001, 1e-6, Xt, Yt(:,2), 0);

% treinamento da rede da falha 3
[ Yst3 Eqmt3 C3 Sigma3 P3 Q3 ] = anfis2_trn(2, 100, 0.001, 1e-6, Xt, Yt(:,3), 0);

% treinamento da rede da falha 4
[ Yst4 Eqmt4 C4 Sigma4 P4 Q4 ] = anfis2_trn(2, 100, 0.001, 1e-6, Xt, Yt(:,4), 0);

fprintf('\nOperacao da rede ...\n');

% operacao da rede da falha 1
[ Ysv1 Eqmv1  ] = anfis2_opr(C1, Sigma1, P1, Q1, Xv, Yv(:,1));

% operacao da rede da falha 2
[ Ysv2 Eqmv2  ] = anfis2_opr(C2, Sigma2, P2, Q2, Xv, Yv(:,2));

% operacao da rede da falha 3
[ Ysv3 Eqmv3  ] = anfis2_opr(C3, Sigma3, P3, Q3, Xv, Yv(:,3));

% operacao da rede da falha 4
[ Ysv4 Eqmv4  ] = anfis2_opr(C4, Sigma4, P4, Q4, Xv, Yv(:,4));

Ysv = [Ysv1' Ysv2' Ysv3' Ysv4'];

% pos-processamento
lim_inf = 0.1;
lim_sup = 0.9;
Ypos = []; % saida pos-processada
for (i = 1 : size(Ysv,1))
  for (j = 1 : size(Ysv,2))
    if (Ysv(i,j) <= lim_inf)
      Ypos(i,j) = 0;
    end
    if (Ysv(i,j) >= lim_sup)
      Ypos(i,j) = 1;
    end
  end
end

% calculo do desempenho
som = 0;
for (i = 1 : size(Ypos,1))
  if (sum(Ypos(i,:) == Yv(i,:)) == 4)
    som = som + 1;
  end
end
tc = (som/size(Ypos,1)) * 100;

fprintf('\nTaxa de classificacao correta: %3.2f %%\n\n',tc);