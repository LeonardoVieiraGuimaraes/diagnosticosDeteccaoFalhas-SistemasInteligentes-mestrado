function [out y1 y2 y3 t] = simulador_cc(parametros, falhas)
% Parametros nominais
ran=parametros(1); % resistencia do circuito da armadura
rfdn=parametros(2); % resistencia do circuito de campo
Lan=parametros(3); % indutancia do circuito da armadura
Lfdn=parametros(4); % indutancia do circuito do campo
Lafd=parametros(5); % indutancia mutua armadura/campo
Jm=parametros(6); % momento de inercia do sistema motor/carga
va=parametros(7); % tensao de alimentacao do circuito da armadura
vfd=parametros(8); % tensao de alimentacao do circuito de campo
ia=parametros(9); % corrente do circuito de armadura
Bmn=parametros(10); % coeficiente de atrito viscoso
ifd=vfd/rfdn; % corrente do circuito de campo

% Valores iniciais
kmax = 5e3; % maximo de iteracoes
k = 1; % iteracao
h=0.002; % periodo de amostragem
x1(k)= 0;
x2(k)= 0;
x3(k)= 0;
C0 = 0;
C1 = 5041.7;
C2 = 0;

% Falhas em atuadores
kaa = 1; % desconexao do conversor da armadura
kafd = 1; % desconexao do conversor do campo
kcca = 0; % curto-circuito do conversor da armadura
kccfd = 0; % curto-circuito do conversor do campo
% Falhas em componentes da planta
kca_ra = 1; % variacao na ra em curto-circuito na bobina da armadura
kca_La = 1; % variacao na La em curto-circuito na bobina da armadura
kcfd_rfd = 1; % variacao na rfd em curto-circuito na bobina do campo
kcfd_Lfd = 1; % variacao na Lfd em curto-circuito na bobina do campo
kfv_ra = 1; % variacao na ra em falha no sistema de ventilacao
kfv_rfd = 1; % variacao na rfd em falha no sistema de ventilacao
kfl = 1; % variacao no Bm em falha de lubrificacao dos mancais
% Falhas de instrumentacao
kia = 1; % falha no sensor da corrente da armadura
kifd = 1; % falha no sensor da corrente do campo
kiwr = 1; % falha no sensor de velocidade da maquina
out=[];

% Simulacao
while (k <= kmax)

    % Variaveis
    ra = kca_ra * kfv_ra * ran;
    La = kca_La * Lan;
    rfd = kcfd_rfd * kfv_rfd * rfdn;
    Lfd = kcfd_Lfd * Lfdn;
    Bm = kfl * Bmn;    
    
    a1 = exp(-ra/La * h);    
    a3 = exp(-rfd/Lfd * h);
    a2(k) = (1/(rfd*La - ra*Lfd)) * ((Lafd*Lfd*(a3-a1)*x3(k)) + (ra*Lfd*a1 - rfd*La*a3));
    a5 = exp(-Bm/Jm * h);
    a4(k) = Lafd * ((1-a5)/Bm) * x2(k);
    b1 = (1-a1)/ra;
    b2 = ((1-a3)/rfd);
    d1 = -((1-a5)/Bm);
    
    % Modelo da carga
    Tl(k) = C0 + C1*x3(k) + C2*(x3(k)^2); % conjugado da carga
    
    % Modelo da maquina CC
    X = [x1(k); x2(k); x3(k)];
    A = [kaa*a1 kaa*a2(k) 0; 0 kafd*a3 0; a4(k) 0 a5];
    B = ([b1 0; 0 b2; 0 0] * [kaa*(~kcca)*va; kafd*(~kccfd)*vfd]) + ([0; 0; d1] .* Tl(k));
    out=[out; kaa*(~kcca)*va  kafd*(~kccfd)*vfd];
    X  = A * X + B;
    
    x1(k+1) = X(1);
    x2(k+1) = X(2);
    x3(k+1) = X(3);
    
    y1(k) = kia * x1(k);
    y2(k) = kifd * x2(k);
    y3(k) = kiwr * x3(k);
    
    % Simulacao da falha
    if (k >= kmax/2)
        kaa = falhas(1);
        kafd = falhas(2);
        kcca = falhas(3);
        kccfd = falhas(4);
        kca_ra = falhas(5);
        kca_La = falhas(6);
        kcfd_rfd = falhas(7);
        kcfd_Lfd = falhas(8);
        if ((falhas(9) && falhas(10)) == 0)
            kfv_ra = kfv_ra + (2.5/(kmax/2)); % variacao linear de kfv_ra
            kfv_rfd = kfv_rfd + (2.5/(kmax/2)); % variacao linear de kfv_rfd
        end        
        if (falhas(11) == 0)
            kfl = kfl + 1 + (2.5/(kmax/2)); % variacao linear de kfl
        end        
        kia = falhas(12);
        kifd = falhas(13);
        kiwr = falhas(14);
    end       
        
    k = k + 1;
    
end

t = [0:kmax-1]*h; %tempo
figure;
subplot(3,1,1);
plot(t,y1);
title('Corrente de Armadura');
xlabel('t(s)');
ylabel('A');
subplot(3,1,2);
plot(t,y2);
title('Corrente de Campo');
xlabel('t(s)');
ylabel('A');
subplot(3,1,3);
plot(t,y3);
title('Velocidade');
xlabel('t(s)');
ylabel('rad/s');