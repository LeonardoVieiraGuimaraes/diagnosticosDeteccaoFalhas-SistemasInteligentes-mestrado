clear all;
x = [.2;.2];
d = .02;
n = size(x,1);
w = rand(n,1);
z = x'*w;
y = 1/(1+exp(-2*z));
i = 1;

erro(i) = d - y;

while abs(erro(i)) > 0.005
    if erro(i) > 0
        w(1) = w(1) + 0.4*2*x(1)*exp(-2*z)/(1+exp(-2*z))^2;
        w(2) = w(2) + 0.4*2*x(2)*exp(-2*z)/(1+exp(-2*z))^2;
    end
    if erro(i) < 0
        w(1) = w(1) - 0.4*2*x(1)*exp(-2*z)/(1+exp(-2*z))^2;
        w(2) = w(2) - 0.4*2*x(2)*exp(-2*z)/(1+exp(-2*z))^2;
    end
    z = x'*w;
    y = 1 / (1+exp(-2*z));
    i = i+1;
    erro(i) = d - y;
    if i >100
        break
    end
end
plot(erro);
    