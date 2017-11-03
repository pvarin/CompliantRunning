function [body,hip,hip2,knee,knee2,ankle,foot,...
          body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                          = get_frames(q,p)
    % joint frames
    body = T_world_body(q,p);
    hip = body*T_body_hip(q,p);
    hip2 = hip*T_hip_hip2(q,p);
    knee = hip*T_hip_knee(q,p);
    knee2 = hip2*T_hip_knee(q,p);
    ankle = knee*T_knee_ankle(q,p);
    foot = ankle*T_ankle_foot(q,p);
    
    % center of mass frames
    body_com = body*T_body_com(p);
    hip_com = hip*T_hip_com(p);
    knee_com = knee*T_knee_com(p);
    knee2_com = knee2*T_knee2_com(p);
    ankle_com = ankle*T_ankle_com(p);
    foot_com = foot*T_foot_com(p);
end