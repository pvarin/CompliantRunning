function test_contact_dynamics
    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    q0 = zeros(Nq,1);
    q0(1) = -.5; q0(2) = -1;
    q0(3) = pi;
    v0 = zeros(Nv,1);
    x0 = [q0;v0];
    p = example_parameters;
    p_array = param2array(p);
    tspan = [0;5];
    
    % define model dynamics
    f = @(t,x) [x(v_idx); dynamics(x,p_array,ContactMode.stance)];
    
    % simulate
    [T, X] = ode45(f,tspan,x0);
    
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