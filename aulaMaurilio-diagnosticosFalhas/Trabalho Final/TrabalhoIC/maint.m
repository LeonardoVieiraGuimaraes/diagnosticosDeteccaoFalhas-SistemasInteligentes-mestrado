clear all;
%Obtenção das amostras 
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
%permutação aleatoria dos dados 
idc = randperm(m); 
dados = dados(idc,:);
%obtenção dos dados para treinamento 
x = dados(1:m-101,1:168)';
y = dados(1:m-101,169:172)';

epoca = 500;

%obtenção dos dados para validacao
xval = dados(m-99:m,1:168)';
yval = dados(m-99:m,169:172)';
%execução do treinamento e plotagem do erro 
[net tr pesos val] = mlp_matlab(x,y, xval, epoca);
plotperform(tr);
yvalidacao = val;

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
    

