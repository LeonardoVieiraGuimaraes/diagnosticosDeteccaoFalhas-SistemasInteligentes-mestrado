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
figure(1)
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
Xmin = min(X);
Xmax = max(X);
X(1,:) - Xmin(1,:)
Xmax(1,:)- Xmin(1,:)
for i= 1:1:length(X(:,1))
    XN(i,:) = (X(i,:) - Xmin(1,:))./ (Xmax(1,:)- Xmin(1,:));
end

[m,n] = size(X);

mt = m*80/100
mo = m*20/100

XT = XN(1:mt,:);
XO = XN((mo+1):end,:);
ner = 2;
W = rand([n,ner]);
vetorerro = 0;

XT = XT';
XO = XO';

n = 0.1;
epoca = 1;
l = 0.00001;

while true
    
    for k=1:1:length(XT(1,:))
        
        
        
        
        for j=1:1:length(XT(:,1))   
            D(k,j) = norm((XT(:,k) - W(:,j)));
         end
        
        [mi,in] = min(D(k,:));
        WA = W;
        W(:,in) = W(:,in) + n*(XT(:,k) - W(:,in));
        e = WA(:,in) - W(:,in);
        p = sum(e)/2;
        vetorerro = vetorerro + p^2;
    end
    
   
   erro(:,epoca) = vetorerro/length(XT(1,:));
   epoca = epoca + 1;
   vetorerro = 0;
    if erro <= l
        break
    end
    if epoca == 100
        break;
    end
end




    
    
 


for k=1:1:length(XO(1,:))
        
    for j=1:1:length(XO(:,1))
       DO(k,j) = norm((XO(:,k) - W(:,j))); 
    end
        
    [mi,in] = min(DO(k,:));
    YO(1,k) = in;  
        
end
W = W'
for i= 1:1:length(W(1,:))
    W(i,:) = W(i,:).*(Xmax - Xmin) + Xmin;
end

figure(2);
plot(erro);

figure(3)
plot(X(:,1),X(:,2),'bo');

hold on;
plot(W(1,1),W(1,2),'k*');
plot(W(2,1),W(2,2),'k*');
legend('Cluster1', 'Cluster2');
title('Clusters');
    
   
  
    




