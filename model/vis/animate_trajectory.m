function animate_trajectory(q,p)
    % animate the trajectory in a naive way
    figure(1)
    for i=1:size(q,2)
        clf; hold on;
        axis equal
        axis([-2 2 -2 2]) 
        plot_model(q(:,i),p)
        drawnow
    end
end