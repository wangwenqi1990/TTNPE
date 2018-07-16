function [f, g] = XAB(X, A, B)
    f = norm(X * A - B,'fro');
    g = X * A * A' - B* A';
end
