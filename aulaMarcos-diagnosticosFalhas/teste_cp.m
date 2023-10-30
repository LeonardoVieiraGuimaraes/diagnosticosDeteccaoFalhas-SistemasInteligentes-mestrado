x1=2+rand(85,1);
x2=8+rand(50,1);
x=[x1;x2];
subplot(2,1,1)
plot(x)
pause
[out]=change_point(x,10000);