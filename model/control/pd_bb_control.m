function u = pd_bb_control(x,x_set,p,mode,u_const)
    if mode == ContactMode.flight
        u = 2*bsxfun(@plus,-x(3:4,:),x_set(3:4,:))-.1*x(8:9,:);
    else
        u = zeros(2,size(x,2));
        u(1,:) = 2*(-x(3,:)+x_set(3,:))-.1*x(8,:);
        if nargin > 4
            u(2,:) = -u_const;
        else
            u(2,:) = -.5;
        end
    end
end