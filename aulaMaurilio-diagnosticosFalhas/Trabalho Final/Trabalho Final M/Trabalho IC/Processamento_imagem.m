clear all; 
%Coloca os pixel da imagem em uma matriz 
A = imread('nove3.jpg');
%Tranforma a imagem em escala de cinza 
I = rgb2gray(A);
%realça a imagem em petro e branco
I = mat2gray(I);
[lm cn] = size(I);
k = 0;
a = fix(lm/5);
b = fix(cn/4);

%Pega a imagem redimenciona para uma matriz 14 x 12 e coloca em um arquivo
%de texto
for l = 0:4
    for c = 0:3
        k = k + 1;
        imag = I((1 + a*l):a*(l+1),(1 + b*c):b*(c+1));
        D = imag;
        D = imresize(D, [3 2],'bilinear');
        
        
        [m n] = size(D);
        arquivo = fopen('nove.txt', 'a');
        for i = 1:m
            for j=1:n
            fprintf(arquivo, '%d ',D(i,j));   
            end
        end
        fprintf(arquivo, '9');
        fprintf(arquivo,'\n');
    end
end
fclose(arquivo);

