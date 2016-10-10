%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function transforms the previously determined cell of continuous
% features into one matrix of features
% 
% Input: cells of continuous features
% 
% Output: continuous feature matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ResFeature] = listContFeaturesMatrix(FeatData1,FeatData2,FeatData3)

ResFeature = cell(0,1);

numSens = size(FeatData1{1,1},1);
numFiles = size(FeatData1,1);

for hij = 1:numFiles
    sensMat = cell(0,1);
    for m = 1:numSens
        curFeat1 = FeatData1{hij,1}{m,1};
        curFeat2 = FeatData2{hij,1}{m,1};
        curFeat3 = FeatData3{hij,1}{m,1};
        [r,c] = find(isnan(curFeat3));
        if(~isempty(r))
            curFeat3(r,c) = 0;
        end
        hTest =  [curFeat1' curFeat2' curFeat3'];
        sensMat{m,1} = hTest;
    end   
    ResFeature{hij,1} = sensMat;
end

end