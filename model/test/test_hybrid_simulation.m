function test_hybrid_simulation
    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    q0 = zeros(Nq,1);
    q0(3) = pi/8;
    q0(2) = 2.5;
    v0 = zeros(Nv,1);
    x0 = [q0;v0];
    p = example_parameters;
    p_array = param2array(p);
    tspan = [0;2];
    
    % simulate
    [T, X] = simulate_hybrid(x0, p_array, tspan);
    
    % plot
    animate_trajectory(T,X(:,q_idx)',p)
    
    figure(2); clf;
    plot(T,X(:,q_idx));
    title('Position');
    xlabel('time (s)');
    legend('x','y','\theta_1','\theta_2','l');
    
    figure(3); clf;
    plot(T, energy(X',p_array));
    title('Energy');
    xlabel('time (s)');
    ylabel('Energy (J)');
    
end