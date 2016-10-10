%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function determines precision and recall of a classification
% 
% Input: list of classifications and list of actual labels
% 
% Output: precision and recall
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PR1 = determinePrecRecallSVM(Class1, Label1)

FList1 = find(strcmp(Class1,'F'));
NLabelStart1 = find(strcmp(Label1,'N'),1,'first');
TruePos1 = find(FList1<NLabelStart1);
PR1 = [length(TruePos1)/length(FList1) length(TruePos1)/(NLabelStart1-1)];

end