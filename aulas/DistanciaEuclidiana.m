function D = DistanciaEuclidiana(X,Cc)
X
Cc
 for j = 1:1:length(Cc(1,:))
        D(1,j) =  sqrt((X(1,1) - Cc(1,j)).^2 + (X(1,2) - Cc(2,j)).^2);
       
 end
    
end
