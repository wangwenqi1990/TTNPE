function [Ui, Plot] = TensNet_Solver(Ui,Z, para, opts)
%%  Solver
n           = length(Ui);
iter        = 0;
Last        = zeros(size(Ui{n}));
Plot        = [ObjVal(Z, Ui, n)];


while true
    for i =1 : n
        % solve Ui
        if i==1
            Tn = merge_tensor(Ui(2:end));
            A  = tens2mat(diagsum(wwq_tensordot(wwq_tensordot(Tn, Z, 2:n,  2:n), Tn, 5:n+3,2:n), 2, 6), [2,1], [3,4]);
            [Ui{i}, out] = Ui_Solver(A, size(Ui{i}), opts);
            if para.display
                val = ObjVal(Z, Ui, n);
                disp([out.msg,'    For U' num2str(i), ' the objval is ' num2str(val)]);
                Plot = [Plot,val];
            end
        elseif i==n
            T1 = merge_tensor(Ui(1:end-1));
            A  = tens2mat(wwq_tensordot(wwq_tensordot(T1, Z, 1:n-1, 1:n-1), T1, 3:n+1, 1:n-1), [1,2], [4,3]);
            [Ui{i}, out] = Un_Solver(A, size(Ui{i}), opts);
            if para.display
                val = ObjVal(Z, Ui, n);
                disp([out.msg,'    For U' num2str(i), ' the objval is ' num2str(val)]);
                Plot = [Plot,val];
            end
        else
            T1 = merge_tensor(Ui(1:i-1));
            Tn = merge_tensor(Ui(i+1:end));
            %
            %Tn_M  = diagsum(wwq_tensordot(Tn,wwq_tensordot(Z, Tn, i+1+n:2 *n, 2:n-i+1), 2:n-i+1, i+1:n ), 2, 2*i+4);
            %A     = tens2mat(wwq_tensordot(wwq_tensordot(T1, Tn_M, 1:i-1,2:i), T1, 4: i+2, 1:i-1), [1,3,2], [6,4,5]);
            %
            T1_M   = wwq_tensordot(T1, wwq_tensordot(T1, Z, 1:i-1, n+1:n+i-1), 1:i-1,2:i);
            A      = tens2mat(diagsum(wwq_tensordot(Tn,wwq_tensordot(Tn,T1_M,  2:n-i+1,n-i+5:2*n-2*i+4), 2:n-i+1,6:n-i+5), 2,4), [3,5,1], [4,6,2]);
            [Ui{i}, out] = Ui_Solver(A, size(Ui{i}), opts);
            if para.display
                val = ObjVal(Z, Ui, n);
                disp([out.msg,'    For U' num2str(i), ' the objval is ' num2str(val)]);
                Plot = [Plot,val];
            end
        end
    end

    error   = norm(T2V(Ui{n} -Last))/norm(T2V(Last));
    Last    = Ui{n};
    iter    = iter +1;
    
    if para.display
        disp(['At iteration ', num2str(iter), ' the change is ', num2str(error),...
            ' the objval is' num2str(ObjVal(Z, Ui, n))]);
        disp(' ');
    end
        
    if iter >= para.maxiter
        disp('Hit Max Iteration !');
        break;
    end

    if error <= para.error_tot
        disp('Converged !');
        break;
    end
end
end