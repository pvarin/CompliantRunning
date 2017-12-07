load output_data_1BigBand.mat

time = output_data_1BigBand(:,1);
idx = (time > 7) & (time < 11);
time = time(idx)
setpoint_1 = output_data_1BigBand(idx,12);
data_1 = output_data_1BigBand(idx,2);
setpoint_2 = output_data_1BigBand(idx,13);
data_2 = output_data_1BigBand(idx,7);
figure(1276); clf
subplot(2,1,1)
plot(time, data_1,time, setpoint_1,'LineWidth',1);
title('Trajectory Following');
ylabel('\theta_1 (rad)');
set(gca,'FontSize',14);
legend('Measured Position','Set Point')
subplot(2,1,2)
plot(time, data_2,time, setpoint_2,'LineWidth',1);
ylabel('\theta_1 (rad)');
xlabel('Time (s)');
set(gca,'FontSize',14);