function [X,W] = bootstrapPF(y,x_0,tspan,Nsamp, NT, gama)
    global sigmax ffun;
    d = size(x_0,1); 
    T = size(y,2);
    X = zeros(d,Nsamp,T);
    W = zeros(T, Nsamp);
    Wsum = zeros(T,1);
    
    X(:,:,1) = x_0;
    W(1,:) = loglikehood(y(1), X(:,:,1));
    W(1,:) = W(1,:) - max(W(1,:));
    Wsum(1) = sum(exp(W(1,:)));
    
    for t=2:T
        X(:,:,t) = feval(ffun, X(:,:,t-1), tspan(t-1)) + ...
            repmat(sigmax,1, Nsamp).*randn(d, Nsamp);
        ll = loglikehood(y(t), X(:,:,t));
        W(t,:) = gama*W(t-1,:) + ll;
        W(t,:) = W(t,:) -max(W(t,:));
        Wsum(t) = sum(exp(W(t,:)));
        Neff = 1/(norm(exp(W(t,:)))/Wsum(t))^2;
        
        if Neff < (NT*Nsamp)
            Ind = multinomialResamp(exp(W(t,:))/Wsum(t),Nsamp);
            X(:,:,t) = X(:,Ind,t);
            W(t,:) = zeros(1, Nsamp);
            Wsum(t) = Nsamp;
        end
        
    end
    W = diag(1./Wsum) *exp(W);

end