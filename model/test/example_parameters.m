function p = example_parameters    
    % morphology
    p.l1 = 0.2;  % l1 (distance from first motor to second motor)
    p.l2 = 0.75; % l2 hip to knee
    p.l3 = 1.25; % l3 knee to ankle
    p.l4 = 0.3;  % hip to hip2
    p.l5 = 0.1; % uncompressed distance from ankle to foot tip
    p.phi = -0.5; % angle between hip1 and hip2  

    % center of mass position
    p.body_com_x = 0.1; % position of body COM relative to body frame
    p.body_com_y = 0.1; 
    p.hip_com_x = -0.1; % position of hip COM relative to hip frame
    p.hip_com_y = -0.1;
    p.upper_femur_com_x = 0.0; % position of upper COM relative to knee frame
    p.upper_femur_com_y = 0.325;
    p.lower_femur_com_x = 0.0; % position of lower femur COM relative to knee2 frame
    p.lower_femur_com_y = 0.325;
    p.leg_com_x = 0.0; % position of leg COM relative to ankle frame
    p.leg_com_y = 0.75;
    p.foot_com_x = 0;   % position of the foot COM relative to the foot frame
    p.foot_com_y = 0.05;

    % masses and inertias
    p.body_mass = 1; % mass of body
    p.hip_mass = 1; % mass of hip
    p.upper_femur_mass = 1; % mass of upper femur
    p.lower_femur_mass = 1; % mass of lower femur
    p.ankle_mass = 1; % mass of ankle
    p.foot_mass = 1; % mass of foot
    
    
    p(1) = 0.2;  % l1 (distance from first motor to second motor)
    p(2) = 0.75; % l2 hip to knee
    p(3) = 1.25; % l3 knee to ankle
    p(4) = 0.3;  % hip to hip2
    p(5) = -0.5; % angle between hip1 and hip2  
    p(6) = 0.1; % position of body COM relative to body frame
    p(7) = 0.1; 
    p(8) = -0.1; % position of hip COM relative to hip frame
    p(9) = -0.1;
    p(10) = 0.0; % position of upper COM relative to knee frame
    p(11) = 0.325;
    p(12) = 0.0; % position of lower femur COM relative to knee2 frame
    p(13) = 0.325;
    p(14) = 0.0; % position of leg COM relative to ankle frame
    p(15) = 0.75;
    p(16) = 0.1; % uncompressed distance from ankle to foot tip
    p(17) = 0;   % position of the foot COM relative to the foor frame
    p(18) = 0.05;
    p(19) = 1; % mass of body
    p(20) = 1; % mass of hip
    p(21) = 1; % mass of upper femur
    p(22) = 1; % mass of lower femur
    p(23) = 1; % mass of ankle
    p(24) = 1; % mass of foot
end