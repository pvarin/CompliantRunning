function test_controlled_hybrid_simulation
    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    p = true_parameters;
    alpha = .25;
    p.k = alpha*1000;
    p.k_stop = alpha*3000;
    p_array = param2array(p);
    
    x0 = [0; 0.2827; 0.6842; 1.5481; 0.0088; 2.1543;-0.8122;-6.9196; 5.4054; 0.9578];
    [~,~,~,~,~,~,foot] = get_frames(x0(1:5),p);
    x0(2) = x0(2) - foot(2,3);
    x0 = impact_map(x0,p_array);
    
    tspan = [0;2];
    
    % simulate
%     control_fcn = @(x,p,mode) pd_bb_control(x,q0_set,p,mode);
    q_set_stance = [0;-.5];
    q_set_flight = [pi/6+.01;pi/2];
    control_fcn = @(x,p,mode) keyframe_control(x,q_set_stance,q_set_flight,p,mode);
    T = [];
    X = [];
    t_last = 0;
    for i=1:50
        [T_stance, X_stance, T_flight, X_flight, x_final] = simulate_hybrid_once(x0, p_array, tspan, control_fcn);
        T = [T; t_last+T_stance; t_last+T_flight];
        X = [X; X_stance; X_flight];
        t_last = T(end);
        x0 = x_final;
    end
    
    % plot
    idx = 1:6:length(T);
%     animate_trajectory(T(idx),X(idx,q_idx)',p)
    
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