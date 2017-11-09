function animate_trajectory(t,q,p)
    % animate the trajectory in a naive way
    figure(1)
    clf; hold on;
    
    handles = plot_model(q(:,1),p);
    axis equal
    axis([-2 2 -2 2]) 
    for i=2:size(q,2)
        update_plot(q(:,i),p,handles)
        drawnow limitrate
        pause(t(i)-t(i-1))
    end
end