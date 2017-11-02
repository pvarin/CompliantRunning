function test_vis_kinematic_traj
    % initialize the state
    q = example_kinematic_trajectory;
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
    p(14) = 0.0; % position of leg COM relative to foot frame
    p(15) = 0.75;
    animate_trajectory(q,p);

end