function [w1 w2] = mlp_mls(x,y)
    n = size(x,1);
    m = 10;
    w1 = rand(m,n);
    y1 = w1*x;
    w2 = pinv(y1*y1')*(y1*y')
end
    