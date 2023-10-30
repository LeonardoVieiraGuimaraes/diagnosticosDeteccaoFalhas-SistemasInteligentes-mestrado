clear
x(1) = 1.2;
tau = 17
for k = 1:2000
    
    x(k+1) = quad(inline('0.2*x - 0.1'),0,2000);
end
