function  [Cc R C ] = CriaGrupo(j, X)
Cc(1,j) = X(1,1);
Cc(2,j) = X(1,2);
C(1,j) = X(1,2); 
C(2,j) = X(1,2);
R(1,j) = 0; 
end