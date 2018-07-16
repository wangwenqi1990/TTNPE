function T_out = wwq_squeeze(T_in)
    shape = size(T_in);
    T_out = reshape(T_in, shape( shape ~= 1) );
end