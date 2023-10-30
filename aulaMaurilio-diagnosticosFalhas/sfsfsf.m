clear all;
point_n = 11;

x = linspace(-10, 10, point_n);
y = linspace(-10, 10, point_n);
[xx, yy] = meshgrid(x, y);

tmp1 = sin(xx)./(xx);
index = find(isnan(tmp1)==1);
tmp1(index) = ones(size(index));

tmp2 = sin(yy)./(yy);
index = find(isnan(tmp2)==1);
tmp2(index) = ones(size(index));

zz = tmp1.*tmp2;
trn_data = [xx(:) yy(:) zz(:)];