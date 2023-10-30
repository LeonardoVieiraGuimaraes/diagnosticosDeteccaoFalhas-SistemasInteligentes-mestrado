clear all; 
[A map] = imread('cum.jpg');




I = rgb2gray(A);

[m n] = size(I);


im1 = I(1:700,1:632)
im2 = I(701:1400,1:632)
im3 = I(1401:2100,1:632)
im4 = I(2101:2800,1:632)
im5 = I(2801:3500,1:632)
%D = imresize(I, [9 6],'bilinear');

[m n p] = size(D)
figure (2);
imshow(A);

for i = 1:m
    for j = 1:n
        if D(i,j) <= 200  
           
            C(i,j) = 0; 
        
        else
            C(i,j) = 255;
        end
        
            
end
end
k = 1; 
[m n] = size(C)
for i = 1:m
    for j = 1:n
        
       
        v(1,k) = C(i,j);
        k = k + 1;
            
    end
end



figure(1);
imshow(C);
