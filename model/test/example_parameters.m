function p = example_parameters    
    % physics
    p.g = 9.81;  % keep this as a parameter, so we can debug the dynamics in zero gravity

    % morphology
    p.l1 = 0.2;     % l1 (distance from first motor to second motor)
    p.l2 = 0.75;    % l2 hip to knee
    p.l3 = 1.25;    % l3 knee to ankle
    p.l4 = 0.3;     % hip to hip2
    p.l5 = 0.1;     % uncompressed distance from ankle to foot tip
    p.phi = -0.5;   % angle between hip1 and hip2  
    p.k = 1000;

    % center of mass position
    p.body_com_x = 0.1;         % position of body COM relative to body frame
    p.body_com_y = 0.1; 
    p.hip_com_x = -0.1;         % position of hip COM relative to hip frame
    p.hip_com_y = -0.1;
    p.upper_femur_com_x = 0.0;  % position of upper COM relative to knee frame
    p.upper_femur_com_y = 0.325;
    p.lower_femur_com_x = 0.0;  % position of lower femur COM relative to knee2 frame
    p.lower_femur_com_y = 0.325;
    p.leg_com_x = 0.0;          % position of leg COM relative to ankle frame
    p.leg_com_y = 0.75;
    p.foot_com_x = 0;           % position of the foot COM relative to the foot frame
    p.foot_com_y = 0.05;

    % masses and inertias
    p.body_mass = 1;        % mass of body
    p.hip_mass = 1;         % mass of hip
    p.upper_femur_mass = 1; % mass of upper femur
    p.lower_femur_mass = 1; % mass of lower femur
    p.ankle_mass = 1;       % mass of ankle
    p.foot_mass = 1;        % mass of foot
    
    p.I_body = 1;           % mass of body
    p.I_hip = 1;            % mass of hip
    p.I_upper_femur = 1;    % mass of upper femur
    p.I_lower_femur = 1;    % mass of lower femur
    p.I_ankle = 1;          % mass of ankle
    p.I_foot = 1;           % mass of foot
end