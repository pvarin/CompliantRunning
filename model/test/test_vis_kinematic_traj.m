function test_vis_kinematic_traj
    % initialize the state
    q = example_kinematic_trajectory;
    p = [.2,1,1,.3,-.5];
    animate_trajectory(q,p);

end