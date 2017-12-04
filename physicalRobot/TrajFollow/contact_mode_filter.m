function mode = contact_mode_filter(data)
    stance = false;
    mode = zeros(size(data));
    for i=1:length(data)
        if stance && (data(i) < 0.001)
            stance = false;
        elseif (~stance) && (data(i) > 0.0025)
            stance = true;
        end
        mode(i) = stance;
    end
end