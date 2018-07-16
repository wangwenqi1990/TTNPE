%This is the demo-code for paper 'Tensor Train Neighborhood Preserving
%Embedding' Fig.3 and Fig.6%
%% addpath the the package to be used
clear all; close all; clc;
addpath 'tensorlab'     % package for Tens2mat
addpath 'FOptM-share'   % package for Convex under unitary constraint
addpath 'mdmp'          % Tensor Trace
addpath 'TT_TensNet'    % Merge the proposed networks
addpath 'TT_Approximate'% Approximation Algorithm
addpath 'TNPE'          % TNPE algorithm package
addpath 'Self_Tool'     % manifold dimensional and KNN clasifier
addpath 'Data_file'

%% parameter setup
Dataset         = 'Weizmann'; % dataset to be tested
noise           = 0; % noised to the input data           
repeats         = 10;% the amount of iteration to get the average results
pathname        = ['Result_', Dataset];% the folder to save the results

%% data and path processing
[images, labels,K_list,tau_list,tensor_shape,classsize_list,class] = load_data(Dataset);
if ~exist(pathname)
    mkdir(pathname);% build the result folder for the testing
end

%% Runing results
for repeatId = 1: repeats % each repeat
    for tauId = 1: length(tau_list) % each thresholding tau
        for classsizeId = 1: length(classsize_list) % each training size
            %display information
            showinfo = ['At ' num2str(repeatId) ' iterations, '...
                    'tau ' num2str(tauId/length(tau_list))...
                    ', classsize ' num2str(classsizeId/length(classsize_list))];
            display(['********** ' showinfo ' *************' ]);
            
            % tunable parameter setup
            tau         = tau_list(tauId);
            class_size  = classsize_list(classsizeId);
            [train_data, train_label, test_data, test_label] =get_data(Dataset, images, labels, class,class_size,noise);% get train/test data
            
            % graph parameter
            Graph.K             = class * class_size-1 ;
            Graph.epsilon       = 1;
            % TT-Network solver parameter
            para_TN.maxiter     = 20;
            para_TN.error_tot   = 10 ^ -2;
            para_TN.display     = 1;    
            % App solver parameter
            para_App.maxiter    = 200;
            para_App.error_tot  = 10 ^ -2;
            para_App.display    = 1;
            % TNPE
            para_TNPE.Tmax      = 50;
            para_TNPE.toler     = 10 ^-2;
            para_TNPE.show      = 1;
            % KNN classifier parameter
            KNN.K               = K_list;
            
            % Algo1:    Approximate TTNPE embedding solver
            App = main_App(train_data, train_label, test_data,...
                test_label, tensor_shape, tau, Graph, para_App,KNN);
            % Algo2:    TNPE
            TNPE = main_TNPE(train_data, train_label, test_data,...
                test_label, tensor_shape, tau, Graph, para_TNPE,KNN);
            TN = 'Not used';
            % Algo3:    KNN directly solver
            KNN_start = cputime;
            [KNNS.PreLabel, KNNS.PreErr]  = Classfier_KNN(train_data, ...
                train_label, test_data, test_label, KNN.K);
            KNNS.time_classify = cputime - KNN_start;
            KNNS.Storage = numel(train_data);
            
            % save file
            filename = [pathname '/Result' ...
                '_noise' num2str(noise), ...
                '_repeat' num2str(repeatId),...
                '_tau' num2str(tau_list(tauId)),...
                '_classsize' num2str(classsize_list(classsizeId)) '.mat'];
            save(filename, 'App', 'TN','TNPE','KNNS');
        end
    end
end

%% plot results
FigurePlot(tau_list, classsize_list, repeats, noise, Dataset, K_list, K_list(1), tensor_shape);
            
            
            
            
            
            