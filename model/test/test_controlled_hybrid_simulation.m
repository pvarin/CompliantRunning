function test_controlled_hybrid_simulation
    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    p = true_parameters;
    p_array = param2array(p);
    
    q0 = [0;0;pi/6+.01;pi/2;0];
    [~,~,~,~,~,~,foot] = get_frames(q0,p);
    q0(1:2) = q0(1:2)-foot(1:2,3);
    v0 = zeros(Nv,1);
    v0(2) = -1;
    x0 = [q0;v0];
    x0 = impact_map(x0,p_array);
    
    tspan = [0;2];
    
    % simulate
    control_fcn = @(x,p,mode) pd_bb_control(x,x0,p,mode);
    T = [];
    X = [];
    t_last = 0;
    for i=1:10
        [T_stance, X_stance, T_flight, X_flight, x_final] = simulate_hybrid_once(x0, p_array, tspan, control_fcn);
        T = [T; t_last+T_stance; t_last+T_flight];
        X = [X; X_stance; X_flight];
        t_last = T(end);
        x0 = x_final;
    end
    
    % plot
    idx = 1:6:length(T);
    animate_trajectory(T(idx),X(idx,q_idx)',p)
    
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

function u = pd_bb_control(x,x_set,p,mode)
    if mode == ContactMode.flight
        u = 2*(-x(3:4)+x_set(3:4))-.1*x(8:9);
    else
        u = zeros(2,1);
        u(1) = 2*(-x(3)+x_set(3))-.1*x(8);
        u(2) = -.5;
    end
end