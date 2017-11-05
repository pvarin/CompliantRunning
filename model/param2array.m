function a = param2array(p)
    a = cell2mat(struct2cell(p));
end