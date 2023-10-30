%%filtro de particulas bootstrap

clc; clearvars; close all
%ruido do processo prob B
global sigmax, sigmax = [0.5 0.005]';
global sigmav, sigmav= 0.25;
global ffun, ffun = 'eq_dynB';
global gfun, gfun='eq_obsB';

rng(1);

%N = 100; 

%tspan = 1:1:N; 

NRuns = 1; 
Nsamp=50;
NT = 0.75;
x0=[0 0.002]';

%taxa de esquecimento
gama = 0.99;

%dist inicial 
d =size(x0,1);
x_0 = repmat(x0,1,Nsamp) + repmat(sigmax,1,Nsamp).*randn(d,Nsamp,1);

[y,x] = SimulateExpB();
N = length(x);
tspan=1:1:N;

%inicializacao

X = zeros(d,Nsamp, N);
Xmean = zeros(d,N);
Xcov = zeros(d,d,N);
Xmode = zeros(d,N);
W = zeros(N,Nsamp);
figure
plot(tspan,x,tspan,y);
legend('Real', 'Medido');

for j = 1:NRuns
    [X,W] = bootstrapPF(y,x_0,tspan,Nsamp, NT, gama);
    [~,ind] = max(W');

    for t=1:N
        Xmean(:,t) = X(:,:,t)*W(t,:)';
        Xmode(:,t) = X(:,ind(t), t);
        Xcov(:,:,t) = X(:,:,t)*diag(W(t,:))*X(:,:,t)' - Xmean(:,t)*Xmean(:,t)';
    end


ErrMean(j) = norm(x(1,:) - Xmean(1,:))/sqrt(N);
ErrMode(j) = norm(x(1,:) - Xmode(1,:))/sqrt(N);
end

disp(mean(ErrMean,2));
disp(mean(ErrMode,2));

figure
subplot(2,1,1)
plot(tspan, x(1,:), tspan, Xmean(1,:), 'r--');
sig = sqrt(abs(Xcov(1,1,:)));
hold on
plot(tspan, Xmean(1,:)-3*sig(1,:), 'k:');
hold on
plot(tspan, Xmean(1,:)+3*sig(1,:), 'k:');
legend('Real', 'Estimado media', '3sig');

subplot(2,1,2)
plot(tspan, x(1,:), tspan, Xmode(1,:), 'r--');
sig = sqrt(abs(Xcov(1,1,:)));
hold on
plot(tspan, Xmode(1,:)-3*sig(1,:), 'k:');
hold on
plot(tspan, Xmode(1,:)+3*sig(1,:), 'k:');
legend('Real', 'Estimado media', '3sig');
