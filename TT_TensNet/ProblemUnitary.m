function [f, g] = ProblemUnitary(x, A)
    % x is a matrix (R_{i-1}I_i) * R_i
    f = T2V(x)' * A * T2V(x);
    g = reshape(2 * T2V(x)' * A, size(x));
end