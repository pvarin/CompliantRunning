%% Calculate the COM

clc
close all

m_mot = 0.215;
m_p = 0.1170;

x_A = [0;0];
x_B = [-0.03903; 0.03903];
x_C = [-0.00950; -0.00269];

x_S1 = x_A+[0;-0.007];
x_S2 = x_B+[-0.007;0];


m_total = 2*m_mot + m_p

x_cm = (m_mot.*x_A + m_mot.*x_B + m_p.*x_C)/(m_total)

theta = -pi/4;
R=[cos(theta), -sin(theta); sin(theta), cos(theta)];

c_cm_adj = R* (x_cm + [0; 0.007] - [-0.04603; 0.04603])

figure(1)
hold on

plot(x_A(1),x_A(2),'.','MarkerSize',500,'Color',[0.8, 0.8,0.8])
ax=gca;
ax.ColorOrderIndex = 1;
plot(x_A(1),x_A(2),'.','MarkerSize',40)

plot(x_B(1),x_B(2),'.','MarkerSize',500,'Color',[0.8, 0.8,0.8])
ax.ColorOrderIndex = 2;
plot(x_B(1),x_B(2),'.','MarkerSize',40)
ax.ColorOrderIndex = 3;
plot(x_C(1),x_C(2),'.','MarkerSize',40)
plot(x_cm(1),x_cm(2),'.','MarkerSize',40)
plot(x_S1(1),x_S1(2),'k.','MarkerSize',40)
plot(x_S2(1),x_S2(2),'k.','MarkerSize',40)

ax=gca;

axis equal
ax.ColorOrderIndex = 1;
plot([x_S1(1), x_S2(1)], [x_S1(2), x_S2(2)], 'k--')
hold off


%% Calculate Inertia

r_m = 0.0348;
I_m = (1/2)* m_mot*r_m.^2;

r_mA = norm(x_A-x_cm);
r_mB = norm(x_B-x_cm);

r_p = norm(x_C-x_cm);
I_p = 2.834e-4;



I_tot = I_p + m_p*r_p^2 + 2*I_m + (r_mA^2 + r_mB^2).*m_mot



%% FOOT:

r_foot=0.0047625;
h_foot = 0.1016;
m_foot = 0.00246;

I_foot= m_foot/(12) *(3*r_foot^2 + h_foot^2)

