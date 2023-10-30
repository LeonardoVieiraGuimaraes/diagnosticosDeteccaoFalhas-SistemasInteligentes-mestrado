function x = eq_dynA(x0, tspan)
    x(1,:) = x0(1,:)./2 + (25.*x0(1,:))./(1+x0(1,:).^2)+8*cos(1.2*tspan);
end