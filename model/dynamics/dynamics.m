function qdd = dynamics(z,p,mode)

    u = control_law(z,p,mode);

    if mode == ContactMode.flight
        Fc = [0;0];
        qdd = A(z, p)\b(z, u, Fc, p);        
    elseif mode == ContactMode.stance
        x = A_c(z, p)\b_c(z, u, p);
        qdd = x(1:5);
%         Fc = x(5:end);
    end
    
end