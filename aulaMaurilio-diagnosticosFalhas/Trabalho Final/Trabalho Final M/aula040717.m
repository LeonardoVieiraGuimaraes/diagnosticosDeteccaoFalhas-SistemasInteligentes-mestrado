clear all;
x = [.1 .3 .5 .7; .1 .3 .4 .7];
d =[.01 .09 .25 .49];
w1 = rand(2,3);
y11 = x'*w1;
y1 = gaussmf(y11,[3 5]);
w2 = pinv(y1'*y1)*(y1'*d');
y = (y1*w2)'

t = [.4 .4]*w1;
t = gaussmf(t,[3 5]);
yt = (t*w2)'

dados = load('dados_31.txt');
x = dados(:,1:4)'
y = dados(:,5:7)'

w1 = rand(4,3);
y11 = x'*w1;
y1 = gaussmf(y11,[3 5]);
w2 = pinv(y1'*y1)*(y1'*d');

