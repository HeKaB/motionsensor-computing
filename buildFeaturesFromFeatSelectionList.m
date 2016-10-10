%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function builds a set of features from a list of selected features
% 
% Input:
% -Cell containing features
% -List of features to be selected 
% 
% Output:
% Matrix containing selected features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ResFeatureMatr] = buildFeaturesFromFeatSelectionList(InputFeatureCell,FeatureSelectionInfo)

ResFeatureCell = cell(0,1);
for nCell = 1:length(InputFeatureCell)
    selFeatCell = cell(0,1);
    curFile = InputFeatureCell{nCell,1};
    for s = 1:size(curFile,1)
        curSens = curFile{s,1};
        featList = FeatureSelectionInfo{s,1};
        if(~isempty(featList))
            if(size(curSens,1)==1)
                resSelFeats = (curSens(featList)');
            else
                resSelFeats = (curSens(:,featList)');
            end
            if(isempty(resSelFeats))
                resSelFeats = nan;
            end
            selFeatCell{s,1} = resSelFeats;
        else
            selFeatCell{s,1} = [];
        end
    end
    selFeatCell = cell2mat(selFeatCell);
    ResFeatureCell{nCell,1} = selFeatCell';
end

ResFeatureMatr = cell2mat(ResFeatureCell);

end