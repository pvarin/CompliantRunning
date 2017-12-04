function x = patrick_filter(x,tau)
    for i=2:length(x)
        x(i) = x(i-1)*(1-tau) + tau*x(i);
    end
end% .2 works for tau