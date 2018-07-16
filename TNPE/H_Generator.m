function [H1, H2 ]= H_Generator(Y, S)
    % Y: I_f * (r_1 *... * r_{f-1} * r_{f+1} *... * r_k) * N
    % S: N * N
    N = size(S, 1);
    dim = size(Y(:,:, 1),1);
    
    H2 = zeros(dim, dim);
    for i=1: N
        H2 = H2 + Y(:,:,i) * Y(:,:, i)';
    end
    
    H1 = zeros(dim, dim);
    for i=1:N
        indx_set = setdiff(1:N, i);
        Y_tp = Y(:,:,i);
        for j=1:N-1
            Y_tp = Y_tp - S(i,indx_set(j)) * Y(:,:, indx_set(j));
        end
        H1 = H1+ Y_tp * Y_tp';
    end
end