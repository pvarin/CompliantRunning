function test_vis_kinematic_traj
    % initialize the state
    q = example_kinematic_trajectory;
    p = example_parameters;
    t = linspace(0,2,size(q,2));
    animate_trajectory(t,q,p);
end