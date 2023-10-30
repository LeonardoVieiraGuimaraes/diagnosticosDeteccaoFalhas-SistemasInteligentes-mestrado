 clear all;
x = load('Iris2.txt');
idcperm = randperm(size(x,1));
x = x(idcperm,:);
y = x(:,5)';
x = x(:,1:4)';




%x1 = rand(2,10);
%x2 = rand(2,10) + 8;
%x = [x1 x2]
%[w mm] = Mapa_Kohonen(x,16,y);
%plot(x(1,:),x(2,:),'ko')
%hold on
%plot(w(1,:),w(2,:),'bx')

    xt = x(:,1:110);
    xo = x(:,111:150);
    yt = y(:,1:110);
    
    yo = y(:,111:150); 
    yob = zeros(4,40);
    for q = 1:40
        yob(yo(1,q),q) = 1;  
    end
        
    
    


    [l,c] = size(xt);
    w = rand(4,16)*6;
    n = 0.8;
    o = 0.4;
    d2=[];
    %plot(x(1,:),x(2,:),'ko')
    %hold on
    %plot(w(1,:),w(2,:),'bx')
    
    for i = 1:10
        
        for j=1:c
            xx = xt(:,j);
            d = [];
            for m = 1:16
                d(m) = norm(xx - w(:,m));
            end
            [d mi] = min(d);
            %mi = find(d==min(d));
            %o = exp(-((norm((W(:,in) - W(:,j))))^2)/(2*ro));
            w(:,mi) = w(:,mi)+n*(xx-w(:,mi));
            
                for p=1:length(w(1,:))
                    d2(p) = norm(w(:,mi) - w(:,p));
                    if d2(p)<1
                         w(:,p) = w(:,p)+n*o*(xx-w(:,p));
                    end
                end
        end
        n = n - n/10;
        %plot(x(1,:),x(2,:),'ko')
        %hold on
        %plot(w(1,:),w(2,:),'bx')
        %pause();
    end
