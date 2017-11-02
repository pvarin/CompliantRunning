function T = T_foot_com(p)
    x_com = p(14);
    y_com = p(15);
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
    
end