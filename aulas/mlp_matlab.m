function [net1] = mlp_matlab(x,y)
    net = newff([min(x')' max(x')'], [3,3],{'logsig','purelin'}, 'traingd');
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 1e-16
    net1 = train(net,x,y);
    
end