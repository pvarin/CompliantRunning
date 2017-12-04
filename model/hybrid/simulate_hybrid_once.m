function [T_stance, Z_stance, T_flight, Z_flight, z_final] = simulate_hybrid_once(z0, p, tspan, control_fcn)
    
    % initialize
    options = odeset();
    
    % stance simulation
    mode = ContactMode.stance;
    f = @(t,z) [z(6:10); controlled_dynamics(z,p,mode,control_fcn)];
    g = @(~,z) stance_transition(z,p);
    options = odeset(options, 'Events', g);
    [T_stance,Z_stance] = ode45(f,tspan,z0,options);
    
    % check if we went anywhere
    if (abs(T_stance(end) - tspan(2))<.01)
        T_flight = [];
        Z_flight = [];
        z_final = Z_stance(end,:)';
        return
    end
    
    % flight simulation
    mode = ContactMode.flight;
    f = @(t,z) [z(6:10); controlled_dynamics(z,p,mode,control_fcn)];
    g = @(~,z) flight_transition(z,p);
    options = odeset(options, 'Events', g);
    [T_flight,Z_flight] = ode45(f,tspan,Z_stance(end,:)',options);
    T_flight = T_flight + T_stance(end);
    
    % impact map
    z_final = impact_map(Z_flight(end,:)',p);
    
end

function [y, isterminal, direction] = flight_transition(z,p)
    y = C_foot_height(z,p);
    isterminal = true; % stop simulation
    direction = -1;    % if the value is decreasing
end

function [Fn, isterminal, direction] = stance_transition(z,p)
    [~, Fc] = dynamics(z,p,ContactMode.stance);
    Fn = Fc(2);
    isterminal = true; % stop simulation
    direction = -1;    % if the value is decreasing
end
