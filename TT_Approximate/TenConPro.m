function Result = TenConPro(Ui)
    % Input: Ui{j} r_j-1 * Ij * rj, j=1:1:n as input
    % Return:   A 3-order tensor: r_0 * (I1 *...* In) * rn
    n = length(Ui);
    
    if n==1
        Result = Ui{1};
        return 
    end
    
    I = nan(1, n);
    
    r1 = size(Ui{1}, 1);
    rn = size(Ui{n}, 3);
    
    U1 = tens2mat(Ui{1}, [1,2],3);
    I(1) = size(Ui{1}, 2);
    
    U2 = tens2mat(Ui{2}, [1,2],3);
    I(2) = size(Ui{2},2);
    
    if n==2
        Result = reshape(kron(eye(I(n)), U1) * U2, [r1, prod(I), rn]);
        return
    end
    
    for i=1:n-2
        U1 = kron(eye(I(i+1)), U1) * U2;
        U2 = tens2mat(Ui{i+2}, [1,2],3);
        I(i+2) = size(Ui{i+2},2);
    end
    
    Result = reshape(kron(eye(I(n)), U1) * U2, [r1, prod(I), rn]);
end