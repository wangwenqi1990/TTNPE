function App = main_App(train_data, train_label, ...
    test_data,test_label, tensor_shape, tau, Graph, para_App,KNN)
    % train_data  & test_data:  (I1*...*In) * N matrix
    % train_label & test_label: 1 * N
    
    % unitary solver parameter
    opts.record = 0;        
    opts.mxitr  = 1000;
    opts.gtol   = 1e-5;
    opts.xtol   = 1e-5;
    opts.ftol   = 1e-8;
    opts.tau    = 1e-3;
    
    % read parameter
    n   = length(tensor_shape);     % tensor data order
    N   = size(train_data, 2);      % train data size
    
    TTNPE_start = cputime;
    % Initialize Ui
    Ui = U2Ui_tau(reshape(train_data, [tensor_shape, N]), tau); % U1, ....,Un, A 
    Ui = Ui(1:n);                                               % U1,..., Un
    % Construct Graph S
    S = constuct_S(train_data, train_label, Graph.K, Graph.epsilon);    
    % Construct Y, and thus Z 
    Y = train_data * ( eye(size(train_data, 2)) - S');
    Z = reshape(Y * Y', [tensor_shape, tensor_shape]);
    [App.Ui, ~] = Apro_Solver(Ui, Z, para_App, opts); 
    disp(['The objval is ', num2str(ObjVal(Z, App.Ui, n)), ' by Approximation']);
    Subspace_App         = tens2mat(merge_tensor(App.Ui),1:n, n+1);
    App.time_subspace    = cputime- TTNPE_start;    % time to find subspace
    
    TTNPE_start = cputime;
    train_proj          = Subspace_App' * train_data;
    test_proj           = Subspace_App' * test_data;
    App.time_embedding = cputime- TTNPE_start;   % time to embed data
    
    TTNPE_start = cputime;
    [App.PreLabel, App.PreErr] = Classfier_KNN(train_proj, train_label, test_proj, test_label, KNN.K);
    App.time_classify = cputime- TTNPE_start;   % time to classify data
    
    App.Storage  = Dim_TT(App.Ui) + size(App.Ui{end},3) * size(train_data, 2);
end