function [w] = Mapa_Kohonen(x, k)
   
    [l,c] = size(x);
   
    w1 = rand(1,k) + 60;
    w2 = rand(1,k) + 1.5;
    w = [w1;w2];
    n = 0.8;
    ro = 0.4;
    d2=[];
    
   
 
    for i = 1:1000
        
        for j=1:c
            xx = x(:,j);
            d = [];
            for m = 1:k
                d(m) = norm(xx - w(:,m));
            end
            [d mi] = min(d);
           
           
                for p=1:length(w(1,:))
                    d2(p) = norm(w(:,mi) - w(:,p));
                    if d2(p)<=1
                         w(:,p) = w(:,p)+n*ro*(xx-w(:,p));
                    end
                end
           
        end
        n = n - n/10;
       
    end

end