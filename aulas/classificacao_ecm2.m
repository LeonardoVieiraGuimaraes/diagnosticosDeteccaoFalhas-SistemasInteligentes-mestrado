% Gera dados para clustering com 2 classes

close all;
clear;
clc;

% parâmetros
m1 = [3 2]; % media da classe 1
m2 = [1 3]; % media da classe 2
var1 = [0.1 0.1]; % vari�ncia da classe 1
var2 = [0.1 0.1]; % vari�ncia da classe 2
nc1 = 100; % numero de padroess da classe 1
nc2 = 100; % numero de padroes da classe 2
nc = nc1 + nc2; % numero total de padroess

for k = 1 : nc1
    c1(k,:) = [(m1(1)+sqrt(var1(1))*randn) (m1(2)+sqrt(var1(2))*randn)]; % classe 1 
end

for k = 1 : nc2
    c2(k,:) = [(m2(1)+sqrt(var2(1))*randn) (m2(2)+sqrt(var2(2))*randn)]; % classe 2   
end

% plota as classes e os centros de classes
figure
plot(c1(:,1),c1(:,2),'bo');
hold on;
plot(c2(:,1),c2(:,2),'ro');
plot(m1(1),m1(2),'k*');
plot(m2(1),m2(2),'k*');
legend('Cluster1', 'Cluster2');
title('Clusters');

X = [c1 ; c2]; % dados de entrada
y1(1:nc1) = 2;
y2(1:nc2) = 1;
Y = [y1, y2]'; % rotulos das classes
idc = randperm(nc1+nc2); % índices permutados aleatoriamente
X = X(idc,:); % dados de entrada distribuidos randomicamente
Y = Y(idc);

 

i = 1;
a = 1;

Cc(:,1) = X(1,:);

X(1,3)= 1; 

R(1,1) = 0; 

Dthr = 1;
ni = length(X);
nj = length(Cc(1,:));


while true
    
    
    i = i +1;
    
   ig = 0;
   
   for j = 1:1:length(Cc(1,:))
        D(1,j) =  sqrt((X(i,1) - Cc(1,j)).^2 + (X(i,2) - Cc(2,j)).^2);
       
   end
   [mi, in] = min(D);
        if mi <= R(1,in)
               X(i,3) = j;
   
        else
       
            for j = 1:1:length(Cc(1,:))
                S(1,j) = D(1,j) + R(1,j);
            end
            [Sa,ins] = min(S);
       
            if Sa > (2*Dthr)
                a = a+1;
                    
                Cc(:,a) = X(i,1:2);
                X(i,3) = a;
                R(1,a) = 0;
            else
                 Ra = Sa/2;
           
                  %novo centro e igual a a metade distancia da amostra com centro
                  %antigo mais a posi��o do centro angito 
                  u = X(i,1:2)'-Cc(:,ins);  
                  Cc(:,ins) = Cc(:,ins) + Ra*u;
                  X(i,3) = ins;
                  Ru(1,ins) = Ra;  
           end
        end
    if i == ni
        break
    end
end

TP = 0;
FP = 0;
FN = 0;
TN = 0;
Y2(:,1) = X(:,3);
 
% calcula variaveis
for k = 1 : ni
  if ((Y2(k) == 1) && (Y(k) == 1))
    TP = TP + 1;
  end
  if ((Y2(k) == 1) && (Y(k) == 2))
    FP = FP + 1;
  end
  if ((Y2(k) == 2) && (Y(k) == 1))
    FN = FN + 1;
  end
  if ((Y2(k) == 2) && (Y(k) == 2))
    TN = TN + 1;
  end
end

% calcula metricas
disp('Acuracia (%)');
Acc = ((TP + TN) / ni) * 100
disp('Taxa de erro (%)');
Err = ((FP + FN) / ni) * 100
disp('Taxa de Verdadeiro Positivo (%)');
TPr = (TP / (TP + FN)) * 100
disp('Taxa de Falso Positivo (%)');
FPr = (FP / (FP + TN)) * 100


    