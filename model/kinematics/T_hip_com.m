function T=T_hip_com(p)
    x_com = p(8);
    y_com = p(9);
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
end