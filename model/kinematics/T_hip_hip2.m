function T = T_hip_hip2(q,p)
    th1 = q(3);
    l4 = p.l4;
    th_hip = p.phi;
    T = [1, 0,  l4*sin(th_hip)
         0, 1, -l4*cos(th_hip)
         0, 0,               1];
end