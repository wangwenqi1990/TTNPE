function G = grident_Uk(Ui, Z, k)
    % Ui:  U1,...,Un are r_{i-1} * I_i * r_i 
    % Z:  (I1 *...*In) * (I1 *...* In)
    
    n = length(Ui);
    
    % T_all:        I1 * I2 *... * In * Rn
    T_all = merge_tensor(Ui);   
    
    % T_1km1:       I1 * I2 *... * Ik-1 * Rk-1
    if k==1
        T_1km1 = [];
    else
        T_1km1 = merge_tensor(Ui(1:k-1));
    end

    % T_kp1n:       Rk * Ik+1 *... * In * Rn
    if k==n
        T_kp1n = [];
    else
        T_kp1n = merge_tensor(Ui(k+1:n));
    end
    
    % Grident merging
    % G:            I1 *...* In * Rn
    G = wwq_tensordot(Z, T_all, n+1:2*n, 1:n);
    if k==1
        G = wwq_tensordot(G, T_kp1n, 2:n+1, 2:n+1);             % 
    elseif k==n
        G = wwq_tensordot(T_1km1, G, 1:n-1, 1:n-1);
    else
        G = wwq_tensordot(T_1km1, G, 1:k-1, 1:k-1);
        G = wwq_tensordot(G, T_kp1n, 3:n-k+3, 2:n-k+2);
    end
end