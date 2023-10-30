close all; 
clear all;

A = 0:(2*pi/1000):2*pi;
B = -0.2:(1+0.2)/1000:1;
Yd = sin(A)./A;
mfx1 = gaussmf(A,[pi 0]);%ALTO
mfx2 = gaussmf(A,[pi/2 3*pi/2]);%BAIXO

mfy1 = gaussmf(B,[0.2 -0.2]); %BAIXO
mfy2 = gaussmf(B,[1 1]);% ALTO

for i = 1:length(mfx1) 
    for j = 1:length(mfx2)
        R1(i,j) = min(mfx1(1,i),mfy2(1,j));
    end
end


[m n] = size(R1)
for j = 1:n
    for i= 1:m
        R11(i,j) = min(mfx1(1,i),R1(i,j));
    end
end

R111 = max(R11);

for i = 1:length(mfx1) 
    for j = 1:length(mfx2)
        R2(i,j) = min(mfx2(1,i),mfy1(1,j));
    end
end


[m n] = size(R2)
for j = 1:n
    for i= 1:m
        R22(i,j) = min(mfx2(1,i),R2(i,j));
    end
end


R222 = max(R22);

Resultado = max(R222,R111);

for k = 1:length(B)
    Z(1,k) = defuzz(B(1,k),Resultado(1,k),'centroid');
end


plot(A,Z)

