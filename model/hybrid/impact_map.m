function z_stance = impact_map(z_flight,p)
    x = A_c(z_flight,p)\[A(z_flight,p)*z_flight(6:end);zeros(2,1)];
    z_stance = z_flight;
    z_stance(6:end) = x(1:5);
%     F_c = x(length(z_flight)+1:end); % the impulse
end