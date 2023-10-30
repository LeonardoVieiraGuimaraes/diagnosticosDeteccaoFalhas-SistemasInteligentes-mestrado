function [net tr pesos validacao] = mlp_matlab(x,y, xvalidacao, epoca)
    net = newff([min(x')' max(x')'], [168,169, 4],{'logsig','logsig','purelin'}, 'traingdm');
    net.trainParam.epochs = epoca;
    net.trainParam.goal = 10^-4;
    net.trainParam.mc = 0.9;
    net.trainParam.lr = 0.1;
    %net.trainParam.show = 25;
    [net tr] = train(net,x,y);
    pesos = net.IW{1};
    validacao = sim(net,xvalidacao);
end