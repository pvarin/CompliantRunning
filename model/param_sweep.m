function param_sweep
    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    p = true_parameters;
    alpha = logspace(-.8,.6,20);
    cost_of_transport = zeros(size(alpha));
    for i=1:length(alpha)
        p.k = alpha(i)*1000;
        p.k_stop = alpha(i)*3000;
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
        t_last = 0;
        for j=1:5
            [T_stance, X_stance, T_flight, X_flight, x_final] = simulate_hybrid_once(x0, p_array, tspan, control_fcn);
            t_last = T_flight(end);
            x0 = x_final;
        end
        
        u_stance = control_fcn(X_stance',p,ContactMode.stance);
        u_flight = control_fcn(X_flight',p,ContactMode.flight);
        distance = abs(X_stance(1,1)-X_flight(end,1));
        cost_of_transport(i) = trapz(T_stance,sum(u_stance.^2,1));
        cost_of_transport(i) = cost_of_transport(i) + trapz(T_flight,sum(u_flight.^2,1));
        cost_of_transport(i) = cost_of_transport(i)/distance;
    end
    
    loglog(1000*alpha, cost_of_transport);
    
end