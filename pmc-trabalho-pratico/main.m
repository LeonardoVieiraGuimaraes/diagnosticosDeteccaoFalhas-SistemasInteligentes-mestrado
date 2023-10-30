clear all;
close all;
dados = load('dados_21.txt');
x = dados(:,1:3)'
y = dados(:,4)'
epoca = 0;
validacao = [0.0611 0.2860 0.7464 0.4831
    0.5102 0.7464 0.0860 0.5965
    0.0004 0.6916 0.5006 0.5318
    0.9430 0.4476 0.2648 0.6843
    0.1399 0.1610 0.2477 0.2872
    0.6423 0.3229 0.8567 0.7663
    0.6492 0.0007 0.6422 0.5666
    0.1818 0.5078 0.9046 0.6601
    0.7382 0.2647 0.1916 0.5427
    0.3879 0.1307 0.8656 0.5836
    0.1903 0.6523 0.7820 0.6950
    0.8401 0.4490 0.2719 0.6790
    0.0029 0.3264 0.2476 0.2956
    0.7088 0.9342 0.2763 0.7742
    0.1283 0.1882 0.7253 0.4662
    0.8882 0.3077 0.8931 0.8093
    0.2225 0.9182 0.7820 0.7581
    0.1957 0.8423 0.3085 0.5826
    0.9991 0.5914 0.3933 0.7938
    0.2299 0.1524 0.7353 0.5012];
xval = validacao(:,1:3);
yval = validacao(:,4);
for i=1:1
    epoca = epoca + 50000;
    [net tr pesos val] = mlp_matlab(x,y, xval, epoca);
    yvalidacao(:,i) = val';
    erroqm(:,i) = tr.best_perf;
    erro(:,i) = mean(abs(yval' - val)./yval')*100;
    variancia(:,i) = var(val);
    figure(i);
    plotperform(tr);
end