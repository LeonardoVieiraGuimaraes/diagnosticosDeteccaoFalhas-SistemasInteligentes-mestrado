clear all; 
pesos = load('pesos2.txt');
um = load('um.txt');

yval = um(1:160,169:172);
xval = um(1:160,1:168)';

yvalidacao = xval*pesos
[m n] = size(yvalidacao);
for i = 1:m
    for j = 1:n
        if yvalidacao(i,j) >= 0.5
            yvalidacao(i,j) = 1;
        else 
            yvalidacao(i,j) = 0;
        end
    end
end

acerto = 0; 
erro = 0 ;    

for j = 1:n
    if yvalidacao(:,j) == yval(:,j) 
        acerto = acerto + 1;      
    else
        erro = erro + 1;
    end
end
    