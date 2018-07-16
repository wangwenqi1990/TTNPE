function [f, g] = AXBC(X, A, B, C)
    f = norm(A* X * B - C,'fro');
    g = A' * (A * X * B - C) * B';
end
