%Variaves 
ran = 4.6e-3;
rfdn = 12.1875;
lan = 2.38e-4;
lfdn = 8.750;
lafd = 0.23;
jm = 2580;
va = 750;
vfd = 750; 
ia = 17098;
bm = 127;
c0 = 0;
c1 = 5041.7;
c2 = 0;
h = 0.002;

%Valores iniciais





h1 = 0;
h2 = 1;
h3 = 1;
H = [h1; h2; h3]

kaa = 1;
kaf = 1;
kcca = 0;
kccfd = 0;
kfia = 0;
kfifd = 0; 
kfwr = 0;
kraca = 1;
krafv = 1;
klaca = 1; 
krfdcfd = 1;
krfdfv = 1;
klfdcfd = 1;
kfl = 1;

la1 = .5;
la2 = .5; 
la3 = .5;




X = [0;0;0];
XO = [0;0;0];
XOR = [0;0;0];
XF = [0;0;0];
Y = [0;0;0];
YF = [0;0;0];
EO  = [0;0;0];
EOR  = [0;0;0];




k = 2;
for i = 0:h:10
    
    x1(k-1) = X(1,1);
    x2(k-1) = X(2,1);
    x3(k-1) = X(3,1);
    y1(k-1) = Y(1,1);
    y2(k-1) = Y(2,1);
    y3(k-1) = Y(3,1);
%Sistema sem falhas
    tl = c0 + c1*x3(k-1) + c2*(x3(k-1))^2;
    a1 = exp(-(ran/lan)*h);
    a3 = exp(-(rfdn/lfdn)*h);
    a5 = exp(-(bm/jm)*h);
    a4 = lafd*((1-a5)/bm)*x2(k-1);
    b1 = (1-a1)/ran;
    a2 = (1/(rfdn*lan - ran*lfdn))*(lafd*lfdn*(a3-a1)*x3(k-1)+(ran*lfdn*a1-rfdn*lan*a3));
    b2 = (1-a3)/rfdn;
    d1 = -(1-a5)/bm;
   
   
    A = [a1 a2 0; 0 a3 0; a4 0 a5];
    B = [b1 0; 0 b2; 0 0];
    U = [va; vfd];
    D = [0; 0; d1];
    T = [tl];
    C = eye(3);
    
    
    
    X = A*X + B*U + D*T;
    
    Y = C*X;  

    
   

%falha no tempo 6    
    xf1(k-1) = XF(1,1);
    xf2(k-1) = XF(2,1);
    xf3(k-1) = XF(3,1);
    
    yf1(k-1) = YF(1,1);
    yf2(k-1) = YF(2,1);
    yf3(k-1) = YF(3,1);
    
    if i > 6
        kaa = 0;
        kaf = 1;
        kcca = 0;
        kccfd = 0;
        kfia = 0;
        kfifd = 0; 
        kfwr = 0;
        kraca = 1;
        krafv = 1;
        klaca = 1; 
        krfdcfd = 1;
        krfdfv = 1;
        klfdcfd = 1;
        kfl = 1;
        
    end
    
    ranf = kraca*krafv*ran;
    lanf = klaca*lan;
    rfdnf = krfdcfd*krfdfv*rfdn;
    lfdnf = klfdcfd*lfdn;
    bmf = kfl*bm;
    
    tfl = c0 + c1*xf3(k-1) + c2*(xf3(k-1))^2;
    af1 = exp(-(ranf/lanf)*h);
    af3 = exp(-(rfdnf/lfdnf)*h);
    af5 = exp(-(bmf/jm)*h);
    af4 = lafd*((1-af5)/bmf)*xf2(k-1);
    bf1 = (1-af1)/ranf;
    af2 = (1/(rfdnf*lanf - ranf*lfdnf))*(lafd*lfdnf*(af3-af1)*xf3(k-1)+(ranf*lfdnf*af1-rfdnf*lanf*af3));
    bf2 = (1-af3)/rfdnf;
    df1 = -(1-af5)/bmf;
   
   
    AF = [kaa*af1 kaa*af2 0; 0 kaf*af3 0;af4 0 af5];
    BF = [bf1 0; 0 bf2; 0 0];
    UF = [kaa*~kcca*va; kaf*~kccfd*vfd];
    DF = [0; 0; df1];
    TF = [tfl];
    CF = [~kfia 0 0;0 ~kfifd 0;0 0 ~kfwr]; 
   
    
    XF = AF*XF + BF*UF + DF*TF;  
    
    
    
    
    xo1(k-1) = XO(1,1);
    xo2(k-1) = XO(2,1);
    xo3(k-1) = XO(3,1);
    
    eo1(k-1) = EO(1,1);
    eo2(k-1) = EO(2,1);
    eo3(k-1) = EO(3,1);
    
    L = [a1-la1 a2 0;0 a3-la2 0;a4 0 a5-la3];
    
    
    
    XO = (A-L*C)*XO + B*U + L*YF;
     
   
    
    
    EO = XF - XO;
    xor1(k-1) = XOR(1,1);
    xor2(k-1) = XOR(2,1);
    xor3(k-1) = XOR(3,1); 
    
    eor1(k-1) = EOR(1,1);
    eor2(k-1) = EOR(2,1); 
    eor3(k-1) = EOR(3,1);
    
    
    
    if h1 == 1 & h2 == 0 & h3==0
        P = [1 1];    
    end
    
    if h1 == 0 & h2 == 1 & h3==0
        P = [2 2];    
    end
    
    if h1 == 0 & h2 == 0 & h3==1
        P = [3 3];    
    end
    
    if h1 == 1 & h2 == 1 & h3==0
        P = [1 2];    
    end
    
    if h1 == 1 & h2 == 0 & h3==1
        P = [1 3];    
    end
    
    if h1 == 0 & h2 == 1 & h3==1
        P = [2 3];    
    end
    
    
    LR = [la1 0 0;0 la2-af3 0; 0 0 la3-af5]; 
    R2 = H*pinv(C(P,:)*H);
    R1 = C - R2*C(P,:);
    RF = R1*A + LR*C;  
    XOR = RF*XOR + R1*B*U + R2*XF(P,:) - LR*YF;
      
     
    
    YF = CF*XF;
     
    EOR = XF - XOR;
   
    
    
    
    
    k= k+1;
end



t=0:h:10;

figure(1);

subplot(3,1,1);
plot(t,x1);
title('Corrente de Armadura');
ylabel('x1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,x2);
title('Corrente de Campo');
ylabel('x2');
xlabel('t(s)');

subplot(3,1,3);
plot(t,x3);
title('Velocidade');
ylabel('x3');
xlabel('t(s)');

figure(2);

subplot(3,1,1);
plot(t,xf1);
title('Corrente de Armadura');
ylabel('xf1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,xf2);
title('Corrente de Campo');
ylabel('xf2');
xlabel('t(s)');

subplot(3,1,3);
plot(t,xf3);
title('Velocidade');
ylabel('xf3');
xlabel('t(s)');

figure(3);
subplot(3,1,1);
plot(t,eo1);
title('Corrente de Armadura');
ylabel('eo1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,eo2);
title('Corrente de Campo');
ylabel('eo2');
xlabel('t(s)');


subplot(3,1,3);
plot(t,eo3);
%axis([0 10 -1 1])
title('Velocidade');
ylabel('eo3');
xlabel('t(s)');

figure(4);

subplot(3,1,1);
plot(t,eor1);
axis([0 10 -.5 .5])
title('Corrente de Armadura');
ylabel('eor1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,eor2);
%axis([0 10 -.5 .5])
title('Corrente de Campo');
ylabel('eor2');
xlabel('t(s)');

subplot(3,1,3);
plot(t,eor3);
%axis([0 10 -.5 .5])
title('Velocidade');
ylabel('eor3');
xlabel('t(s)');



