function test_no_gravity_dynamics
    % number of states controls and external forces
    Nq = 5; Nv = 5;
    Nu = 2; Nf = 2;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    q0 = .2*(rand(Nq,1)-.5);
    v0 = .2*(rand(Nv,1)-.5);
    x0 = [q0;v0];
    p = example_parameters;
    p.g = 0;
    p.k = 0;
    p_array = param2array(p);
    tspan = [0;5];
    
    % define model dynamics
    f = @(t,x) [x(v_idx); dynamics(x(q_idx),x(v_idx),zeros(Nu,1),zeros(Nf,1),p_array)];
    
    % simulate
    [T, X] = ode45(f,tspan,x0);
    
    % plot
    animate_trajectory(X(:,q_idx)',p)
    
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