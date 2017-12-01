clc
close all

m_motor = 0.215;
m_plastic = 0.1170;

x_A = [0;0];
x_B = [-0.03903; 0.03903];
x_C = [-0.00950; -0.00269];

x_S1 = x_A+[0;-0.007];
x_S2 = x_B+[-0.007;0];


m_total = 2*m_motor + m_plastic

x_cm = (m_motor.*x_A + m_motor.*x_B + m_plastic.*x_C)/(m_total)

theta = pi/4;
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
