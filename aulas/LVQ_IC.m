function [w] = LVQ_IC(x, k)
    [l,c] = size(x)
    w = rand(l,k)*10
    n = 0.8;
    plot(x(1,:),x(2,:),'ko')
    hold on
    plot(w(1,:),w(2,:),'bx')
    
    for i = 1:10
        
        for j=1:c
            xx = x(:,j);
            d = [];
            for m = 1:k
                d(m) = norm(xx - w(:,m));
            end
            [d mi] = min(d)
            %mi = find(d==min(d));
            w(:,mi) = w(:,mi)+n*(xx-w(:,mi));
        
        end
        n = n - n/10;
        plot(x(1,:),x(2,:),'ko')
        hold on
        plot(w(1,:),w(2,:),'bx')
        pause();
    end
end
