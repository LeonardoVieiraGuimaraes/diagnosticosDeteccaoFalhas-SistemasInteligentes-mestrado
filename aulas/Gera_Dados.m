clear all;
%Dados coletados No G1 referente as pesquisas em 2010 fornecidas pelo ibge
%Brasileiros dos 20 aos 24 
%Homens   peso: 69.4kg e altura 1.73m 
%Mulheres peso: 57.8kg e altura 1.61m

x1 = rand(2,10);
x2 = rand(2,10)+4;
x = [x1 x2];
idcperm = randperm(size(x,1));
x = x(idcperm,:);
[l,c] = size(x);
 


w = Mapa_Kohonen(x,8);

plot(x(1,:),x(2,:),'ko')
hold on
plot(w(1,:),w(2,:),'bx')




