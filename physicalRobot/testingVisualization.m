
%Add "model" and "physicalRobot" folders to the path
%to give us access to all of those functions
    numHops=1;
    thisDir=pwd;
    idcs   = strfind(thisDir,'\');
    mainDir = thisDir(1:idcs(end)-numHops);
    addAllPaths(mainDir);
    
    
%Plot the Visualization:
    q_DES = sample_traj;
    p = true_parameters;
    t = linspace(0,2,size(q_DES,2));
    [ frames,fps ] = create_animation(t,q_DES,p);
    disp(['We are animating at: ',num2str(fps)]);
    movie(frames,2,fps);
    
    
    %test_vis_kinematic_traj
    