%Dados coletados no G1 referente as pesquisas em 2010 fornecidas pelo ibge
%Brasileiros dos 20 aos 24 
%Homens   peso: 69.4kg e altura 1.73m 
%Mulheres peso: 57.8kg e altura 1.61m

clear all; 
% par√¢metros
m1 = [69.4 1.73]; % Media da Classe dos Homens
m2 = [57.8 1.61]; % Media da Classe das Mulheres 
var1 = [5 0.2]; % Variancia da Classe dos Homens 
var2 = [3 0.1]; % Variancia da Classe das Mulheres 
nc1 = 100; % Numero de Padrıes das Classe dos Homens 
nc2 = 100; % Nuemro de Padrıes das Classe das Mulheres 
nc = nc1 + nc2; % Numero total de Padrıes 

for k = 1 : nc1
    c1(k,:) = [(m1(1)+sqrt(var1(1))*randn) (m1(2)+sqrt(var1(2))*randn)]; % classe 1 
end

for k = 1 : nc2
    c2(k,:) = [(m2(1)+sqrt(var2(1))*randn) (m2(2)+sqrt(var2(2))*randn)]; % classe 2   
end
c1(:,3) = 0;
c2(:,3) = 1;
x = [c1 ; c2]; % dados de entrada
idc = randperm(nc1+nc2); % √≠ndices permutados aleatoriamente

x = x(idc,:); % dados de entrada distribuidos randomicamente

x = x'

%[l,c] = size(x);
   
w = Mapa_Kohonen(x,8);
plot(x(1,:),x(2,:),'ko')
hold on
plot(w(1,:),w(2,:),'bx')
