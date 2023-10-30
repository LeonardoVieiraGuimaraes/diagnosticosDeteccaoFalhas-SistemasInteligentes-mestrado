% Diagnostico de falhas no sistema de acionamento C.C. com RNA

close all;
clc;

fprintf('\n___ DIAGNOSTICO DE FALHAS NO SISTEMA DE ACIONAMENTO C.C. COM RNA\n')

% normalização dos dados de entrada
for (i = 1 : size(X,1))
    for (j = 1 : size(X,2))
        % dados normalizados
        X(i,j) = (X(i,j) - min(X(:,j))) / (max(X(:,j)) - min(X(:,j))); 
    end
end

% randomizacao do conjunto de dados aleatoriamente
idcperm = randperm(size(X,1));
X = X(idcperm,:);
Y = Y(idcperm,:);

% divisao do conjunto de dados em treinamento, validacao e teste
ntrn = floor(size(X,1)*70/100);
nval = floor(size(X,1)*15/100);
ntes = floor(size(X,1)*15/100);

% conjunto de dados de treinamento
Xtrn = X(1:ntrn,:);
Ytrn = Y(1:ntrn,:);

% conjunto de dados de validacao
Xval = X(ntrn+1:ntrn+nval,:);
Yval = Y(ntrn+1:ntrn+nval,:);

% conjunto de dados de teste
Xtes = X(ntrn+nval+1:ntrn+nval+ntes,:);
Ytes = Y(ntrn+nval+1:ntrn+nval+ntes,:);

fprintf('\nCriação da RNA ...\n');

xMinxMax = [min(Xtrn(:,1)) max(Xtrn(:,1)); min(Xtrn(:,2)) max(Xtrn(:,2)); min(Xtrn(:,3)) max(Xtrn(:,3))];      
   
[net1] = newff(xMinxMax, [4 4 4], {"tansig", "tansig", "purelin"}, "trainlm", "learngdm", "mse");

fprintf('\nTreinamento ...\n\n');

VV.P = Xval';
VV.T = Yval';

[net2] = train(net1,Xtrn',Ytrn',[],[],VV);

fprintf('Operacao ...\n');

[simOut] = sim(net2,Xtes');

% pos-processamento
lim_inf = 0.1;
lim_sup = 0.9;
simOut = simOut';
Ypos = []; % saida pos-processada
for (i = 1 : size(simOut,1))
  for (j = 1 : size(simOut,2))
    if (simOut(i,j) <= lim_inf)
      Ypos(i,j) = 0;
    end
    if (simOut(i,j) >= lim_sup)
      Ypos(i,j) = 1;
    end
  end
end

% calculo do desempenho
som = 0;
for (i = 1 : size(Ytes,1))
  if (sum(Ytes(i,:) == Ypos(i,:)) == 4)
    som = som + 1;
  end
end

tc = (som/size(Ytes,1)) * 100;
fprintf('\nTaxa de classificacao correta: %3.2f %%\n\n',tc);