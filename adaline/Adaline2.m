clear all;
x = [.2 .1 .4;.2 .1 .5];
d = [.2 .1 .1];
[n m] = size(x);
w = rand(n,1);
z = x'*w;
y = 1/(1+exp(-2*z));
k = 1;
erro(k) = 1/2*sum(d - y)^2;

while erro(k) > 0.0005
    for i = 1:n
        for j = 1:m
            w(i,1) = w(i,1) - 0.4*2.*x(i,j)*exp(-2*z(i,1))/(1+exp(-2*z(i,1)))^2;
        end
    end
    z = x'*w;
    y = 1 / (1+exp(-2*z));
    k = k+1;
    erro(k) = 0.5*(sum(d - y))^2;
   
    if k >100
        break
    end
end
plot(erro);
    