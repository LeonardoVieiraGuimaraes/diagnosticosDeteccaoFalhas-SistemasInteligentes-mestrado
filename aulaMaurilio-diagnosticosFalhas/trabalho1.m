clear all; 
close all; 
x = 0:0.01:120;

ua = trimf(x,[0 40 80]);  
ub = trimf(x, [10 80 120]);

%ua = trapmf(x,[10 20 50 80]);
%ub = trapmf(x,[30 40 100 120]);

%ua = gaussmf(x,[20 40]);
%ub = gaussmf(x,[20 60]);

%ua = gbellmf(x,[20, 10, 40]);
%ub = gbellmf(x,[30, 20, 60]);

%ua = sigmf(x,[-0.5 80]);
%ub = sigmf(x,[0.5 40]);


%complemento
lambda = 10;
w = 10;
uzadeh = 1-ua;
usugeno = (1-ua)./(1+lambda*ua);
uyager = (1-ua.^w).^(1/w);

%interseção 
uminimo = min(ua,ub);
ualgebricoi = ua.*ub;
ulimitadoi = max(0, ua+ub-1); % ua se ub = 1
%udrasticoi % ua se ub = 1 / ub se ua = 1 / 0 caso conrario
for j = 1:length(x(1,:))
    if ub(1,j)==1
        udrasticoi(1,j) = ua(1,j);
    end
    if ua(1,j)==1
        udrasticoi(1,j) = ub(1,j);
    else
        udrasticoi(1,j) = 0;
    end
end

%união
umaximo = max(ua,ub);
ualgebricou = ua + ub - ua.*ub; 
ulimitadou = min(1,ua+ub);% ua se ub = 0

for j = 1:length(x(1,:))
    if ub(1,j)==0
        udrasticou(1,j) = ua(1,j);
    end
    if ua(1,j)==0
        udrasticou(1,j) = ub(1,j);
    else
        udrasticou(1,j) = 1;
    end
end
    %udrasticou % ua se ub = 0 / ub se ua =0 / 1 se caso contrario


figure(1);
plot(x,ua,'linewidth',3);
hold on; 
plot(x,ub,'linewidth',3);
title ('Gráfico I - Pertinêcia A e B')
xlabel ('x')
ylabel ('u(x)')
legend('A','B')

figure(2)
plot(x,uzadeh,'linewidth',3);
title ('Gráfico II - Complemento A: Zadeh')
xlabel ('x')
ylabel ('u(x)')

figure(3);
plot(x,usugeno,'linewidth',3);
title ('Gráfico III - Complemento de A: Sugeno')
xlabel ('x')
ylabel ('u(x)')

figure(4);
plot(x,uyager,'linewidth',3);
title ('Gráfico IV - Complemento de A: Yager')
xlabel ('x')
ylabel ('u(x)')

figure(5);
plot(x,uminimo, 'linewidth',3);
title ('Gráfico V - Interseção de A e B: Mínimo')
xlabel ('x')
ylabel ('u(x)')

figure(6);
plot(x,ualgebricoi, 'linewidth',3);
title ('Gráfico VI - Interseção  de A e B: Produto Algébrico')
xlabel ('x')
ylabel ('u(x)')

figure(7);
plot(x,ulimitadoi, 'linewidth',3);
title ('Gráfico VII - Interseção de A e B: Produto Limitado')
xlabel ('x')
ylabel ('u(x)')

figure(8);
plot(x,udrasticoi, 'linewidth',3);
title ('Gráfico VIII - Interseção de A e B: Produto Drástico')
xlabel ('x')
ylabel ('u(x)')


figure(9);
plot(x,umaximo, 'linewidth',3);
title ('Gráfico IX - União de A e B: Máximo')
xlabel ('x')
ylabel ('u(x)')

figure(10);
plot(x,ualgebricou, 'linewidth',3);
title ('Gráfico X - União de A e B: Soma Algébrica')
xlabel ('x')
ylabel ('u(x)')

figure(11);
plot(x,ulimitadou, 'linewidth',3);
title ('Gráfico XI - União de A e B: Soma Limitada')
xlabel ('x')
ylabel ('u(x)')

figure(12);
plot(x,udrasticou, 'linewidth',3);
title ('Gráfico XII - União de A e B: Soma Drástica')
xlabel ('x')
ylabel ('u(x)')

