function T_update = Ten_GridentNorn(T)
    shape       = size(T);
    [Q, ~, ~]   = svd(reshape(T, [shape(1) * shape(2), shape(3)]), 'econ'); 
    T_update    = reshape(Q, shape);
end