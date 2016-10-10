%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function determines retrieval statistics of a classification usable
% for the computation of confusion matrices
% 
% Input: list of classifications and list of actual labels
% 
% Output: Confusion Matrix absolut and normalized
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CM1Mean, HitStat] = determineConfMatrSVM(Class1, Label1)

FList1 = find(strcmp(Class1,'F'));
NList1 = find(strcmp(Class1,'N'));
NLabelStart1 = find(strcmp(Label1,'N'),1,'first');
TruePos1 = find(FList1<NLabelStart1);
FalsePos1 = find(FList1>=NLabelStart1);
TrueNeg1 = find(NList1>=NLabelStart1);
FalseNeg1 = find(NList1<NLabelStart1);
CM1 = [length(TruePos1) length(FalsePos1); length(FalseNeg1) length(TrueNeg1)];

HitStat = CM1;

CM1Mean = CM1;
CM1Mean(1,:) = CM1(1,:)/(NLabelStart1-1);CM1Mean(2,:) = CM1(2,:)/(length(Label1)-NLabelStart1+1);

end