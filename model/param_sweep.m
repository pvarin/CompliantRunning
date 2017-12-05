function param_sweep
    % number of states
    Nq = 5; Nv = 5;
    q_idx = 1:Nq;
    v_idx = Nq+1:Nq+Nv;
    
    % initialize states and parameters
    p = true_parameters;
    alpha = logspace(log10(250/1000),log10(6000/1000),30);
    beta = linspace(0.37,.7,10);
    cost_of_transport = zeros(length(alpha),length(beta));
    speed = zeros(size(cost_of_transport));
    frequency = zeros(size(cost_of_transport));
    
    for k=1:length(beta)
        for i=1:length(alpha)
            i
            p.k = alpha(i)*1000;
            p.k_stop = alpha(i)*3000;
            p_array = param2array(p);

            % warm start if i is not 1
            if i==1
                N_iter = 10;
                % initialization for weak spring
                x0_1 = [0; 0.2697; 0.8364; 1.5655; 0.0060; 0.0732;-1.4081;-0.0097;-0.0221; 1.4124]; % beta = 1
                x0_2 = [0; 0.2904; 0.5831; 1.4932; 0.0115; 2.4401;-0.6124;-7.1701; 9.4228; 0.2374]; % beta = 0
                x0 = beta(k)*x0_1 + (1-beta(k))*x0_2;
                [~,~,~,~,~,~,foot] = get_frames(x0(1:5),p);
                x0(2) = x0(2) - foot(2,3);
                x0 = impact_map(x0,p_array);
            else
                N_iter = 2;
            end
            

            tspan = [0;2];

            % simulate
    %         control_fcn = @(x,p,mode) pd_bb_control(x,x0,p,mode);
            q_set_stance_1 = [0;-.5];
            q_set_stance_2 = [0;-.5];
            q_set_stance = beta(k)*q_set_stance_1 + (1-beta(k))*q_set_stance_2;
            
            q_set_flight_1 = [pi/6+.01;pi/2];
            q_set_flight_2 = [pi/6+.31;pi/2];
            q_set_flight = beta(k)*q_set_flight_1 + (1-beta(k))*q_set_flight_2;
    
            control_fcn = @(x,p,mode) keyframe_control(x,q_set_stance,q_set_flight,p,mode);

            t_last = 0;
            
            for j=1:N_iter
                [T_stance, X_stance, T_flight, X_flight, x_final] = simulate_hybrid_once(x0, p_array, tspan, control_fcn);
                t_last = T_flight(end);
                x0 = x_final;
            end

            u_stance = control_fcn(X_stance',p,ContactMode.stance);
            u_flight = control_fcn(X_flight',p,ContactMode.flight);
            
            % mechanical power
            P_stance = sum(u_stance.*X_stance(:,8:9)');
            P_flight = sum(u_flight.*X_flight(:,8:9)');
            
            % electrical power (resistance)
            I_stance = u_stance/.17;
            I_flight = u_flight/.17;
            P_stance = P_stance + sum(I_stance.^2*2.5);
            P_flight = P_flight + sum(I_flight.^2*2.5);
            
            
            distance = abs(X_stance(1,1)-X_flight(end,1));
            
            cost_of_transport_new(i,k) = trapz(T_stance,P_stance);
            cost_of_transport_new(i,k) = cost_of_transport_new(i,k) + trapz(T_flight,P_flight);
            cost_of_transport_new(i,k) = cost_of_transport_new(i,k)/distance;
            
            cost_of_transport(i,k) = trapz(T_stance,sum(u_stance.^2,1));
            cost_of_transport(i,k) = cost_of_transport(i,k) + trapz(T_flight,sum(u_flight.^2,1));
            cost_of_transport(i,k) = cost_of_transport(i,k)/distance;
            
            speed(i,k) = (X_flight(end,1) - X_stance(1,1))/(T_flight(end) - T_stance(1));
            frequency(i,k) = 1/(T_flight(end) - T_stance(1));
        end
    end
    k = 1000*alpha;
    figure;
    plot(k, cost_of_transport);
    figure;
    plot(k, speed);
    figure;
    plot(k, cost_of_transport_new, 'LineWidth',3); hold on
    [~,I_min] = min(cost_of_transport_new);
    for i=1:length(I_min)
        plot(k(I_min(i)), cost_of_transport_new(I_min(i),i),'k.','MarkerSize',25);
    end
    title('Optimal Running Stiffness Across Strike Angles*')
    xlabel('Spring Stiffness (Nm)')
    ylabel('Cost of Transport')
    set(gca,'FontSize',16)
    
end