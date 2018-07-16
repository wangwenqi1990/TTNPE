function [f, g] = AXB(X, A, B)
    f = norm(A * X - B,'fro');
    g = A' * A * X - A' * B;
end
