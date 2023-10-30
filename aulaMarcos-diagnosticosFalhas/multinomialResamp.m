function Ind = multinomialResamp(W, Nsamp)

    Ind=zeros(1,Nsamp);
    CDF = cumsum(W);
    for i=1:Nsamp
        Ind(i) = find(CDF>rand,1);
    end
end