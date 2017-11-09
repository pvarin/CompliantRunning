function [T, Z] = simulate_hybrid(z0, p, tspan)
    % detect initial mode
    mode = ContactMode.flight;
    if C_foot_height(z0,p) <= 0
        mode = ContactMode.stance;
    end
    
    % initialize trajectory
    T = [];
    Z = [];
    
    options = odeset(); % set global options here
    while true
        % define dynamics
        f = @(t,z) [z(6:10); dynamics(z,p,mode)];
        
        % define transition function
        if mode == ContactMode.stance
            g = @(~,z) stance_transition(z,p,mode);
        else
            g = @(~,z) flight_transition(z,p);
        end
        options = odeset(options, 'Events', g);
        
        
        [T_temp,Z_temp] = ode45(f,tspan,z0,options);
        T = [T; T_temp];
        Z = [Z; Z_temp];
        
        % if the simulation is not finished
        if T(end) == tspan(2)
            break
        else
            % update the end of the simulation
            tspan(1) = T(end);
            
            % swap the hybrid mode and state
            if mode == ContactMode.stance
                mode = ContactMode.flight;
                z0 = Z(end,:)';
            else
                mode = ContactMode.stance;
                z0 = impact_map(Z(end,:)',p);
            end     
        end
    end
end

function [y, isterminal, direction] = flight_transition(z,p)
    y = C_foot_height(z,p);
    isterminal = true; % stop simulation
    direction = -1;    % if the value is decreasing
end

function [Fn, isterminal, direction] = stance_transition(z,p,mode)
    [~, Fc] = dynamics(z,p,mode);
    Fn = Fc(2);
    isterminal = true; % stop simulation
    direction = -1;    % if the value is decreasing
end

