function update_traces(q, p, handles)
%q is a vector of states    

    N=size(q,2);
    x_ankle=zeros(2,N);
    for idx=1:size(q,2) 
    [body,hip,hip2,knee,knee2,ankle,foot,...
    body_com, hip_com, knee_com, knee2_com, ankle_com, foot_com]...
                                                  = get_frames(q(:,idx),p);
      x_ankle(:,idx)=ankle(1:2,3);
    end
        
    % extract the plot handles                                
    h_ankle = handles{6};
    
   
   
    h_ankle.XData(end+1:end+N) = x_ankle(1,:);
    h_ankle.YData(end+1:end+N) = x_ankle(2,:);
    
end