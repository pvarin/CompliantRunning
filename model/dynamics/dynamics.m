function qdd = dynamics(q,dq,u,Fc,p)
    z = [q;dq];
    qdd = A(z, p)\b(z, u, Fc, p);
end