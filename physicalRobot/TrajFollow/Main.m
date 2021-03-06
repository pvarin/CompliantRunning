
%Add "model" and "physicalRobot" folders to the path
%to give us access to all of those functions
    numHops=2;
    thisDir = pwd;
    idcs   = strfind(thisDir,'\');
    mainDir = thisDir(1:idcs(end)-numHops);
    addAllPaths(mainDir);

% Desired position of the foot, specified via Bezier waypoints
    load('pts.mat');
    load('traj_for_clark.mat');
    pts_foot = pts;

%Set to the actual parameters
    p = true_parameters;

    angle1_init = 0;
    angle2_init = 0;%-pi/2;

%Set up visualization
    angle1_init_vis = -pi/4;
    angle2_init_vis = 0;%-pi/2;
    flipAxis=1;

%Set Up Trajectory 

    useSimTraj = 1;
    DetectContact = 1;
    
    traj_numReps = 40;
    traj_ptcount = 100;
    
    if ~useSimTraj
        
        trajectory_time = 0.55;%0.5;
        traj_timestep = trajectory_time/traj_ptcount;

        %Create an arbitrary sine wave trajectory

            t_build = linspace(0,trajectory_time-traj_timestep,traj_ptcount);


        %Trajectory Function
            amplitudeQ1= pi./6;
            amplitudeQ2= pi./16;
            Num=4;

            derivFactor = (2*pi*Num/trajectory_time);

            sinFactor=Num* t_build*2*pi/trajectory_time;
            duty=0.5;

            q_traj=([amplitudeQ1* sin(sinFactor+duty*sin(sinFactor))+pi/2.5
                     amplitudeQ2* sin(sinFactor+duty*sin(sinFactor)+pi)+pi/10 
                     amplitudeQ1*derivFactor* cos(Num* t_build*2*pi/trajectory_time)
                     amplitudeQ2*derivFactor* -sin(Num* t_build*2*pi/trajectory_time)]);
   
            u_traj= zeros(2,traj_ptcount);
            
            x_final_out=zeros(1,4);
    else
        
        %Interpolate to get a constant timestep
            T_stance=T_stance;
            X_stance(:,4)=X_stance(:,4);
            X_stance(:,3)=X_stance(:,3);
            trajectory_time = T_stance(end);
            traj_timestep = trajectory_time/traj_ptcount;
            
            %first point is whatever the current point is
            t_build = linspace(traj_timestep,trajectory_time,traj_ptcount);

            q_traj = interp1(T_stance,X_stance(:,[3 4 8 9]),t_build')';
            u_traj= zeros(2,traj_ptcount);
            x_final_out = x_final([3 4 8 9])';
            x_final_out(2) =  x_final_out(2)/2-0.2;
            x_final_out = q_traj(:,1)';
                        
        
    end

        figure(101)    
        plot(t_build, q_traj(1:2,:))
        title('Trajectory')

        


%Set up other stuff
    buffer_time     = 3;

    mappingWorkspace = 0;
    

    reset_learning = 1;
    learning_rate = .5;

    duty_max = 0.85;


%%


if mappingWorkspace

    gains.K_q1 = 0;
    gains.K_q2 = 0;
    gains.K_q1q2 = 0;

    gains.D_q1 = 0;
    gains.D_q2 = 0;
    gains.D_q1q2 = 0;
else

    gains.K_q1 = 10;
    gains.K_q2 = 10;
    gains.K_q1q2 = 0;

    gains.D_q1 = .1;%1;%0000003;
    gains.D_q2 = .1;%1;%0000003;
    gains.D_q1q2 = 0;


end


%% Run Experiment
if reset_learning || (exist('pts_dcur1') == 0)        
    pts_dcur1 = zeros(1,13);
    pts_dcur2 = zeros(1,13);
end

totalTrajTime = 3*traj_numReps*trajectory_time;

[output_data,q_out] = Experiment_Traj(angle1_init, angle2_init,...
                        traj_ptcount, traj_timestep, totalTrajTime,...
                        traj_numReps, buffer_time,...
                        q_traj, u_traj,...
                        gains, duty_max,p, angle1_init_vis, angle2_init_vis,...
                        x_final_out, DetectContact);


%% Plot foot vs desired
t = output_data(:,1);

%Plot the whole trajectory
    q_out = [1,1,-1,1,1]'.*q_out - [0,0,angle1_init_vis, angle2_init_vis,0]';
    [ frames,fps ] = create_animation(t,q_out,p,flipAxis);
    
        
% Create push button
    figure(100)
    btn = uicontrol('Style', 'pushbutton',...
        'Position', [10 10 80 50],...
        'Callback', {@buttonCallback,frames,fps});
    btn.FontSize=12;
    btn.Position=[[10 10 80 80]];
    btn.String =  '<html> <center> Play <br> Realtime </center></html>';
