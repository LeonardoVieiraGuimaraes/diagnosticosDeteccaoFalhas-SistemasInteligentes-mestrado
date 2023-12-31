clear all;
dados = load('dados_31.txt');
x = dados(:,1:4)';
d = dados(:,5:7)';

w1 = rand(4,4);
y11 = x'*w1;
y1 = gaussmf(y11,[3 5]);
w2 = pinv(y1'*y1)*(y1'*d');
y = y1*w2;



validacao = [0.8622 0.7101 0.6236 0.7894 0 0 1
0.2741 0.1552 0.1333 0.1516 1 0 0
0.6772 0.8516 0.6543 0.7573 0 0 1
0.2178 0.5039 0.6415 0.5039 0 1 0
0.7260 0.7500 0.7007 0.4953 0 0 1
0.2473 0.2941 0.4248 0.3087 1 0 0
0.5682 0.5683 0.5054 0.4426 0 1 0
0.6566 0.6715 0.4952 0.3951 0 1 0
0.0705 0.4717 0.2921 0.2954 1 0 0
0.1187 0.2568 0.3140 0.3037 1 0 0
0.5673 0.7011 0.4083 0.5552 0 1 0
0.3164 0.2251 0.3526 0.2560 1 0 0
0.7884 0.9568 0.6825 0.6398 0 0 1
0.9633 0.7850 0.6777 0.6059 0 0 1
0.7739 0.8505 0.7934 0.6626 0 0 1
0.4219 0.4136 0.1408 0.0940 1 0 0
0.6616 0.4365 0.6597 0.8129 0 0 1
0.7325 0.4761 0.3888 0.5683 0 1 0];
xval = validacao(:,1:4);
yval = validacao(:,5:7);

t = xval*w1
t = gaussmf(t,[3 5]);
yvalidacao = (t*w2);

[m n] = size(yvalidacao);
    for i = 1:m
        for j = 1:n
            if yvalidacao(i,j) <= 0.5
                yvalidacao(i,j) = 0;
            else 
                yvalidacao(i,j) = 1;
            end
        end
     end
    
    acerto = 0; 
    erro = 0 ;
    for i = 1:m
        
            if yvalidacao(i,1) == yval(i,1) & yvalidacao(i,2) == yval(i,2) & yvalidacao(i,3) == yval(i,3)
                acerto = acerto + 1;
                
            else 
                erro = erro + 1; 
            end
        
    end

acertop = 100*acerto/18 
