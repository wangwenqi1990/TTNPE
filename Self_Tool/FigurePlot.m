function FigurePlot(tau_list, classsize_list, repeats, noise, Dataset, K_list, K,tensor_shape)
%% Path Setup
addpath 'tensorlab'     % Tens2mat
addpath 'FOptM-share'   % Convex under unitary constraint
addpath 'mdmp'          % Tensor Trace
addpath 'TT_TensNet'    % Merge the proposed networks
addpath 'TT_Approximate'% Approximation Algorithm
addpath 'TNPE'          % TNPE algorithm package
addpath 'Self_Tool'     % manifold dimensional and KNN clasifier

%% Algo(App, TN, TNPE, KNN) * tau * classsize * iter;
tot_iter = repeats;
ResErr = nan(4, length(tau_list),length(classsize_list), tot_iter); 
ResStor= nan(4, length(tau_list),length(classsize_list), tot_iter);
ResTime_subspace   = nan(4, length(tau_list),length(classsize_list), tot_iter);
ResTime_embedding  = nan(4, length(tau_list),length(classsize_list), tot_iter);
ResTime_classify   = nan(4, length(tau_list),length(classsize_list), tot_iter);

for ifile = 1
    disp(['ifile ' num2str(ifile) ]);
    path = ['Result_' Dataset];
    K_idx = find(K_list == K);  % K neighbors for classification
    cd(path);
    for iTau = 1: length(tau_list)
        %disp(['iTau ' num2str(iTau) ]);
        for iClass = 1: length(classsize_list)
            %disp(['iClass ' num2str(iClass) ]);
            for iIter = 1:repeats
                filename= ['Result_noise' num2str(noise), ...
                    '_repeat' num2str(iIter),...
                    '_tau' num2str(tau_list(iTau)),'_classsize',...
                    num2str(classsize_list(iClass)) '.mat'];
                load(filename);
                ResErr( 1,iTau,iClass,iIter+(ifile-1) * repeats)            = App.PreErr(K_idx);
                ResStor(1,iTau,iClass,iIter+(ifile-1) * repeats)            = App.Storage/KNNS.Storage;
                ResTime_subspace(1,iTau,iClass,iIter+(ifile-1) * repeats)   = App.time_subspace;
                ResTime_embedding(1,iTau,iClass,iIter+(ifile-1) * repeats)  = App.time_embedding;
                ResTime_classify(1,iTau,iClass,iIter+(ifile-1) * repeats)   = App.time_classify;
                
                
                %ResErr(2,iTau,iClass,iIter+(ifile-1) * repeats) = TN.PreErr(K_idx);
                %ResStor(2,iTau,iClass,iIter+(ifile-1) * repeats)= App.Storage(K_idx)/KNNS.Storage(K_idx);
                
                ResErr(3,iTau,iClass,iIter+(ifile-1) * repeats) = TNPE.PreErr(K_idx);
                ResStor(3,iTau,iClass,iIter+(ifile-1) * repeats)= TNPE.Storage/KNNS.Storage;
                ResTime_subspace(3,iTau,iClass,iIter+(ifile-1) * repeats)   = TNPE.time_subspace;
                ResTime_embedding(3,iTau,iClass,iIter+(ifile-1) * repeats)  = TNPE.time_embedding;
                ResTime_classify(3,iTau,iClass,iIter+(ifile-1) * repeats)   = TNPE.time_classify;
                
                ResErr(4,iTau,iClass,iIter+(ifile-1) * repeats) = KNNS.PreErr(K_idx);
                ResStor(4,iTau,iClass,iIter+(ifile-1) * repeats)= 1;
                ResTime_classify(4,iTau,iClass,iIter+(ifile-1) * repeats) = KNNS.time_classify;
            end
        end
    end
    cd ..;
end

%%
ResErr = permute(mean(permute(ResErr, [4,1,2,3])), [2,3,4,1]);
ResStor= permute(mean(permute(ResStor,[4,1,2,3])), [2,3,4,1]);
ResTime_subspace= permute(mean(permute(ResTime_subspace,[4,1,2,3])), [2,3,4,1]);
ResTime_embedding= permute(mean(permute(ResTime_embedding,[4,1,2,3])), [2,3,4,1]);
ResTime_classify= permute(mean(permute(ResTime_classify,[4,1,2,3])), [2,3,4,1]);
%
name_shape='';
for i=1:length(tensor_shape)
    name_shape=strcat(name_shape, int2str(tensor_shape(i)));
end

name_path=strcat('Res_',Dataset);
if ~exist(name_path)
    mkdir(name_path);
end

%% classify Time
for iClass = 1
    %close all;
    figure()
    hold on;
    ResStor(ResStor>1)=1;
    j=1;plot(ResStor(j,:,iClass), ResTime_classify(j,:,iClass), 'r-*','linewidth', 3); 
    j=3;plot(ResStor(j,:,iClass), ResTime_classify(j,:,iClass), 'b-*','linewidth', 3); 
    %j=3;plot(ResStor(j,[1:5,9:end],iClass), ResTime_classify(j,[1:5,9:end],iClass), 'b-*','linewidth', 3); 
    scatter(1, mean(ResTime_classify(4,:, iClass)), 'k*');
    legend(['TTNPE-ATN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')'],['KNN(K=' num2str(K) ')']);
    fig=gcf;
    set(findall(fig,'-property','FontSize'),'FontSize',28)
    set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
    %axis([0 1 0 80]);
    xlabel('Compression Ratio');
    ylabel('Classification Time(s)');
    hold off;
    saveas(gcf, [name_path, '/TimeClassify_' Dataset, ...
        '_noise' num2str(noise), ...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),... 
        '_shape',name_shape,...
        '.pdf']);
end

%% subspace Time
for iClass = 1
    %close all;
    figure()
    hold on;
    ResStor(ResStor>1)=1;
    j=1;plot(ResStor(j,:,iClass), ResTime_subspace(j,:,iClass), 'r-*','linewidth', 3); 
    j=3;plot(ResStor(j,:,iClass), ResTime_subspace(j,:,iClass), 'b-*','linewidth', 3); 
    legend(['TTNPE-ATN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')']);
    fig=gcf;
    set(findall(fig,'-property','FontSize'),'FontSize',28)
    set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
    %axis([0 1 0 2000]);
    xlabel('Compression Ratio');
    ylabel('Subspace Time(s)');
    hold off;
    saveas(gcf, [name_path, '/TimeSubspace_' Dataset,...
        '_noise' num2str(noise), ...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.pdf']);
end

%% embedding Time
for iClass = 1
    %close all;
    figure()
    hold on;
    j=1;plot(ResStor(j,:,iClass), ResTime_embedding(j,:,iClass), 'r-*','linewidth', 3); 
    j=3;plot(ResStor(j,:,iClass), smooth(ResTime_embedding(j,:,iClass)), 'b-*','linewidth', 3); 
    legend(['TTNPE-ATN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')']);
    fig=gcf;
    set(findall(fig,'-property','FontSize'),'FontSize',28)
    set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
    axis([0 1 0 2]);
    xlabel('Compression Ratio');
    ylabel('Embedding Time(s)');
    hold off;
    saveas(gcf, [name_path,'/TimeEmbedding_' Dataset,...
        '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.pdf']);
end

%% tau Effect
% iClass is a list that measures the number of data from each class  
for iClass = 1
    %close all;
    figure()
    hold on;
    j=1;[~, idx]=sort(ResStor(j,:,iClass));plot(ResStor(j,idx,iClass), smooth(log10(ResErr(j,idx,iClass)) ), 'r-*','linewidth', 3); 
    j=3;[~, idx]=sort(ResStor(j,:,iClass));plot(ResStor(j,idx,iClass), log10(ResErr(j,idx,iClass)), 'b-*','linewidth', 3); 
    %scatter(1, log10(mean(ResErr(4,:, iClass))), 'k*');
    scatter(1, log10(ResErr(4,end, iClass)), 'k*')
    legend(['TTNPE-ATN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')'],['KNN(K=' num2str(K) ')']);
    fig=gcf;
    set(findall(fig,'-property','FontSize'),'FontSize',28)
    set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
    %axis([0 1 -1 0]);
    xlabel('Compression Ratio');
    ylabel('Classification Error(log10)');
    hold off;
    saveas(gcf, [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.pdf']);
end
%%
close all;
tpname = [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.mat'];
save(tpname);

%% DataSize Effect
%{
for itau = 1: length(tau_list)
    close all;
    figure(2);
    hold on;
    for j=[1,3,4]
        plot(classsize_list, T2V(ResErr(j,itau,:)), '-', 'linewidth', 3);
    end
    legend('ATN-NPE','TNPE','KNN');
    fig=gcf;
    set(findall(fig,'-property','FontSize'),'FontSize',28)
    set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
    axis([min(classsize_list) max(classsize_list) 0 0.6]);
    xlabel('Training Sample Size');
    ylabel('Classification Error');
    hold off;
    saveas(gcf, ['Weizmann', '_K', num2str(K_idx), '_tau', num2str(tau_list(itau)),  '.pdf']);
end
%}
end





    