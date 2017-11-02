function plot_model(q,p)
    % compute keypoint frames
    body_frame = T_world_body(q,p);
    hip_frame = body_frame*T_body_hip(q,p);
    knee_frame = hip_frame*T_hip_knee(q,p);
    foot_frame = knee_frame*T_knee_foot(q,p);
    hip2_frame = hip_frame*T_hip_hip2(q,p);
    knee2_frame = hip2_frame*T_hip_knee(q,p);
    
    % plot hip linkage
    x_hip = [body_frame(1:2,3), hip_frame(1:2,3), hip2_frame(1:2,3)];
    plot(x_hip(1,:),x_hip(2,:),'b','LineWidth',5);
    
    x_femur_upper = [hip_frame(1:2,3), knee_frame(1:2,3)];
    plot(x_femur_upper(1,:), x_femur_upper(2,:),'r','LineWidth',5);
    
    x_femur_lower = [hip2_frame(1:2,3), knee2_frame(1:2,3)];
    plot(x_femur_lower(1,:),x_femur_lower(2,:),'g','LineWidth',5);
    
    x_leg = [knee_frame(1:2,3), foot_frame(1:2,3)];
    plot(x_leg(1,:),x_leg(2,:),'c','LineWidth',5);    
    
    % plot coordinate frames
    plot_coordinate_frame(body_frame);
    plot_coordinate_frame(hip_frame);
    plot_coordinate_frame(hip2_frame);
    plot_coordinate_frame(knee_frame);
    plot_coordinate_frame(knee2_frame);
    plot_coordinate_frame(foot_frame);
    
    % compute and plot center of mass
    body_com_frame = body_frame*T_body_com(p);
    plot_com(body_com_frame)
    hip_com_frame = hip_frame*T_hip_com(p);
    plot_com(hip_com_frame)
    knee2_com_frame = knee2_frame*T_knee2_com(p);
    plot_com(knee2_com_frame);
    knee_com_frame = knee_frame*T_knee_com(p);
    plot_com(knee_com_frame)
    foot_com_frame = foot_frame*T_foot_com(p);
    plot_com(foot_com_frame)
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