close all;
clear;
clc;

% parï¿½metros
m1 = [1 3]; % mï¿½dia da classe 1
m2 = [2 5]; % mï¿½dia da classe 2
m3 = [4 4]; % mï¿½dia da classe 3
var1 = [0.1 0.1]; % variï¿½ncia da classe 1
var2 = [0.1 0.1]; % variï¿½ncia da classe 2
var3 = [0.1 0.1]; % variï¿½ncia da classe 3
nc1 = 100; % nï¿½mero de padrï¿½es da classe 1
nc2 = 100; % nï¿½mero de padrï¿½es da classe 2
nc3 = 100; % nï¿½mero de padrï¿½es da classe 3
nc = nc1 + nc2 + nc3; % nï¿½mero total de padrï¿½es

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
idc = randperm(nc1+nc2+nc3); % ï¿½ndices permutados aleatoriamente
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
                  %antigo mais a posição do centro angito 
                  u(1,1) = X(i,1)-Cc(1,ins);  
                  u(2,1) = X(i,2)-Cc(2,ins);
                  Cc(:,ins) = Cc(:,ins) + Ra*u(:,1);
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
    FP = FP + 1;5321 end
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


    