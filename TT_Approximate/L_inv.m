function T = L_inv(M, r_0, I_1, r_1)
    % reverse of tensor left unfoling
    % M:    r_0I_1 * r_1
    % T:    r_0 * I_1 * r_1
    T = mat2tens(M, [r_0, I_1, r_1], [1,2],3);
end