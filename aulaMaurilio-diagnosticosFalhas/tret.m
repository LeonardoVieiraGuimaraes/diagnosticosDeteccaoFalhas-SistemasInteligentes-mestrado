[x,t] = iris_dataset;
net = patternnet;
net = configure(net,x,t);
view(net)