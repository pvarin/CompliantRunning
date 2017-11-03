function T = T_ankle_foot(q,p)
    l = q(5);
    l_foot = p(16);
    T = [1, 0, 0
         0, 1, -l_foot + q(5)
         0, 0, 1];
end