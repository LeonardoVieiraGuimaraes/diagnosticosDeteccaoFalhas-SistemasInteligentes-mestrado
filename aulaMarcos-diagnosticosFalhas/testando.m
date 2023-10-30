ra = 4.6e-3;
rfd = 12.1875;
la = 2.38e-4;
lfd = 8.750;
lafd = 0.23;
jm = 2580;
va = 750;
vfd = 750 
ia = 17098
bm = 127;
c0 = 0;
c1 = 5041.7;
c2 = 0;
h = 0.002;
x1(1)=0;
x2(1)=0;
x3(1)=0;

h1 = 1;
h2 = 0;
h3 = 0;



kaa = 1;
kafd = 1;
kcca = 0;
kccfd = 0;
kfia = 0;
kfifd = 0; 
kfwr = 0;

la1 = .9;
la2 = .9; 
la3 = .9;

a1 = exp(-(ra/la)*h);
a3 = exp(-(rfd/lfd)*h);
a5 = exp(-(bm/jm)*h);

b1 = (1-a1)/ra;
d1 = -(1-a5)/bm;
b2 = ((1-a3)/rfd);

i = 2;
for k = 1:h:10
    
    if k == 6
        kaa = 0;
        kafd = 1;
        kcca = 0;
        kccfd = 0;
    end
    
     if k==6
        kraca = 1;
        krafv = 1;
        klaca = 1; 
        krfdcdf = 1;
        krfdfv = 1;
        klfdcfd = 1;
        kfl = 1;
        ra = kraca*krafv*ra;
        la = klaca*la;
        rfd = krfdcdf*krfdfv*rfd;
        lfd = klfdcfd*lfd;
        bm = kfl*bm;
     end
    
     if k == 6 
        kfia = 0;
        kfifd = 0; 
        kfwr = 0; 
     end
     
   
    a2 = (1/(rfd*la - ra*lfd))*(lafd*lfd*(a3-a1)*x3(i-1) + (ra*lfd*a1-rfd*la*a3));
    a4 = lafd*((1-a5)/bm)*x2(i-1);
    
    
    A = [kaa*a1 kaa*a2 0; 0 kafd*a3 0; a4 0 a5];
    B = [b1 0; 0 b2; 0 0];
    U = [kaa*~kcca*va; kafd*~kccfd*vfd];
    D = [0; 0; d1];
    
    Ik = [kfia 0 0; 0 kfifd 0; 0 0 kfwr];
    
    
   
    
    
    
    
    
        
    
    
       
    i= i+1;
end



t=1:h:10.002;
figure(1);

subplot(3,1,1);
plot(t,y1);
title('Corrente de Armadura');
ylabel('x1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,y2);
title('Corrente de Campo');
ylabel('x2');
xlabel('t(s)');

subplot(3,1,3);
plot(t,y3);
title('Velocidade');
ylabel('x3');
xlabel('t(s)');

figure(2);

subplot(3,1,1);
plot(t,e1);
title('Corrente de Armadura');
ylabel('e1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,e2);
title('Corrente de Campo');
ylabel('e2');
xlabel('t(s)');

subplot(3,1,3);
plot(t,e3);
title('Velocidade');
ylabel('e3');
xlabel('t(s)');

figure(3);

subplot(3,1,1);
plot(t,e1r);
title('Corrente de Armadura');
ylabel('e1');
xlabel('t(s)');

subplot(3,1,2);
plot(t,e2r);
title('Corrente de Campo');
ylabel('e2');
xlabel('t(s)');

subplot(3,1,3);
plot(t,e3r);
title('Velocidade');
ylabel('e3');
xlabel('t(s)');

clear;

