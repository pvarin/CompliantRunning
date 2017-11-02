function T = T_body_hip(q,p)
    th1 = q(3);
    l1 = p(1);
    T = [cos(th1), -sin(th1), l1*sin(th1)
         sin(th1), cos(th1), -l1*cos(th1)
         0,        0,           1];
end