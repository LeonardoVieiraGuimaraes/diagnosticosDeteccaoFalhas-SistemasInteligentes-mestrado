close all; 
clear all;

X = 0:10/1000:10;
Y = 0:0.30/1000:0.30;

mfx1 = gaussmf(X, [2 0]);%poor
mfx2 = gaussmf(X, [2 5]);%good
mfx3 = gaussmf(X,  [2 10]);%excellent

mfx4 = trapmf(X,  [-0.36 -0.04 0.04 0.36])%rancid 
mfx5 = trapmf(X,   [0.64 0.96 1.04 1.36])%dellicius


mfy1 = trimf(Y, [-0.12 0 0.12]);%cheap
mfy2 = trimf(Y, [0.03 0.15 0.27]);%avenge
mfy3 = trimf(Y, [0.18 0.3 0.42]);%generous
rm = max(mfx1,mfx4);
r1 = min(rm,mfy1);
r2 = min(mfx2,mfy2);
r3 = min(max(mfx3,mfx5),mfy3);

r4 = max(r1,r2);
agregar2 = max(r3,r4);


%ub = trimf(X, [pi/4 pi/2 3*pi/4]);
%uc = trimf(X, [pi/2 3*pi/4 pi]);
%ud = trimf(X, [3*pi/4 pi 5*pi/4]);
%ue = trimf(X, [pi 5*pi/4 3*pi/2]);
%uf = trimf(X, [5*pi/4 3*pi/2 7*pi/4]);
%ug = trimf(X, [3*pi/2 7*pi/4 2*pi]);

for k = 1:length(Y)
    Z(1,k) = defuzz(Y(1,k),agregar2(1,k),'centroid');
end

figure(2)
plot(X,Z);

