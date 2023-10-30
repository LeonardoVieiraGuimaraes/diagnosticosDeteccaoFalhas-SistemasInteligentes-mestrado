function [w,it]=adaline(x,yd,ni)
m=size(x,1);
n=size(x,2);
errot=1;
w=rand(m,1)
it=1;
while errot~=0
    y=w'*x;
    for i=1:n
        if y(i)<1
            y(i)=0;
        else
            y(i)=1;
        end
    end
    er=yd-y;
    %er=er.^2;
     x1=-2:.1:2;
     x2=(-w(1)/w(2))*x1+(1/w(2));
     errot=sum(er)
     w=w+ni*errot*rand(m,1)
     plot(x1,x2)
     hold on
     plot(x(1,:), x(2,:),'ko')
     axis([-2 2 -2 2])
     grid
     pause
     close
     it=it+1;
end
