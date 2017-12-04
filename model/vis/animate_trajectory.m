function animate_trajectory(t,q,p)
    % animate the trajectory in a naive way
    figure(100)
    clf; hold on;
    
    handles = plot_model(q(:,1),p);
    
    axis equal
    axis([-.3 2 -.3 1])
    
    ax=gca;
    x2 = ax.XLim(2) - 0.5.*(ax.XLim(2)-ax.XLim(1));
    y2 = ax.YLim(2) - 0.05.*(ax.YLim(2)-ax.YLim(1));
    h_text=text(x2,y2,'');   
                
    
    for i=2:size(q,2)
        update_plot(q(:,i),p,handles);
        h_text.String=['Current Time: ',num2str(t(i)),' sec'];
        drawnow limitrate
        pause(t(i)-t(i-1))
    end
end
