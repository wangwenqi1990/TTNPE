function err = diffU(U_tp, U)
    n = length(U);
    err =0;
    for i=1:n
        err = err+norm(T2V(U_tp{i} -U{i}))/norm(T2V(U{i}));
    end
end