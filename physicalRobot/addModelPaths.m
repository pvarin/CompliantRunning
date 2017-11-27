function addModelPaths()
%Add "model" folder to the path to give us access to all of those functions

    thisDir  = pwd;
    idcs   = strfind(thisDir,'\');
    mainDir = thisDir(1:idcs(end)-1);
    modelDir = [mainDir,'\model'];
    robotDir = [mainDir,'\physicalRobot'];
    addpath(genpath(robotDir));
    
end