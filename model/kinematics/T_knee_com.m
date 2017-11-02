function T = T_knee_com(p)
    x_com = p(10);
    y_com = p(11);
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
    
end