function addModelPaths()
%Add "model" folder to the path to give us access to all of those functions

    thisDir  = pwd;
    idcs   = strfind(thisDir,'\');
    modelDir = thisDir(1:idcs(end)-1);
    modelDir = [modelDir,'\model'];
    addpath(genpath(modelDir));
end