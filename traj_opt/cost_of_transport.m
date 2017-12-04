function c = cost_of_transport(x,u,h,p,stance_idx, flight_idx)
    distance = x(1,end) - x(1,1);
    energy = sum(sum(u(:,stance_idx).^2))*h(1) + sum(sum(u(:,flight_idx).^2))*h(2);
    m = p.body_mass + p.hip_mass + p.upper_femur_mass + ...
        p.lower_femur_mass + p.ankle_mass + p.foot_mass;
    c = energy/(distance*m*p.g);
end