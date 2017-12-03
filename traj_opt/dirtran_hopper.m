function z=dirtran_hopper
    Nt = 100;
    Nx = 10;
    Nu = 2;
    
    %% Initialize
    % define hybrid mode switching time
    stance_idx = 1:(Nt-50);
    flight_idx = stance_idx(end)+1:Nt;
    
    % stack the optimization variables
    x_idx = 1:Nx*Nt;
    u_idx = x_idx(end)+(1:Nu*Nt);
    h_idx = u_idx(end)+(1:2);
    
    z_0 = 1e-3*rand(1,h_idx(end));
    z_0(h_idx) = 0.01;
    
    p = true_parameters;
    
    %% Cost
    cost = @(z) cost_of_transport(reshape(z(x_idx),Nx,[]), reshape(z(u_idx),Nu,[]), z(h_idx), p, stance_idx, flight_idx);
    
    %% Constraints
    lb = -inf*ones(size(z_0));
    ub = inf*ones(size(z_0));
    A_in = []; b_in = [];
    A_eq = []; b_eq = [];
    
    % torques
    u_min = -1;
    u_max =  1;
    lb(u_idx) = u_min;
    ub(u_idx) = u_max;
    
    % trajectory time
    lb(h_idx) = 1e-4; % make time run forward
    total_time = 2;   % Nt*(h1 + h2) must equal the total time
    a = zeros(1,length(z_0));
    a(1,h_idx) = Nt/2;
    b = total_time;
    A_in = [A_in; a];
    b_in = [b_in; b];
    
    % nonlinear constraints
    nonlcon = @(z) constraints(reshape(z(x_idx),Nx,[]), reshape(z(u_idx),Nu,[]), z(h_idx), p, stance_idx, flight_idx);
    
    %% Optimize the Trajectory
    options = optimoptions('fmincon','MaxFunctionEvaluations',10000000);
    z = fmincon(cost, z_0, A_in, b_in, A_eq, b_eq, lb, ub, nonlcon, options);
    x_traj = reshape(z(x_idx),Nx,[]);
    h1 = z(h_idx(1));
    h2 = z(h_idx(2));
    
    %% Visualize
    % TODO: visualize trajectory
end

function [g_in, g_eq] = constraints(x_traj, u_traj, h, p, stance_idx, flight_idx)
    p_array = param2array(p);

    [body,hip,hip2,knee,knee2,ankle,foot,...
     body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                          = get_frames(x_traj(:,1),p);
                                                      
    g_eq = []; % equality constraint
    g_in = []; % inequality constraint
    
    % foot starts on ground in stance phase
    g_eq = [g_eq; foot(2,3)];
    
    % periodic constraint condition (ignoring x distance)
    x_last = impact_map(x_traj(:,end),p_array);
    g_eq = [g_eq; x_traj(2:end,1) - x_last(2:end)];
    
    % dynamics constraints
    dx_stance = zeros(10,length(stance_idx));
    Fc_stance = zeros(2,length(stance_idx));
    dx_flight = zeros(10,length(flight_idx));
    Fc_flight = zeros(2,length(flight_idx));
    
    for i=stance_idx
        [dx, Fc] = feedforward_dynamics(x_traj(:,i),u_traj(:,i), p_array, ContactMode.stance);
        dx_stance(:,i) = [x_traj(6:end,i); dx];
        Fc_stance(:,i) = Fc;
    end
    for i=flight_idx
        dx = feedforward_dynamics(x_traj(:,i),u_traj(:,i), p_array, ContactMode.flight);
        i_flight = i-i(1)+1;
        dx_flight(:,i_flight) = [x_traj(6:end,i); dx];
    end
    
    dx = [h(1)*dx_stance, h(2)*dx_flight];
    g_eq = [g_eq; reshape(x_traj(:,1:end-1) + dx(:,1:end-1) - x_traj(:,2:end),[],1)];
    
    % liftoff constraint
    g_eq = [g_eq; Fc_stance(2,1)];
end