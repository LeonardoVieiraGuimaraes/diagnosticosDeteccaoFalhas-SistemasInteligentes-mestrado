function [out] = estima_media(x,ns)
out = [];
m = 10*rand(1);
for i=1:ns
    mc = 10*rand;
    amc = 1;
    for j=1:length(x)
        amc = amc*exp((x(j)-m)^2-(x(j)-mc)^2)/2;
    end
    amc = min(1,amc);
    if amc>rand
        m = mc;
    end
    out = [out;m];
end
    
