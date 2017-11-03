function T = T_ankle_com(p)
    x_com = p(17);
    y_com = p(18);
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
    
end