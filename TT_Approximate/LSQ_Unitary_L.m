function [X, out] = LSQ_Unitary_L(A, B, opts)
    % This function solves
    %           || X * A -B ||_F        s.t.        X is unitary matrix
    % X: m * r;     A: r * n;   B: m * n;
    % Gradient: XAA' - BA'    
    x = eye(size(B,1), size(A,1));
    [X, out]= OptStiefelGBB(x, @XAB, opts, A, B);

end