function T=T_body_com(p)
    x_com = p.body_com_x;
    y_com = p.body_com_y;
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
end