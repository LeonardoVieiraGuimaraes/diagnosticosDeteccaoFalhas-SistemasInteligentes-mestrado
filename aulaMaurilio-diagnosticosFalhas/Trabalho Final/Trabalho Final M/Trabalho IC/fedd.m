clear all;
%Obten��o das amostras 
um = load('um.txt');
zero = load('zero.txt');
dois = load('dois.txt');
treis = load('treis.txt');
quatro = load('quatro.txt');
cinco = load('cinco.txt');
seis = load('seis.txt');
sete = load('sete.txt');
oito = load('oito.txt');
nove = load('nove.txt');
%realocando os danos um uma matriz de dados
dados = [zero; um; dois; treis; quatro; cinco; seis ;sete ;oito; nove];
[m n] = size(dados);
%permuta��o aleatoria dos dados 
idc = randperm(m); 
dados = dados(idc,:);
%obten��o dos dados para treinamento 
x = dados(1:m-101,1:168)';
y = dados(1:m-101,169:172)';

epoca = 5000;

%obten��o dos dados para validacao
xval = dados(m-100:m,1:168)';
yval = dados(m-100:m,169:172)';
%execu��o do treinamento e plotagem do erro 


net = feedforwardnet([170], 'traingdm')
net.trainParam.epochs = epoca;net.trainParam.goal = 10^-4;
net.trainParam.mc = 0.9;
net.trainParam.lr = 0.1;
net.trainParam.show = 25;
net.trainParam.max_fail = 101
[net tr] = train(net,x,y);
validacao = sim(net,xval);
yvalidacao = validacao
view(net)
[m n] = size(yvalidacao); 

%Validacao dos valores 
for i = 1:m
    for j = 1:n
        if yvalidacao(i,j) >= 0.5
            yvalidacao(i,j) = 1;
        else 
            yvalidacao(i,j) = 0;
        end
    end
end
%conferencia de acerto e erro
acerto = 0; 
erro = 0 ;    

for j = 1:n
    if yvalidacao(:,j) == yval(:,j) 
        acerto = acerto + 1;      
    else
        erro = erro + 1;
    end
end
    

