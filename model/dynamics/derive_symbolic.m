function derive_symbolic
    %% Define symbolic variables
    % time and state
    syms t x y th1 th2 l dx dy dth1 dth2 dl ddx ddy ddth1 ddth2 ddl
    q = [x; y; th1; th2; l];
    dq = [dx; dy; dth1; dth2; dl];
    ddq = [ddx; ddy; ddth1; ddth2; ddl];

    % controls and contact forces
    syms tau1 tau2 Fx Fy
    u = [0; 0; tau1; tau2];
    Fc = [Fx; Fy; 0; 0];

    % parameters
    syms g l1 l2 l3 l4 l5 phi k...
         body_com_x body_com_y hip_com_x hip_com_y ...
         upper_femur_com_x upper_femur_com_y lower_femur_com_x lower_femur_com_y ...
         leg_com_x leg_com_y foot_com_x foot_com_y ...
         body_mass hip_mass upper_femur_mass lower_femur_mass ankle_mass foot_mass

    % physics
    p.g = g;
     
    % morphology
    p.l1 = l1;  % l1 (distance from first motor to second motor)
    p.l2 = l2; % l2 hip to knee
    p.l3 = l3; % l3 knee to ankle
    p.l4 = l4;  % hip to hip2
    p.l5 = l5; % uncompressed distance from ankle to foot tip
    p.phi = phi; % angle between hip1 and hip2
    p.k = k;

    % center of mass position
    p.body_com_x = body_com_x; % position of body COM relative to body frame
    p.body_com_y = body_com_y; 
    p.hip_com_x = hip_com_x; % position of hip COM relative to hip frame
    p.hip_com_y = hip_com_y;
    p.upper_femur_com_x = upper_femur_com_x; % position of upper COM relative to knee frame
    p.upper_femur_com_y = upper_femur_com_y;
    p.lower_femur_com_x = lower_femur_com_x; % position of lower femur COM relative to knee2 frame
    p.lower_femur_com_y = lower_femur_com_y;
    p.leg_com_x = leg_com_x; % position of leg COM relative to ankle frame
    p.leg_com_y = leg_com_y;
    p.foot_com_x = foot_com_x;   % position of the foot COM relative to the foot frame
    p.foot_com_y = foot_com_y;

    % masses and inertias
    p.body_mass = body_mass; % mass of body
    p.hip_mass = hip_mass; % mass of hip
    p.upper_femur_mass = upper_femur_mass; % mass of upper femur
    p.lower_femur_mass = lower_femur_mass; % mass of lower femur
    p.ankle_mass = ankle_mass; % mass of ankle
    p.foot_mass = foot_mass; % mass of foot

    %% Compute Lagrangian
    [body,hip,hip2,knee,knee2,ankle,foot,...
     body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                             = get_frames(q,p);

    body_pos = body_com(1:2,3);
    hip_pos = hip_com(1:2,3);
    knee_pos = knee_com(1:2,3);
    knee2_pos = knee2_com(1:2,3);
    ankle_pos = ankle_com(1:2,3);
    foot_pos = foot_com(1:2,3);

    % potential energy
    V = potential_energy(q,p);
    % TODO: finish deriving the lagrangian
end