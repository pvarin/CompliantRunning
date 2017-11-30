function vals = polyval_bz(pts, ts, deriv_order)
    % vals = polyval_bz(pts, ts, deriv_order)
    %        Evaluates bezier spline with points pts at times ts.
    %        Optionally evalulates the derivative of deriv_order if passed
    %
    % pts => Columns are waypoints [p1 p2 p3 p4 ... pM]
    % ts  => Time values as a row vector
    % derive_order => Optional derivative order
    N = size(pts,2)-1;
    M = size(pts,1);
    if nargin < 3
        deriv_order = 0;
    end
    for i = 1:deriv_order
        pts = N * diff(pts')';
        N   = N-1;
    end
    vals = zeros(M,length(ts));
    for k = 0:N
        vals = vals + pts(:,k+1) * nchoosek(N,k) * ( ts.^k .* (1-ts).^(N-k));
    end
end
