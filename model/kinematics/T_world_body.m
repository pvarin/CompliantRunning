function T = T_world_body(q,~)
    x = q(1);
    y = q(2);
    
    T = [1, 0, x
         0, 1, y
         0, 0, 1];
end