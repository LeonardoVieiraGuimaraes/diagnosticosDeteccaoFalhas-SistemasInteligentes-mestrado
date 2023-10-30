function l = loglikehood(y, X)
    global sigmav gfun;
    yk = feval(gfun, X);
    vhat = y - yk;
    l = (-(vhat).^2/2/sigmav^2);

end