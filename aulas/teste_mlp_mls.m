function [y] = teste_mlp_mls(w1,w2,x)
    y = (w*x)'*w2;
end