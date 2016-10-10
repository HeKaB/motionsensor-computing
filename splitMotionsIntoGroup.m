%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function splits a set of data captures into two groups according to
% a list of ground truth data
% 
% Input:
% - Cell of all data captures
% - Ground truth annotations group 1
% - Ground truth annotations group 2
% 
% Output: two cells for the two group types containing only the data
% captures of respective group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [resultFault,resultNoFault] = splitMotionsIntoGroup(fileDataAll,arayFaultVals,arrayNoFaultVals)

resultFault = cell(0,1);
resultNoFault = cell(0,1);
for h = 1:length(arayFaultVals)
    resultFault{h,1} = fileDataAll{arayFaultVals(h)};
end

for h = 1:length(arrayNoFaultVals)
    resultNoFault{h,1} = fileDataAll{arrayNoFaultVals(h)};    
end

end