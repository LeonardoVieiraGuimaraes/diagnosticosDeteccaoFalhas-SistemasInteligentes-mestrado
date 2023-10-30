function [y,x] = simulateExpA(tspan,x0)
    global ffun gfun sigmax;
    x(1) = x0;
    for t=tspan(2:end)
        x(t) = feval(ffun, x(t-1), t-1) + sigmax*randn;

    end

    y = feval(gfun,x); 
end