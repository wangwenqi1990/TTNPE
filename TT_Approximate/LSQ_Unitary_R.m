function [X, out] = LSQ_Unitary_R(A, B, opts)
    % This function solves
    %           || A * X -B ||_F        s.t.        X is unitary matrix
    % A: m * r;     X: r * n;   B: m * n;
    % Gradient: XAA' - BA'
    %%
    x = eye(size(A,2), size(B, 2));
    [X, out]= OptStiefelGBB(x, @AXB, opts, A, B);
    %X(isnan(X))=0;

end


