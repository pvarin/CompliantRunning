function [qdd, Fc] = dynamics(z,p,mode)

    % compute control
    u = control_law(z,p,mode);
    
    % choose dynamics based on mode
    if mode == ContactMode.flight
        Fc = [0;0];
        qdd = A(z, p)\b(z, u, Fc, p);        
        Fc = zeros(2,1);
    elseif mode == ContactMode.stance
        x = A_c(z, p)\b_c(z, u, p);
        qdd = x(1:5);
        Fc = x(5:end);
    end   
end