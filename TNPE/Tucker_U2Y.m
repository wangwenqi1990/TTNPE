function y = Tucker_U2Y(U, A)
    % A is a tensor                         I_1,...., I_k, N
    % U is a cell(;,1), and each one is     r_i * I_i
    % Y is a tensor                         r_1,...., r_k, N
    
    n = size(A);
    k = length(n)-1;
    
    n_tp =n;
    y = A;
    for i=1:k
        %%
        M = tens2mat(y, i, setdiff(1:k+1, i));
        M = U{i} * M;
        n_tp(i) = size(U{i}, 1);
        y = mat2tens(M, n_tp, i, setdiff(1:k+1, i));
    end
end