function [body,hip,hip2,knee,knee2,foot,...
          body_com, hip_com, knee_com, knee2_com, foot_com]...
                                                          = get_frames(q,p)
    % joint frames
    body = T_world_body(q,p);
    hip = body*T_body_hip(q,p);
    hip2 = hip*T_hip_hip2(q,p);
    knee = hip*T_hip_knee(q,p);
    knee2 = hip2*T_hip_knee(q,p);
    foot = knee*T_knee_foot(q,p);
    
    % center of mass frames
    body_com = body*T_body_com(p);
    hip_com = hip*T_hip_com(p);
    knee_com = knee*T_knee_com(p);
    knee2_com = knee2*T_knee2_com(p);
    foot_com = foot*T_foot_com(p);
end