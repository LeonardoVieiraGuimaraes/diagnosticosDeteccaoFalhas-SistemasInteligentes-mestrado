function [out]=change_point(x,nsim)
out=[];
n=length(x);
m1=10*rand;
m2=10*rand;
m=round(n*rand);
for iter=1:nsim
    m1c=10*rand;
    m2c=10*rand;
    mc=round(n*rand);
    %estimando m1
    m1ac=1;
    for i=1:m
        m1ac=m1ac*exp(-(x(i)-m1c)^2/2)/exp(-(x(i)-m1)^2/2);
    end
    m1ac=min(1,m1ac);
    if m1ac>rand
        m1=m1c;
    end
    %estimando m2
    m2ac=1;
    for i=(m+1):n
        m2ac=m2ac*exp(-(x(i)-m2c)^2/2)/exp(-(x(i)-m2)^2/2);
    end
    m2ac=min(1,m1ac);
    if m2ac>rand
        m2=m2c;
    end
    %estimando m
    nmac=1;
    for i=1:mc
        nmac=nmac*exp(-(x(i)-m1)^2/2);
    end
    for i=(mc+1):n
        nmac=nmac*exp(-(x(i)-m2)^2/2);
    end
    dmac=1;
    for i=1:m
        dmac=dmac*exp(-(x(i)-m1)^2/2);
    end
    for i=(m+1):n
        dmac=dmac*exp(-(x(i)-m2)^2/2);
    end
    mac=min(1,(nmac/dmac));
    if mac>rand
        m=mc;
    end
    out=[out;m1 m2 m];
end
subplot(2,1,2)
hist(out(1000:nsim,3),n)
    