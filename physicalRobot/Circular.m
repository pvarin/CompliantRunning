function q = Circular
    % create a trajectory that extends the leg then bends the knee
    N = 200;
    q = zeros(5,N);
    q(3,1:N) = linspace(-pi/4,pi/4,N);
    q(4,1:N) = linspace(0,pi/3,N);
end