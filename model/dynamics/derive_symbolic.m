function derive_symbolic
    %% Define symbolic variables
    % time and state
    syms t x y th1 th2 l dx dy dth1 dth2 dl ddx ddy ddth1 ddth2 ddl
    q = [x; y; th1; th2; l];
    dq = [dx; dy; dth1; dth2; dl];
    ddq = [ddx; ddy; ddth1; ddth2; ddl];

    % controls and contact forces
    syms tau1 tau2 Fx Fy
    u = [tau1; tau2];
    Fc = [Fx; Fy];

    % parameters
    syms g l1 l2 l3 l4 l5 phi k k_stop x_damping y_damping th1_damping th2_damping l_damping ...
         body_com_x body_com_y hip_com_x hip_com_y ...
         upper_femur_com_x upper_femur_com_y lower_femur_com_x lower_femur_com_y ...
         leg_com_x leg_com_y foot_com_x foot_com_y ...
         body_mass hip_mass upper_femur_mass lower_femur_mass ankle_mass foot_mass ...
         I_body I_hip I_upper_femur I_lower_femur I_ankle I_foot
     
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
    p.k_stop = k_stop;
    p.x_damping = x_damping;
    p.y_damping = y_damping;
    p.th1_damping = th1_damping;
    p.th2_damping = th2_damping;
    p.l_damping = l_damping;

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
    
    p.I_body = I_body; % mass of body
    p.I_hip = I_hip; % mass of hip
    p.I_upper_femur = I_upper_femur; % mass of upper femur
    p.I_lower_femur = I_lower_femur; % mass of lower femur
    p.I_ankle = I_ankle; % mass of ankle
    p.I_foot = I_foot; % mass of foot

    %% Compute Lagrangian
    % potential energy
    V = potential_energy(q,p);
    
    % kinetic energy
    [~,~,~,~,~,~,foot, body_com, hip_com, knee_com,...
                    knee2_com, ankle_com, foot_com] = get_frames(q,p);
    ddt = @(r) jacobian(r,[q;dq])*[dq;ddq]; 
    dbody_com = reshape(ddt(body_com(:)),3,3);
    dhip_com = reshape(ddt(hip_com(:)),3,3);
    dknee_com = reshape(ddt(knee_com(:)),3,3);
    dknee2_com = reshape(ddt(knee2_com(:)),3,3);
    dankle_com = reshape(ddt(ankle_com(:)),3,3);
    dfoot_com = reshape(ddt(foot_com(:)),3,3);
    
    % linear kinetic energy
    body_vel = dbody_com(1:2,3);
    hip_vel = dhip_com(1:2,3);
    knee_vel = dknee_com(1:2,3);
    knee2_vel = dknee2_com(1:2,3);
    ankle_vel = dankle_com(1:2,3);
    foot_vel = dfoot_com(1:2,3);
    
    T = .5*p.body_mass*(body_vel.'*body_vel) + .5*p.hip_mass*(hip_vel.'*hip_vel) + ...
        .5*p.upper_femur_mass*(knee_vel.'*knee_vel) + .5*p.lower_femur_mass*(knee2_vel.'*knee2_vel) + ...
        .5*p.ankle_mass*(ankle_vel.'*ankle_vel) + .5*p.foot_mass*(foot_vel.'*foot_vel);
    
    % rotational kinetic energy
    body_rot = dbody_com(1:2,1).'*body_com(1:2,2);
    hip_rot = dhip_com(1:2,1).'*hip_com(1:2,2);
    upper_femur_rot = dknee_com(1:2,1).'*knee_com(1:2,2);
    lower_femur_rot = dknee2_com(1:2,1).'*knee2_com(1:2,2);
    ankle_rot = dankle_com(1:2,1).'*ankle_com(1:2,2);
    foot_rot = dfoot_com(1:2,1).'*foot_com(1:2,2);
    
    T = T + .5*p.I_body*body_rot^2 + .5*p.I_hip*hip_rot^2 + ...
        .5*p.I_upper_femur*upper_femur_rot^2 + .5*p.I_lower_femur*lower_femur_rot^2 + ...
        .5*p.I_ankle*ankle_rot^2 + .5*p.I_foot*foot_rot^2;
    
    % energy and lagrangian
    energy = T+V;
    L = T-V;
    
    %% Derive the equations of motion
    % foot jacobian to compute generalized force from foot contact
    foot_pos = foot(1:2,3);
    J_foot = jacobian(foot_pos,q);
    B = zeros(5,2);
    B(3,1) = 1;
    B(4,2) = 1;
    D = diag([p.x_damping, p.y_damping, p.th1_damping, p.th2_damping, p.l_damping]);
    eom = ddt(jacobian(L,dq).') - jacobian(L,q).' - J_foot.'*Fc - B*u + D*dq;
    
    A = jacobian(eom,ddq); % mass matrix
    b = A*ddq - eom; % everything other than the mass matrix
    
    %% Derive the Contraint function
    C_foot_height = foot_pos(2);
    C1_foot_height = jacobian(C_foot_height,q);
    C2_foot_height = dq.'*jacobian(C1_foot_height,q)*dq;
    
    C_foot_x = foot_pos(1);
    C1_foot_x = jacobian(C_foot_x,q);
    C2_foot_x = dq.'*jacobian(C1_foot_x,q)*dq;
    
    x_c = [ddq; Fc];
    g_c = [eom; [C1_foot_x; C1_foot_height]*ddq + [C2_foot_x; C2_foot_height]];
    A_c = jacobian(g_c, x_c);
    b_c = simplify(A_c*x_c - g_c);
    
    %% Save functions
    dir = fileparts(mfilename('fullpath'));
    directory = fullfile(dir,'autogen');
    [~, ~, ~] = mkdir(directory);
    addpath(directory)
    
    z = [q;dq];
    p_array = cell2sym(struct2cell(p));
    matlabFunction(T,'file',fullfile(directory,'kinetic_energy'),'vars',{z, p_array});
    matlabFunction(energy,'file',fullfile(directory,'energy'),'vars',{z, p_array});
    matlabFunction(A,'file',fullfile(directory, 'A'),'vars',{z, p_array});
    matlabFunction(b,'file',fullfile(directory, 'b'),'vars',{z, u, Fc, p_array});
    matlabFunction(C_foot_height,'file',fullfile(directory,'C_foot_height'),'vars',{z,p_array});
    matlabFunction(A_c,'file',fullfile(directory,'A_c'),'vars',{z, p_array});
    matlabFunction(b_c,'file',fullfile(directory,'b_c'),'vars',{z, u, p_array});
end