function u = keyframe_control(x,q_stance_set,q_flight_set,p,mode)
    if mode == ContactMode.flight
        u = 2*bsxfun(@plus,-x(3:4,:),q_flight_set)-.1*x(8:9,:);
    else
        u = 2*bsxfun(@plus,-x(3:4,:),q_stance_set)-.1*x(8:9,:);
    end
end