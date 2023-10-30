% Gera dados para clustering com 2 classes

close all;
clear;
clc;

% parâmetros
m1 = [3 2]; % média da classe 1
m2 = [1 3]; % média da classe 2
var1 = [0.1 0.1]; % variância da classe 1
var2 = [0.1 0.1]; % variância da classe 2
nc1 = 100; % número de padrões da classe 1
nc2 = 100; % número de padrões da classe 2
nc = nc1 + nc2; % número total de padrões

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
y1(1:nc1) = 1;
y2(1:nc2) = 2;
Y = [y1, y2]'; % rotulos das classes
idc = randperm(nc1+nc2); % índices permutados aleatoriamente
X = X(idc,:); % dados de entrada distribuidos randomicamente
Y = Y(idc);

Ru(1,1) = 0;

i = 1;
a = 1;
x = X(:,1);
y = X(:,2);
Ccx(1,1) = x(1,1);
Ccy(1,1) = y(1,1);
Cx(1,1) = x(1,1);   
Cy(1,1) = y(1,1);
Dthr = 2.6;
ni = length(X)
nj = length(Ccx);
while true
    
    
    i = i +1;
    for j = 1:1:length(Ccx)
        D(1,j) =  sqrt((x(i,1) - Ccx(1,j)).^2 + (y(i,1) - Ccy(1,j)).^2)
       
    end
    
        
          
       if min(D) <= Ru(1,j)
           
           
    
     
    else
        for j = 1:1:length(Ccx)
            S(1,j) = D(1,j) + Ru(1,j);
            
        end
        Sa = min(S);
            if Sa > (2*Dthr)
                a = a+1;
                Ccx(1,a) = x(i,1);
                Ccy(1,a) = y(i,1);
                Ru(1,a) = 0;
                
            else
                Ra = Sa/2;
                Ccxa = x(i,1);
                Ccya = y(i,1);
                Ru(1,j) = Ra;
                Ccx(1,j) = Ccxa;
                Ccy(1,j) = Ccya;
                  
            end
        end
    
    
    if i == ni
        break
    end
    
    end
    