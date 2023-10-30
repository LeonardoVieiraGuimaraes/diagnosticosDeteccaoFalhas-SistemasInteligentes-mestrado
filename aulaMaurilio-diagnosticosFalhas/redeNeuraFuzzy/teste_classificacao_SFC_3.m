% Teste de classificacao de padroes com Sistema Fuzzy (2 classes e 16 regras)

close all;
clc;
more off;

% executa a classificacao
[ C ] = sfc_3(X);
 
% tamanho do conjunto de dados
n = size(X,1);

% inicializa variaveis
TP = 0;
FN = 0;
FP = 0;
TN = 0;

% calcula variaveis
for k = 1 : n
  if ((C(k) == 1) && (Y(k) == 1))
    TP = TP + 1;
  endif
  if ((C(k) == 1) && (Y(k) == 2))
    FP = FP + 1;
  endif
  if ((C(k) == 2) && (Y(k) == 1))
    FN = FN + 1;
  endif
  if ((C(k) == 2) && (Y(k) == 2))
    TN = TN + 1;
  endif  
end

% calcula metricas
Acc = ((TP + TN) / n) * 100;
Err = ((FP + FN) / n) * 100;
TPr = (TP / (TP + FN)) * 100;
FPr = (FP / (FP + TN)) * 100;

% exibe resultados
fprintf('\n\n_ Teste de classificacao de padroes com Sistema Fuzzy (2 classes e 16 regras) _\n\n');
fprintf('Metricas:\n')
fprintf('Acuracia = %3.2f %%\n',Acc);
fprintf('Taxa de Erro = %3.2f %%\n',Err);
fprintf('Taxa de Verdadeiro Positivo= %3.2f %%\n',TPr);
fprintf('Taxa de Falso Positivo = %3.2f %%\n\n',FPr);