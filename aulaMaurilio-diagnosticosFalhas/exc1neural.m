clear;
close;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
X = linspace(-10, 10, 11);
Y = linspace(-10, 10, 11);
[X Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);
figure
surf(X,Y,Z);
%m = length(X);
%idc = randperm(m)'; 
%X = X(idc,:)';
%Y = Y(idc,:)';
%Z = Z(idc,:)';
input = [X(:) Y(:)]';
output = Z(:)';
trainFcn = 'trainlm';
net = feedforwardnet(20);



% 'trainlm'	 Levenberg-Marquardt
% 'trainbr'	Bayesian Regularization
% 'trainbfg'	 BFGS Quasi-Newton
% 'trainrp'	 Resilient Backpropagation
% 'trainscg'	 Scaled Conjugate Gradient
% 'traincgb'	Conjugate Gradient with Powell/Beale Restarts
% 'traincgf'	Fletcher-Powell Conjugate Gradient
% 'traincgp'	Polak-Ribiére Conjugate Gradient
% 'trainoss'	One Step Secant
% 'traingdx'	Variable Learning Rate Gradient Descent
% 'traingdm'	Gradient Descent with Momentum'traingd'



net.trainParam.epochs = 150;
net.trainParam.goal = 10^-7;
%net.trainParam.mc = 0.9;
%net.trainParam.max_fail = 6
%net.trainParam.max_perf_inc = 1.04
%net.trainParam.min_grad
%net.trainParam.show = 25
net.trainParam.lr = 0.1;

net = train(net,input,output);
view(net);

y = net(input);
perf = perform(net,y,output);
figure
plot3(X,Y,y)