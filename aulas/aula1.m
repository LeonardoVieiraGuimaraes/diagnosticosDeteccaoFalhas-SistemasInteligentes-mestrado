%clear all
%x = rand(3)
x(1,:)*x(1,:)'
x(1,:)*x(2,:)'
[q,r] = qr(x)
q(1,:)*q(1,:)'
q(1,:)*q(2,:)'
q(1,:)*q(3,:)'
x*pinv(r)
x(1,:)*pinv(r)
