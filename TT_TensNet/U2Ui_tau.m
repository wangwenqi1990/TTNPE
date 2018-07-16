function Ui = U2Ui_tau(U, tau)
    % U: I1 * ...* In
    % tau: scaler

    n   = size(U);
    dim = size(n,2);
    Ui = cell(dim, 1);
    r = nan(dim-1, 1);
    
    % Initialize B
    B =[];
    for i = 1:1:n(1)
        B = [B T2V(U(i,:,:,:))];
    end
    B = B';
    
    % svd for the initialized B
    [u, s, v] = svd(B,'econ');
      
    % Process svd result
    r(1) = max(size(find(diag(s) >= tau * max(diag(s)))));
    if r(1)==1
        r(1)=2;
    end
    
    u = u(:, 1:r(1));
    s = s(1: r(1), 1:r(1));
    v = v(:, 1:r(1));
    v = s * v';
    
    % store output result
    % Ui{1} = u;
    Ui{1} = reshape(u, [1, size(u)]);
    
    % main loop
    for i =2 : 1 : dim-1
        B = reshape(v, [r(i-1)*n(i), prod(n(i+1:end))]);
        [u,s,v] = svd(B, 'econ');
        
        % Process svd result
        r(i) = max(size(find(diag(s) >= tau * max(diag(s)))));
        if (r(i)==1)
            r(i)=2;
        end
        u = u(:, 1:r(i));
        
        Ui{i} = reshape(u, [r(i-1), n(i), r(i)]);
        s = s(1: r(i), 1:r(i));
        v = v(:, 1:r(i));
        v = s * v';
    end
    Ui{i+1} = v;
end