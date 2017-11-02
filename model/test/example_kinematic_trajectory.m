function q = example_kinematic_trajectory
    % create a trajectory that extends the leg then bends the knee
    q = zeros(4,200);
    q(3,1:100) = linspace(-pi/4,pi/4);
    q(3,101:end) = pi/4;
    q(4,101:end) = linspace(0,pi/2);
end