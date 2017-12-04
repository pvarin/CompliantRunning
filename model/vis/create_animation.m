function [ frames,fps ] = create_animation(t,q,p, FlipAxis)
%CREATE_ANIMATION -  It creates an animation

% animate the trajectory in a naive way
    figure(100)
    clf; hold on;
    
    handles = plot_model(q(:,1),p);
    
    axis equal
    axis([-0.7 0.7 -0.5 0.5])
    
    ax=gca;
    x2 = ax.XLim(2) - 0.5.*(ax.XLim(2)-ax.XLim(1));
    y2 = ax.YLim(2) - 0.05.*(ax.YLim(2)-ax.YLim(1));
    
    if FlipAxis
    ax.XDir='reverse';
    end
    
    h_text=text(x2,y2,'');  
    h_text.String=['Current Time: ',num2str(t(1)),' sec'];
    
    %Figure out the timing
        frameTimeRaw=mean(t(2:end)- t(1:end-1));
        frameRateRaw = 1/frameTimeRaw;
        maxRate=20;
    
        numSkip = ceil(frameRateRaw/maxRate)

        fps = frameRateRaw/numSkip;
        

    %Plot the whole trajectory and save the relevant frames
    clear frames
        frames(1)=getframe;

        for i=numSkip+1:numSkip:size(q,2)
            
            update_plot(q(:,i),p,handles);
            update_traces(q(:,i-numSkip:i),p,handles)

            h_text.String=['Current Time: ',num2str(t(i)),' sec'];
            drawnow

                %disp(['Saving Frame: ',num2str(i)]);
                frames(end+1) = getframe;
        end
        
     %Save the last frame regardless of if the timing
        frames(end+1) = getframe;

        
    disp(['We are animating at: ',num2str(fps),' fps']);

end

