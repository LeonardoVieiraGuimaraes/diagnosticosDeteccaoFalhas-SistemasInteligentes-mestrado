function [net tr pesos validacao] = mlp_matlab(x,y, xvalidacao, epoca)
    
    net = newff([min(x')' max(x')'], [168,1],{'logsig','purelin'}, 'traingd');
    net.trainParam.epochs = epoca;
    net.trainParam.goal = 10^-6;
    net.trainParam.lr = 0.1;
    net.trainParam.show = 25;
    [net tr] = train(net,x,y);
    pesos = net.IW{1,1};
    validacao = sim(net,xvalidacao');
end