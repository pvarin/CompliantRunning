function plot_model(q,p)
    body_frame = T_world_body(q,p);
    hip_frame = body_frame*T_body_hip(q,p);
    knee_frame = hip_frame*T_hip_knee(q,p);
    foot_frame = knee_frame*T_knee_foot(q,p);
    
    hip2_frame = hip_frame*T_hip_hip2(q,p);
    knee2_frame = hip2_frame*T_hip_knee(q,p);
    
    x = [body_frame(1,3), hip_frame(1,3), knee_frame(1,3), foot_frame(1,3)];
    y = [body_frame(2,3), hip_frame(2,3), knee_frame(2,3), foot_frame(2,3)];
    plot(x,y,'b');
    
    plot_coordinate_frame(body_frame);
    plot_coordinate_frame(hip_frame);
    plot_coordinate_frame(knee_frame);
    plot_coordinate_frame(foot_frame);
    
    % linkage
    x_linkage = [hip_frame(1,3), hip2_frame(1,3), knee2_frame(1,3)];
    y_linkage = [hip_frame(2,3), hip2_frame(2,3), knee2_frame(2,3)];
    plot(x_linkage, y_linkage, 'b')
    
    plot_coordinate_frame(hip_frame);
    plot_coordinate_frame(knee_frame);
end

function plot_coordinate_frame(T)
    o = [0;0;1]; % origin
    i = [.1;0;1]; % x_axis
    j = [0;.1;1]; % y_axis
    
    frame = [i,o,j];
    T_frame = T*frame;
    plot(T_frame(1,:), T_frame(2,:))
end