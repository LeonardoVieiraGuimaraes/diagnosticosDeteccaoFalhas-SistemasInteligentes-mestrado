function [w] = Mapa_Kohonen(x, k)
   
    [l,c] = size(x);
   
    w1 = rand(1,k) + 60;
    w2 = rand(1,k) + 1.5;
    
    w = [w1;w2];
    
    %[lw,cw] = size(w);
    n = 0.8;
    ro = 1;
    d2=[];
    %plot(x(1,:),x(2,:),'ko')
    %hold on
    %plot(w(1,:),w(2,:),'bx')
   
 
    for i = 1:1000
        
        for j=1:c
            xx = x(:,j);
            d = [];
            for m = 1:k
                d(m) = norm(xx - w(:,m));
            end
            [d mi] = min(d);
            %mi = find(d==min(d));
            for p=1:length(w(1,:))  
                o = exp(-((norm((w(:,mi) - w(:,p))))^2)/(2*ro));
                w(:,p) = w(:,p)+n*o*(xx-w(:,p));
            end
                %for p=1:length(w(1,:))
                 %   d2(p) = norm(w(:,mi) - w(:,p));
                  %  if d2(p)<=1
                   %      w(:,p) = w(:,p)+n*o*(xx-w(:,p));
                    %end
                %end
            %for (i = 1 : lw)
             %   for (j = 1 : cw)
              %      w(i,j) = (w(i,j) - min(w(i,:))) / (max(w(i,:)) - min(w(i,:)))
               % end
            %end
            
        end
        n = n - n/10;
        %plot(x(1,:),x(2,:),'ko')
        %hold on
        %plot(w(1,:),w(2,:),'bx')
        %pause(1');
    end

end