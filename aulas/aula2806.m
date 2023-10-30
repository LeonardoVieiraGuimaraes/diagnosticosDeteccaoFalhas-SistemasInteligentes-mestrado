x = [.1 .3 .4; .1 .3 .4]
y = [.1 .3 .4]
w = [.3 .2; .1 .4]

[w1 w2] = mlp_mls(x,y);
%[Y] = teste_mlp_mls(w1,w2,x)


[net1] = mlp_matlab(x,y)
%y = sim(nwt1,x)


%y1 = w*x
%a = y1*y1'
%a = pinv(a)
%b = y1*y'

%w2 = a*b


%(w*w2)'*w2


