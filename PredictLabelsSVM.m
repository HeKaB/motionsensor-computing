%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function predicts incoming data on the base of a learned input classifier
% model
% 
% Input:
% -Trained SVM model
% -Test feature vector class 1
% -Test feature vector class 2
% 
% Output: list of classified labels and real label
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ResultLabel, RealLabel] = PredictLabelsSVM(TrainModel, InputError,InputNoError)

if(~isstruct(TrainModel))
    
    TrainMatrix = [InputError;InputNoError];
    ResultLabel = predict(TrainModel,TrainMatrix);
    
    L1 = repmat({'F'},size(InputError,1),1);
    L2 = repmat({'N'},size(InputNoError,1),1);
    RealLabel = [L1;L2];
else
    L1 = repmat({'X'},1,1);
    L2 = repmat({'X'},1,1);
    ResultLabel = [L1;L2];
    
    L1 = repmat({'F'},1,1);
    L2 = repmat({'N'},1,1);
    RealLabel = [L1;L2];
end

end