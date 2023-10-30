%pag 372
clear all;
close all;
%16 regras 4 funções para cada variavel 72 parametros 24 premissias nonlinear 48
%consequentes linear
X = (-10:20/100:10)';
Y = (-10:20/100:10)';
[X Y] = meshgrid(X,Y);
Z = (sin(X).*sin(Y))./(X.*Y);
surf(X,Y,Z);

data = [X(:) Y(:) Z(:)]

numMFs = [4 4];
mfType = char('trimf', 'trimf');
dispOpt = [0 0 0 0];   

for k = 1:length(Z(1,:))
    fismat = genfis1([X(:,k) Y(:,k) Z(:,k)], numMFs, mfType);
    [fis,erro(:,k)] = anfis([X(:,k) Y(:,k) Z(:,k)],fismat,150,dispOpt);
    [x,y,z] = gensurf(fis);
    
end

anfis(
%out = evalfis([X Y], fis);

%figure(3)
%plot(stepsize);

%figure(4)
%plot3(X,Y,Z);

%figure(5)
%plot(out);
