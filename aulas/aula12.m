x = rand(3)
y = [1 2 3]
M = y*x
%M*x(1,:)'
[q,r]=qr(x)
M = y*q
M*(x(1,:)*pinv(r))'
M*(x(2,:)*pinv(r))'
M*(x(3,:)*pinv(r))'

