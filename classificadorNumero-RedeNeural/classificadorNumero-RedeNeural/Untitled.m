clear all; 
A = imread('dois4.jpg');
I = rgb2gray(A);
I = mat2gray(I);
[lm cn] = size(I);
k = 0;

a = fix(lm/5);
b = fix(cn/4);
%arquivo = fopen('um.txt', 'w');   
for l = 0:4
    for c = 0:3
        k = k + 1;
        imag = I((1 + a*l):a*(l+1),(1 + b*c):b*(c+1));
        D = imag;
        %figure(k)
        %imshow(imag)
        D = imresize(D, [14 12],'bilinear');
        [m n] = size(D);
        arquivo = fopen('dois.txt', 'a');
        for i = 1:m
            for j=1:n
            fprintf(arquivo, '%d ',D(i,j));   
            end
        end
        fprintf(arquivo, '0 0 1 0');
        fprintf(arquivo,'\n');
    
    end
end
fclose(arquivo);

