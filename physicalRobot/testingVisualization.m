
%Add "model" folder to the path to give us access to all of those functions
    thisDir  = pwd;
    idcs   = strfind(thisDir,'\');
    modelDir = thisDir(1:idcs(end)-1);
    modelDir = [modelDir,'\model'];
    addpath(genpath(modelDir));
    
    
%Plot the Visualization:
    q = example_kinematic_trajectory;
    p = example_parameters;
    t = linspace(0,2,size(q,2));
    animate_trajectory(t,q,p);
    
    %test_vis_kinematic_traj
    