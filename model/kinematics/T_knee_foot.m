function T = T_knee_foot(q,p)
    th2 = q(4);
    th_hip = p(5);
    l3 = p(3);
    T = [cos(th2-th_hip),  sin(th2-th_hip), -l3*sin(th2-th_hip)
        -sin(th2-th_hip),  cos(th2-th_hip),  -l3*cos(th2-th_hip)
                0,         0,            1];
end