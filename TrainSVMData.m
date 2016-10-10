%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function trains a SVM on the base of an input list of features
% 
% Input:
% -Feature vector class 1
% -Feature vector class 2
% 
% Output: trained SVM model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ResultModel = TrainSVMData(InputError,InputNoError)

if(~isempty(InputError))
    TrainMatrix = [InputError;InputNoError];

    L1 = repmat({'F'},size(InputError,1),1);
    L2 = repmat({'N'},size(InputNoError,1),1);
    Label = [L1;L2];
    
    rng(1); % for reproducibility
    ResultModel = fitcsvm(TrainMatrix,Label,'KernelFunction','rbf','KernelScale','auto','Standardize','on','BoxConstraint',10,'OutlierFraction',0.05);
else
    L1 = repmat({'X'},1,1);
    L2 = repmat({'X'},1,1);
    Label = [L1;L2];
    ResultModel = struct('Labels',Label);
end


end