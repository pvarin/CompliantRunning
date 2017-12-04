function [qdd, Fc] = controlled_dynamics(z,p,mode,control_fcn)
% computes dynamics with a custom control law that takes in the state,
% parameters, and hybrid mode

    % compute control
    u = control_fcn(z,p,mode);
    
    % choose dynamics based on mode
    if mode == ContactMode.flight
        Fc = [0;0];
        qdd = A(z, p)\b(z, u, Fc, p);        
        Fc = zeros(2,1);
    elseif mode == ContactMode.stance
        x = A_c(z, p)\b_c(z, u, p);
        qdd = x(1:5);
        Fc = x(6:end);
    end   
end