clear all;
dados = load('dados1.txt');
x = dados(:,1:3)';
d = dados(:,4)';
[n m] = size(x);
w = rand(n,1);
z = x'*w;

for p = 1:m   
    y(:,p) = 1/(1+exp(-2*z(p,:)));
end
k = 1;
erro(k) = 1/2*(sum((d - y).^2));

while erro(k) > 0.05
    for i = 1:n
        for j = 1:m
            w(i,1) = w(i,1) + 0.001*2*(d(1,j) - (1 / (1+exp(-2*z(j,1)))))*x(i,j)*exp(-2*z(j,1))/((1+exp(-2*z(j,1)))^2);
        end
    end
    z = x'*w;
    for p = 1:m   
        y(:,p) = 1/(1+exp(-2*z(p,:)));
    end
        k = k+1;
        erro(k) = 1/2*(sum((d - y).^2));
   
    if k >1000
        break
    end
end
plot(erro);
    