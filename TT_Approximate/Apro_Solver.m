function [Ui, Plot] = Apro_Solver(Ui, Z, para, opts)
    
    n = length(Ui);
    rn= size(Ui{n}, 3);
    Plot=[ObjVal(Z, Ui, n)];
    
    % eigen vectors
    [V, ~] = eig(tens2mat(Z, 1:n, n+1:2*n));                    % V is eigenvectors
    Vrn = V(:, 1: rn);                                          % rn are rn smallest eigen vectors
    
    I = [];
    r = [1];
    for i = 1:n
        r = [r, size(Ui{i}, 3)];
        I = [I, size(Ui{i}, 2)];
    end
     
    %% Approximation
    %% Update Ui to minimize || L(U1,..., Un) - Vrn ||_F^2
    Err = 1;    iter=0;
    Last = zeros(size(Ui{n}));
    while(iter <= para.maxiter && abs(Err) >= para.error_tot)
        %% When i = 1;
        i =1;
        Tr   = TenConPro(Ui(2:n));
        V    = reshape(Vrn, [prod(I(1:i)), prod(I(i+1:n)) * rn]);
        RTr  = R(Tr);
        [LY, ~]   = LSQ_Unitary_L( RTr, V, opts);
        Ui{1}= L_inv(LY, r(i), I(i), r(i+1));
        
        Plot = [Plot, ObjVal(Z, Ui, n)];
        %disp(['The objval is', num2str(ObjVal(Z, Ui, n)) ' at step ' num2str(i)]);

        %% When i=2:n-1;
        for i = 2: n-1
            Tl   = TenConPro(Ui(1:i-1));
            Tr   = TenConPro(Ui(i+1:n));
            C    = reshape(Vrn, [prod(I(1:i)), prod(I(i+1:n)) * rn]);
            B    = R(Tr);
            A    = kron(eye(I(i)), L(Tl));            
            x    = eye(r(i) * I(i), r(i+1));
            [LUk, ~]= OptStiefelGBB(x, @AXBC, opts, A, B, C);       
            Ui{i}= L_inv(LUk, r(i), I(i), r(i+1));
            
            Plot = [Plot, ObjVal(Z, Ui, n)];
            %disp(['The objval is', num2str(ObjVal(Z, Ui, n)) ' at step ' num2str(i)]);
        end
   
        %% When i =n;
        i=n;
        Tl   = TenConPro(Ui(1:i-1));
        LTl  = L(Tl);
        ILTl = kron(eye(I(i)), LTl);
        V    = reshape(Vrn, [prod(I(1:n)), rn]);
        [RUk, ~]  = LSQ_Unitary_R( ILTl, V, opts);
        Ui{i}= L_inv(RUk, r(i), I(i), r(i+1));
        
        Plot = [Plot, ObjVal(Z, Ui, n)];
        %disp(['The objval is', num2str(ObjVal(Z, Ui, n)) ' at step ' num2str(i)]);
      
        %% update
        Err = norm(T2V(Ui{n} -Last))/norm(T2V(Last));
        Last    = Ui{n};
        if para.display==1
            disp(['At step  ', num2str(iter),' ,  the change is ' num2str(Err),...
                '   The difference from eigenVec is ' num2str(norm(T2V(TenConPro(Ui))-T2V(Vrn))) ...
                '. The objval is', num2str(ObjVal(Z, Ui, n))]);
        end 
        iter = iter+1;
    end 
end