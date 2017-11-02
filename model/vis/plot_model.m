function plot_model(q,p)
    % compute keypoint frames
    [body,hip,hip2,knee,knee2,foot,...
          body_com, hip_com, knee_com, knee2_com, foot_com]...
                                                          = get_frames(q,p);
    
    % plot the upper femur linkage
    x_femur_upper = [hip(1:2,3), knee(1:2,3)];
    plot(x_femur_upper(1,:), x_femur_upper(2,:),'LineWidth',5);
    
    % plot the lower femur linkage
    x_femur_lower = [hip2(1:2,3), knee2(1:2,3)];
    plot(x_femur_lower(1,:),x_femur_lower(2,:),'LineWidth',5);
    
    % plot hip linkage
    x_hip = [body(1:2,3), hip(1:2,3), hip2(1:2,3)];
    plot(x_hip(1,:),x_hip(2,:),'LineWidth',5);
    
    % plot the knee to foot linkage
    x_leg = [knee(1:2,3), foot(1:2,3)];
    plot(x_leg(1,:),x_leg(2,:),'LineWidth',5);    
    
    % plot coordinate frames
    plot_coordinate_frame(body);
    plot_coordinate_frame(hip);
    plot_coordinate_frame(hip2);
    plot_coordinate_frame(knee);
    plot_coordinate_frame(knee2);
    plot_coordinate_frame(foot);
    
    % compute and plot center of mass
%     body_com_frame = body_frame*T_body_com(p);
    plot_com(body_com)
%     hip_com_frame = hip_frame*T_hip_com(p);
    plot_com(hip_com)
%     knee2_com_frame = knee2_frame*T_knee2_com(p);
    plot_com(knee2_com);
%     knee_com_frame = knee_frame*T_knee_com(p);
    plot_com(knee_com)
%     foot_com_frame = foot_frame*T_foot_com(p);
    plot_com(foot_com)
end

function plot_coordinate_frame(T)
    % plot little axes for the coordinate frame
    eps = 0.1;
    o = [0;0;1]; % origin
    i = [eps;0;1]; % x_axis
    j = [0;eps;1]; % y_axis
    
    % transform
    T_frame = T*[i,o,j];
    
    % plot
    plot(T_frame(1,:), T_frame(2,:))
end

function plot_com(T)
    % plot a black circle with an x through it
    eps = .025;
    o = [0;0;1]; % origin
    i1 = [eps;0;1]; % x_axis
    i2 = [-eps;0;1]; % x_axis
    j1 = [0;eps;1]; % y_axis
    j2 = [0;-eps;1]; % y_axis
    
    % transform
    o = T*o;
    i = T*[i1 i2];
    j = T*[j1 j2];
    
    % plot
    plot(o(1),o(2),'ko')
    plot(i(1,:),i(2,:),'k')
    plot(j(1,:),j(2,:),'k')
end