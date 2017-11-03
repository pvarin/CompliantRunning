function T = T_knee2_com(p)
    x_com = p.lower_femur_com_x;
    y_com = p(13);
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
    
end