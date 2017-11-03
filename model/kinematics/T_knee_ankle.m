function T = T_knee_ankle(q,p)
    th2 = q(4);
    th_hip = p.phi;
    l3 = p.l3;
    T = [cos(th2-th_hip),  sin(th2-th_hip), -l3*sin(th2-th_hip)
        -sin(th2-th_hip),  cos(th2-th_hip),  -l3*cos(th2-th_hip)
                0,         0,            1];
end