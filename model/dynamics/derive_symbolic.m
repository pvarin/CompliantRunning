syms t x y th1 th2 dx dy dth1 dth2 ddx ddy ddth1 ddth2
syms tau1 tau2 Fx Fy

syms a b c d e f g h k l m n o p

q = [x;y;th1;th2];
dq = [dx;dy;dth1;dth2];
ddq = [ddx;ddy;ddth1;ddth2];

p = [a,b,c,d,e,f,g,h,k,l,m,n,o,p];

u = [0; 0; tau1; tau2];
Fc = [Fx; Fy; 0; 0];

body_frame = T_world_body(q,p);
hip_frame = body_frame*T_hip_frame(q,p);
hip2_frame = 

body_com = body_frame*T_body_com(p);
body_com = body_frame*T_body_com(p);