function X = eq_dynB(x0,~)

    X(1,:)=exp(x0(2,:)).*x0(1,:);
    X(2,:) = x0(2,:);
end