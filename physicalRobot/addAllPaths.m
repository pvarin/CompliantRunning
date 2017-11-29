function addAllPaths(mainDir)
%Add "model" folder to the path to give us access to all of those functions
    modelDir = [mainDir,'\model'];
    robotDir = [mainDir,'\physicalRobot'];
    addpath(genpath(robotDir));
    addpath(genpath(modelDir));
    
end