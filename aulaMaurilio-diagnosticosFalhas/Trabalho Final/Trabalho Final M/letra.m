clear all; 
[A map] = imread('cum.jpg');

I = rgb2gray(A);

[m n p] = size(A)
D=I;
%D = imresize(I, [40 38],'bilinear');
%[m n p] = size(D)
figure (2);
imshow(D);

for i = 1:m
    for j = 1:n
        if D(i,j) ~= 255  
           
            C(i,j) = D(i,j); 
            
            
        else
          %C(i,j) = 255;
          % C(i,j) = D(i,j);
           
        end
   end
end
[m n] = size(C);
for i = 1:m
    for j = 1:n
        if C(i,j) == 0 
           
            C(i,j) = 255; 
            
        end
        
   end
end





figure(1);
imshow(C);
