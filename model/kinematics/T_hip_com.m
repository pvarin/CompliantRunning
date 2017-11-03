function T=T_hip_com(p)
    x_com = p.hip_com_x;
    y_com = p.hip_com_x;
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
end