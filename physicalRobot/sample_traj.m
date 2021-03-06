function q = sample_traj
    % create a trajectory that extends the leg then bends the knee
    N = 50;
    q = zeros(5,2*N);
    q(2,:) = 0;
    q(3,1:N) = linspace(-pi/4,pi/4,N);
    q(3,N+1:end) = pi/4;
    q(4,N+1:end) = linspace(0,pi/3,N);
end