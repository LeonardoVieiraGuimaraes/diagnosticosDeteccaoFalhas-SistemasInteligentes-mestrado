clear;
close all;
%x varia de -17 a 2000
clear all;
close;
%x = zeros(1,2018);
tau = 17;
k = 1;
x(tau+1) = 1.2;
d(tau+1) = 1.2;
for t = -17:2000
    if t<0
        x(k) = 0;
    else
        x(k+1) = 0.2*x(k-tau)/(1+(x(k-tau))^10) - 0.1*x(k);
        
    end
k = k +1;
end

integral(
