function V = potential_energy(q,p)
    [~,~,~,~,~,~,~,body_com, hip_com, upper_femur_com, lower_femur_com, ankle_com, foot_com] = get_frames(q,p);
    % gravitational potential energy
    V = p.body_mass*p.g*body_com(2,3) + p.hip_mass*p.g*hip_com(2,3) + ...
        p.upper_femur_mass*p.g*upper_femur_com(2,3) + p.lower_femur_mass*p.g*lower_femur_com(2,3) + ...
        p.ankle_mass*p.g*ankle_com(2,3) + p.foot_mass*p.g*foot_com(2,3);
    
    % elastic potential energy
    s = 1./(1+exp(-1000*q(5))); % variable stiffness spring
    k = s*p.k + (1-s)*p.k_stop;
    
    V = V + .5*k*q(5)^2;
end