function pts = polyfit_bz(vals, ts, order)
    % vals = polyfit_bz(pts, ts, order)
    %        Evaluates bezier spline with points pts at times ts.
    %        Optionally evalulates the derivative of deriv_order if passed
    %
    % pts => Columns are waypoints [p1 p2 p3 p4 ... pM]
    % ts  => Time values as a row vector
    % derive_order => Optional derivative order
    N = order+1;      % Order + 1
    M = size(vals,1); % Dimension of data
    K = size(vals,2); % number of data points
    
    B = zeros(N, K);
    for k = 0:order
        B(k+1,:) = nchoosek(order,k) * ( ts.^k .* (1-ts).^(order-k));
    end
    ptsT = (B*B')\ (B * vals');
    pts  = ptsT';
end
