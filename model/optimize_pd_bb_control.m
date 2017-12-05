function optimize_pd_bb_control

    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    Nx = Nq + Nv;
    
    % initialize states and parameters
    p = true_parameters;
    p_array = param2array(p);
    
    % initial guess
    v0_idx = 1:Nq;
    x_set_idx = v0_idx(end) + (1:2);
    u_const_idx = x_set_idx(end) + 1;
    
    z0 = ones(u_const_idx,1);
    q0 = [0;0;pi/6+.01;pi/2;0];
    v0 = zeros(Nv,1); v0(2)=-1;
    x0 = impact_map([q0;v0],p_array);
    z0(v0_idx) = x0(v_idx);
    z0(x_set_idx) = q0(3:4);
    z0(u_const_idx) = .5;
    
    % constraints
    A_in = []; b_in = [];
    A_eq = []; b_eq = [];
    lb = -inf*ones(size(z0)); ub = inf*ones(size(z0));
    
    % torque constraint
    lb(u_const_idx) = 0;
    ub(u_const_idx) = 1;
    
    % initial position constraint
    [~,~,~,~,~,~,foot] = get_frames(q0,p);
    q0(1:2) = q0(1:2)-foot(1:2,3);
    
    function [g_in, g_eq] = constraints(z)
        % produce the trajectory
        x_init = [q0; z(v0_idx)];
        x_set = [0;0;z(x_set_idx)];
        u_const = z(u_const_idx);
        control_fcn = @(x,p,mode) pd_bb_control(x,x_set,p,mode,u_const);
        tspan = [0;2];
        [T_stance, X_stance, T_flight, X_flight, x_final] = simulate_hybrid_once(x_init, p_array, tspan, control_fcn);
        
        % periodic constraint
        g_in = [];
        g_eq = [];
        g_eq = [g_eq; x_init-x_final];
    end

    function c = cost(z)
        % produce the trajectory
        x_init = [q0; z(v0_idx)];
        x_set = [0;0;z(x_set_idx)];
        u_const = z(u_const_idx);
        control_fcn = @(x,p,mode) pd_bb_control(x,x_set,p,mode,u_const);
        tspan = [0;2];
        [T_stance, X_stance, T_flight, X_flight, x_final] = simulate_hybrid_once(x_init, p_array, tspan, control_fcn);
        if length(X_flight) == 0
            c= 1e5;
            return
        end
        u_stance = control_fcn(X_stance',p,ContactMode.stance);
        u_flight = control_fcn(X_flight',p,ContactMode.flight);
        distance = abs(x_init(1)-x_final(1));
        c = trapz(T_stance,sum(u_stance.^2,1));
        c = trapz(T_flight,sum(u_flight.^2,1));
        c = c/distance;
    end
    
    z = fmincon(@cost, z0, A_in, b_in, A_eq, b_eq, lb, ub, @constraints);
end