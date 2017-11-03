syms t x y th1 th2 dx dy dth1 dth2 ddx ddy ddth1 ddth2
syms tau1 tau2 Fx Fy

syms a b c d e f g h k l m n o p q r s t u v w x y z

q = [x;y;th1;th2];
dq = [dx;dy;dth1;dth2];
ddq = [ddx;ddy;ddth1;ddth2];

p.l1 = l1;
p.l2 = l2;
p.l3 = l3;
p.l4 = l4;
p.l5 = l5;
p.hip_angle = phi;
p.
p = [a,b,c,d,e,f,g,h,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z];

u = [0; 0; tau1; tau2];
Fc = [Fx; Fy; 0; 0];

[body,hip,hip2,knee,knee2,ankle,foot,...
 body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                         = get_frames(q,p);
                                                     
body_pos = body_com(1:2,3);
hip_pos = hip_com(1:2,3);
knee_pos = knee_com(1:2,3);
knee2_pos = knee2_com(1:2,3);
ankle_pos = ankle_com(1:2,3);
foot_pos = foot_com(1:2,3);

g = 9.81
potential_energy = body_pos(2)*g*p.body_mass