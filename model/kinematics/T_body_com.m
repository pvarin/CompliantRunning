function T=T_body_com(p)
    x_com = p(6);
    y_com = p(7);
    T = [1, 0, x_com
         0, 1, y_com
         0, 0,    1];
end