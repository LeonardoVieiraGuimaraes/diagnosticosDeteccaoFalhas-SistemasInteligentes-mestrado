clear all;
dados = load('dados1.txt');
x = dados(:,1:3)';
yd = dados(:,4)';

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
errot=sum(er)
it = it + 1
wr(:,it) = w;
w=w+ni*errot*rand(m,1);


if it == 100
    break;
    
end

end
wr = wr';