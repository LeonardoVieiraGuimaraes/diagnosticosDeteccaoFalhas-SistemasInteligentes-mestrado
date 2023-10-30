clear all
close all

X = (-10:20/100:10)';
Y = (-10:20/100:10)';
[x y] = meshgrid(X,Y);
Z = (sin(x).*sin(y))./(x.*y);

numMFs = [3 7];
mfType = char('pimf','trimf');
fismat = genfis1([X Y Z(:,1)],numMFs,mfType);

[x,mf] = plotmf(fismat,'input',1);
subplot(2,1,1), plot(x,mf)
xlabel('input 1 (pimf)')
[x,mf] = plotmf(fismat,'input',2);
subplot(2,1,2), plot(x,mf)
xlabel('input 2 (trimf)')