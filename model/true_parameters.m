function p = true_parameters    
    % physics
    p.g = 9.81;  % keep this as a parameter, so we can debug the dynamics in zero gravity

    % morphology
    p.l1 = 0.0552;     % l1 (distance from first motor to second motor)
    p.l2 = 0.0889;    % l2 hip to knee
    p.l3 = 0.2032;    % l3 knee to ankle
    p.l4 = 0.0762;     % hip to hip2
    p.l5 = 0.1016;     % uncompressed distance from ankle to foot tip
    p.phi = -pi/4;   % angle between hip1 and hip2  
    p.k = 1000;
    p.k_stop = 3000; % stiff spring for hard stop
    p.x_damping = 0;
    p.y_damping = 0;
    p.th1_damping = 0;
    p.th2_damping = 0;
    p.l_damping = 30;

    % center of mass position
    p.body_com_x = 0;         % position of body COM relative to body frame
    p.body_com_y = 0;
    p.hip_com_x = 0.0031;         % position of hip COM relative to hip frame
    p.hip_com_y = -0.0374;   
    p.upper_femur_com_x = 0.0;  % position of upper COM relative to knee frame
    p.upper_femur_com_y = 0.0889-0.05325;
    p.lower_femur_com_x = 0.0;  % position of lower femur COM relative to knee2 frame
    p.lower_femur_com_y = 0.04445;
    p.leg_com_x = 0.0;          % position of leg COM relative to ankle frame
    p.leg_com_y = 0.2032-0.12534-.0254;
    p.foot_com_x = 0;           % position of the foot COM relative to the foot frame
    p.foot_com_y = 0.1016/2;

    % masses and inertias
    p.body_mass = 0;                % mass of body <<<<<<<<< Not sure of this yet
    p.hip_mass = 0.5470;            % mass of hip
    p.upper_femur_mass = 0.0426;    % mass of upper femur
    p.lower_femur_mass = 0.0225;    % mass of lower femur
    p.ankle_mass = 0.0851;          % mass of ankle
    p.foot_mass = 0.00246;               % mass of foot <<<<<<<<< Need to get this
    
   
    p.I_body = 0;                   % inertia of body
    p.I_hip = 9.2587e-04;           % inertia of hip
    p.I_upper_femur = 5.281e-5;     % inertia of upper femur
    p.I_lower_femur = 2.433e-5;     % inertia of lower femur
    p.I_ankle = 4.503e-4;           % inertia of ankle
    p.I_foot = 2.1301e-06;          % inertia of foot
end