close all; 
clear all;
npoints = 100;
X = linspace(-3, 3, npoints);
Y = linspace(0, 1, npoints);

x1 = gaussmf(X, [1.5 -3]);

x3 = gaussmf(X,   [1.5 3]);


%sugeno primeira ordem 
 y1 = zeros(length(X),1)' + 0;

 y3 = zeros(length(X),1)'+1;

for i = 1:length(X);
    w1 = x1(1,i);
  
    w3 = x3(1,i);
    
    
    Y2(1,i) = (w1.*y1(1,i)  + y3(1,i).*w3)/(w1+w3);
end




figure(1)
plot(X,x1, 'linewidth',3);
hold on;

plot(X,x3, 'linewidth',3);






figure(3)
plot(X,Y2, 'linewidth',3);
hold on;




