
function [t,x,y,xdes,ydes,pts_dcur1,pts_dcur2] = Iterative_Feedfoward_Learning(pts_dcur1,pts_dcur2)

% Desired position of the foot, specified via Bezier waypoints
pts_foot = [   -0.0722   -0.0445    0.1217    0.1392
   -0.2001   -0.1112   -0.0427   -0.1637];

angle1_init = 0;
angle2_init = pi/2;

trajectory_time = 1;
buffer_time     = 2;

gains.K_xx = 30;
gains.K_yy = 30;
gains.K_xy = 0;

gains.D_xx = 1.5;
gains.D_yy = 1.5;
gains.D_xy = 0;

reset_learning = 0;
learning_rate = .2;

duty_max = 1;

%% Run Experiment
if reset_learning || (exist('pts_dcur1') == 0)        
    pts_dcur1 = zeros(1,13);
    pts_dcur2 = zeros(1,13);
end
[output_data] = Experiment_bezier(angle1_init, angle2_init, pts_foot, ...
                        trajectory_time, buffer_time, pts_dcur1,pts_dcur2,...
                        gains, duty_max);

%% Extract data
t = output_data(:,1);
x = output_data(:,12); % current
y = output_data(:,13); % current
   
xdes = output_data(:,16); % current
ydes = output_data(:,17); % current

sub_inds =  (t > buffer_time).*(t < (buffer_time+trajectory_time)) == 1; 
t_bez    =  (t(sub_inds) - buffer_time)/trajectory_time;
dcur1=output_data(sub_inds,5);
dcur2=output_data(sub_inds,10);


%% Fit current with new bezier polynomial
pts_dcur1_new = polyfit_bz(dcur1', t_bez',12);     % New fit parameters
dcur1_bez = polyval_bz(pts_dcur1_new, t_bez');     % Fitted current

pts_dcur2_new = polyfit_bz(dcur2', t_bez',12);     % New fit parameters
dcur2_bez     = polyval_bz(pts_dcur2_new, t_bez'); % Fitted current

%% Plot foot vs desired
figure(4); clf;
subplot(211); hold on
plot(t,xdes,'r-'); plot(t,x);
xlabel('Time (s)'); ylabel('X (m)'); legend({'Desired','Actual'});

subplot(212); hold on
plot(t,ydes,'r-'); plot(t,y);
xlabel('Time (s)'); ylabel('Y (m)'); legend({'Desired','Actual'});

figure(5); clf;
subplot(121); hold on;
plot(t_bez,dcur1'); plot(t_bez,dcur1_bez);
xlabel('Time (s)'); ylabel('Current 1 (A)'); legend('Actual','Bezier Fit');

subplot(122); hold on
plot(t_bez,dcur2); plot(t_bez,dcur2_bez);
xlabel('Time (s)'); ylabel('Current 2 (A)'); legend('Actual','Bezier Fit');

pts_dcur1 = (1-learning_rate) * pts_dcur1 + learning_rate*pts_dcur1_new;
pts_dcur2 = (1-learning_rate) * pts_dcur2 + learning_rate*pts_dcur2_new;

end