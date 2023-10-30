function y = eq_obsB(x)
    y = (x(1,:).^(4)).^(1/5);
     for j = 1:1:length(Ccx)
        D(1,j) =  sqrt((x(i,1) - Ccx(1,j)).^2 + (y(i,1) - Ccy(1,j)).^2);
       
    end
end