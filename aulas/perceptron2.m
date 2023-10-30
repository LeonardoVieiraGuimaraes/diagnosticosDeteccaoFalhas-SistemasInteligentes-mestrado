clear all;

x = [0 0
    0 1
    1 0 
    1 1];
x = x';

yd = [1 0 0 1];
plot(x(1,:), x(2,:),'ko')


[m,n] = size(x);

errot=1;
w=rand(m,1)
it=0;
ni = 0.01; 
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

errot=sum(er);
it = it + 1;
wr(:,it) = w;
w=w+ni*errot*rand(m,1);


if it == 100
    break;
    
end

end
wr = wr';
x1=-2:.1:2;
x2=(-w(1)/w(2))*x1+(1/w(2));
plot(x1,x2)
hold on
plot(x(1,:), x(2,:),'ko')
axis([-2 2 -2 2])