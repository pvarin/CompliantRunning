function u = keyframe_control_saturate(x,q_stance_set,q_flight_set,p,mode)
    if mode == ContactMode.flight
        u = 2*bsxfun(@plus,-x(3:4,:),q_flight_set)-.1*x(8:9,:);
    else
        u = 2*bsxfun(@plus,-x(3:4,:),q_stance_set)-.1*x(8:9,:);
    end
    u_min = -2*0.296*ones(size(u));
    u_max = 2*0.296*ones(size(u));
    
    u = min(u,u_max);
    u = max(u,u_min);
end