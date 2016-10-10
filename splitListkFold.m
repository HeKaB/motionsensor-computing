%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function splits input data into a training and testing part for
% machine learning under a k-fold split principle.
% This function can be used when input ground truth data (e.g. judging scores)
% serve as input for the machine learning and a k-fold split cannot be
% randomized otherwise.
% 
% Input: List of Input Ground Truth Information, number of k-fold split
%
% Output: two cells containing a list of take numbers used for testing and training
% per every k-fold
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [List1, List2] = splitListkFold(InputList, kFoldN)

List1 = cell(0,1);
List2 = cell(0,1);

lList = length(InputList);
randList = randperm(lList,lList);
linList = 1:lList;
nTakes = lList/kFoldN;

PartitionsDouble=(1:nTakes:lList+1);
Partitions = floor(PartitionsDouble);

for k = 1:kFoldN
    currRandL = randList(Partitions(k):Partitions(k+1)-1);
    teList = sort(currRandL);
    trList = ~ismember(linList,teList);
    [~,trList] = find(trList);

    List1{k,1} = InputList(trList);
    List2{k,1} = InputList(teList);
end

end