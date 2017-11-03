function T = T_hip_knee(q,p)
    th2 = q(4);
    l2 = p.l2;
    T = [cos(th2), -sin(th2), l2*sin(th2)
         sin(th2), cos(th2), -l2*cos(th2)
                0,        0,           1];
end