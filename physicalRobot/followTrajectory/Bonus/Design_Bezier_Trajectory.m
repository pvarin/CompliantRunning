%% Plot data from prevoius trail
figure(6)
clf;
x = output_data(:,12);
y = output_data(:,13);
plot(x,y);

axis equal
a = axis;
axis([-.3 .3 -.3 .2])

%% Get User Input (4 clicks)
[X Y] = ginput(4)
pts = [X' ; Y'];
hold on
plot(X,Y,'r--');
t = 0:.01:1;

% Start with zero velocity and acceleration
pts = [pts];

%% Evaluate bezier tarjectory
traj = polyval_bz(pts,t);
plot(traj(1,:), traj(2,:), 'g');

%% Provide pts as output for user
pts