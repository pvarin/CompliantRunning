function [output_data,q] = Experiment_bezier( angle1_init, angle2_init, pts_foot, traj_time, buffer_time, pts_cur1, pts_cur2, gains, duty_max,p)
    %Get Params
        

    %Set up figures
        figure(2);  clf;       
        a1 = subplot(421);
        h1 = plot([0],[0]);
        h1.XData = []; h1.YData = [];
        ylabel('Angle 1 (rad)');

        a2 = subplot(423);
        h2 = plot([0],[0]);
        h2.XData = []; h2.YData = [];
        ylabel('Velocity 1 (rad/s)');

        a3 = subplot(425);
        h3 = plot([0],[0]);
        h3.XData = []; h3.YData = [];
        ylabel('Current 1 (A)');
        hold on;
        subplot(425);
        h4 = plot([0],[0],'r');
        h4.XData = []; h4.YData = [];
        hold off;

        a4 = subplot(427);
        h5 = plot([0],[0]);
        h5.XData = []; h5.YData = [];
        ylabel('Duty Ratio 1 (%)');


        a5 = subplot(422);
        h12 = plot([0],[0]);
        h12.XData = []; h12.YData = [];
        ylabel('Angle 2 (rad)');

        a6 = subplot(424);
        h22 = plot([0],[0]);
        h22.XData = []; h22.YData = [];
        ylabel('Velocity (counts/s)');

        a7 = subplot(426);
        h32 = plot([0],[0]);
        h32.XData = []; h32.YData = [];
        ylabel('Current 2 (A)');
        hold on;
        subplot(426);
        h42 = plot([0],[0],'r');
        h42.XData = []; h42.YData = [];
        hold off;
        a8 = subplot(428);
        h52 = plot([0],[0]);
        h52.XData = []; h52.YData = [];
        ylabel('Duty Ratio 2 (%)');
    
    
    %Set up visualization 
        figure(1)
        clf; hold on;
        handles = plot_model(zeros(5,1),p);
        axis equal
        axis([-2 2 -2 2])
       
    
     
%     axis equal
%     axis([-.25 .25 -.25 .1]);
%    
%     h_OB = plot([0],[0],'LineWidth',2);
%     h_AC = plot([0],[0],'LineWidth',2);
%     h_BD = plot([0],[0],'LineWidth',2);
%     h_CE = plot([0],[0],'LineWidth',2);
%   

hold on
q=[];

    h_foot= plot([0],[0],'k');
    h_des = plot([0],[0],'k--');
    h_des.XData=[];
    h_des.YData=[];
    h_foot.XData=[];
    h_foot.YData=[];
    
   
    
    %% Definte fixed paramters
%     m1 =.03;
%     m2 =.01; 
%     m3 = .01;
%     m4 = .02;
%     I1 = .0005;
%     I2 = .0005;
%     I3 = .0005;
%     I4 = .0005;
%     l_OA=.010; 
%     l_OB=.040; 
%     l_AC=.095; 
%     l_DE=.095;
%     
%     l_O_m1=1/2 * l_OB; 
%     l_B_m2=1/2 * l_AC; 
%     l_A_m3=1/2 * l_AC; 
%     l_C_m4=1/2 * (l_DE+ l_OB-l_OA);
%     g = 10*0;
% 
%     p   = [m1 m2 m3 m4 I1 I2 I3 I4 l_O_m1 l_B_m2 l_A_m3 l_C_m4 l_OA l_OB l_AC l_DE g]';
    
    % This function will get called any time there is new data from
    % the FRDM board. Data comes in blocks, rather than one at a time.
    function my_callback(new_data)
        t = new_data(:,1);   % time
        pos1 = new_data(:,2); % position
        vel1 = new_data(:,3); % velocity
        cur1 = new_data(:,4); % current
        dcur1 = new_data(:,5); % current
        duty1 = new_data(:,6); % current
        
        pos2 = new_data(:,7); % position
        vel2 = new_data(:,8); % velocity
        cur2 = new_data(:,9); % current
        dcur2 = new_data(:,10); % current
        duty2 = new_data(:,11); % current
        
        x_foot = new_data(:,12); % current
        y_foot = new_data(:,13); % current
        
        x_foot_des = new_data(:,16); % current
        y_foot_des = new_data(:,17); % current
%         
%         vx_foot_des = new_data(:,18); % current
%         vy_foot_des = new_data(:,19); % current       
        
        l_foot = new_data(:,20); %Foot Position
        
        x_body = new_data(:,21); %MCU's estimate of the body position
        y_body = new_data(:,22); %MCU's estimate of the body position
        
        hybridState = new_data(:,23); %1 if by land, 2 if by air
        
%         
        
        N = length(pos1);
        
        h1.XData(end+1:end+N) = t;   
        h1.YData(end+1:end+N) = pos1;
        h2.XData(end+1:end+N) = t;   
        h2.YData(end+1:end+N) = vel1;
        h3.XData(end+1:end+N) = t;   
        h3.YData(end+1:end+N) = cur1;
        h4.XData(end+1:end+N) = t;   
        h4.YData(end+1:end+N) = dcur1;
        h5.XData(end+1:end+N) = t;   
        h5.YData(end+1:end+N) = duty1;
        
        h12.XData(end+1:end+N) = t;   
        h12.YData(end+1:end+N) = pos2;
        h22.XData(end+1:end+N) = t;   
        h22.YData(end+1:end+N) = vel2;
        h32.XData(end+1:end+N) = t;   
        h32.YData(end+1:end+N) = cur2;
        h42.XData(end+1:end+N) = t;  
        h42.YData(end+1:end+N) = dcur2;
        h52.XData(end+1:end+N) = t;   
        h52.YData(end+1:end+N) = duty2;
        
        %Build q using sensor data
        q(:,end+1: end+N) = [x_body'
                             y_body'
                             pos1'
                             pos2'
                             l_foot'];
          
        %Update ankle position tracker
%         ankle_vec=zeros(2,N);
                    
%         for idx=1:N 
%             [body,hip,hip2,knee,knee2,ankle,foot,...
%             body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
%                                                       = get_frames(q(:,idx),p);
%           ankle_vec(:,idx)=ankle(1:2,3);
%         end
% 
%         h_foot.XData(end+1:end+N) = ankle_vec(1,:);
%         h_foot.YData(end+1:end+N) = ankle_vec(2,:);
%         
%         h_des.XData(end+1:end+N) = x_foot_des;
%         h_des.YData(end+1:end+N) = y_foot_des;
%         drawnow
        
        %Redraw the Robot
            update_plot(q(:,end),p,handles);
    
%         z = [pos1(end) pos2(end) vel1(end) vel2(end)]';
%         keypoints = keypoints_leg(z,p);
%         
%         rA = keypoints(:,1); 
%         rB = keypoints(:,2);
%         rC = keypoints(:,3);
%         rD = keypoints(:,4);
%         rE = keypoints(:,5);
% 
%         set(h_OB,'XData',[0 rB(1)],'YData',[0 rB(2)]);
%         set(h_AC,'XData',[rA(1) rC(1)],'YData',[rA(2) rC(2)]);
%         set(h_BD,'XData',[rB(1) rD(1)],'YData',[rB(2) rD(2)]);
%         set(h_CE,'XData',[rC(1) rE(1)],'YData',[rC(2) rE(2)]);
%         

    end
    
    %%
    frdm_ip  = '192.168.1.100';     % FRDM board ip
    frdm_port= 11223;               % FRDM board port  
    params.callback = @my_callback; % callback function
              % end of experiment timeout
    
    
    %% Parameters for tuning
    pwm_period_us               = 100;  % PWM_Period in mirco seconds
    current_control_period_us   = 100;  % Current control period in micro seconds
    impedance_control_period_us = 1000; % Impedance control period in microseconds seconds
    start_period                = buffer_time;   % Experiment time in seconds 
    end_period                  = buffer_time;   % Experiment time in seconds 
    
    
    R                        = 2.5; % Terminal resistance (Ohms)
    k_emf                    = .17; % Back EMF Constant (V / (rad/s))
    nu1                       = 5e-4;% Friction coefficienct (Nm / (rad/s))
    nu2                       = 5e-4;% Friction coefficienct (Nm / (rad/s))
    
    supply_voltage           = 12;  % Power Supply Voltage (V)
    current_gain             = 5;  % Proportional current gain (V/A)
    K_xx                     = gains.K_xx; % Stiffness
    K_yy                     = gains.K_yy; % Stiffness
    K_xy                     = gains.K_xy; % Stiffness

    D_xx                     = gains.D_xx; % Damping
    D_yy                     = gains.D_yy; % Damping
    D_xy                     = gains.D_xy; % Damping
    
    
    %% Sepectify inputs
    input = [pwm_period_us current_control_period_us impedance_control_period_us start_period traj_time end_period];
    input = [input R k_emf nu1 nu2 supply_voltage angle1_init angle2_init];
    input = [input current_gain K_xx K_yy K_xy D_xx D_yy D_xy];
    input = [input duty_max];
    input = [input pts_foot(:)'];
    input = [input pts_cur1 pts_cur2];
    
    params.timeout  = (start_period+traj_time+end_period);  
    
    
    output_size = 23;    % number of outputs expected
    output_data = RunExperiment(frdm_ip,frdm_port,input,output_size,params);
    linkaxes([a1 a2 a3 a4],'x')
    
    
    %Plot the Ankle Trajectory
        ankle_vec=zeros(2,size(q,2));
        for idx=1:size(q,2) 
        [body,hip,hip2,knee,knee2,ankle,foot,...
        body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                      = get_frames(q(:,idx),p);
          ankle_vec(:,idx)=ankle(1:2,3);
        end

        h_foot.XData = ankle_vec(1,:);
        h_foot.YData = ankle_vec(2,:);

assignin('base','h_foot',h_foot);


end