function update_plot(q, p, handles)
    
    % compute the kinematics
    [body,hip,hip2,knee,knee2,ankle,foot,...
          body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                          = get_frames(q,p);
    % extract the plot handles                                
    h_femur_upper = handles{1};
    h_femur_lower = handles{2};
    h_hip = handles{3};
    h_leg = handles{4};
    h_foot = handles{5};

    % plot the upper femur linkage
    x_femur_upper = [hip(1:2,3), knee(1:2,3)];
    h_femur_upper.XData = x_femur_upper(1,:);
    h_femur_upper.YData = x_femur_upper(2,:);
    
    % plot the lower femur linkage
    x_femur_lower = [hip2(1:2,3), knee2(1:2,3)];
    h_femur_lower.XData = x_femur_lower(1,:);
    h_femur_lower.YData = x_femur_lower(2,:);
    
    % plot hip linkage
    x_hip = [body(1:2,3), hip(1:2,3), hip2(1:2,3)];
    h_hip.XData = x_hip(1,:);
    h_hip.YData = x_hip(2,:);
    
    % plot the knee to ankle linkage
    x_leg = [knee(1:2,3), ankle(1:2,3)];
    h_leg.XData = x_leg(1,:);
    h_leg.YData = x_leg(2,:);
    
    % plot the ankle to foot linkage
    x_foot = [ankle(1:2,3), foot(1:2,3)];
    h_foot.XData = x_foot(1,:);
    h_foot.YData = x_foot(2,:);
end