clear all;

x = [ -0.3665 0.0620 5.9891
    -0.7842 1.1267 5.5912
    0.3012 0.5611 5.8234
    0.7757 1.0648 8.0677
    0.1570 0.8028 6.3040
    -0.7014 1.0316 3.6005
    0.3748 0.1536 6.1537
    -0.6920 0.9404 4.4058
    -1.3970 0.7141 4.9263
    -1.8842 -0.2805 1.2548]

x = x';


[m n] = size(x);
w = [-0,024617394 0,486490591 0,121711852]
w = w';

 y=w'*x;
for i=1:n
    if y(i)<1
        y(i)=0;
    else
        y(i)=1;
    end
end
 
y = y';