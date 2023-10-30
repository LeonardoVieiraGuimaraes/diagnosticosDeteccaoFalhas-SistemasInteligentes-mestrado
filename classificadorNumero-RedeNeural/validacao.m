

dados = load('validacao.txt');
xval = dados(1:10,1:168);

yvalidacao = sim(net,xval);

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