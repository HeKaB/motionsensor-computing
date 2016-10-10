%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function transforms the previously determined cell of discrete
% features into one vector of features
% 
% Input: cell of discrete features
% 
% Output: vector of discrete features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ResFeature] = listDiscrFeaturesMatrix(FeatData)

ResFeature = cell(0,1);

for hij = 1:size(FeatData,1)
    sensCell = cell(0,1);
    for m = 1:size(FeatData{1,1},1)
curFeat1 = FeatData{hij,1}{m,1};
        list1 = reshape(curFeat1',1,size(curFeat1,1)*size(curFeat1,2));
        curFeat2 = FeatData{hij,1}{m,2};
        list2 = mean(curFeat2,2)';
        list2 = list2/norm(list2);
        curFeat3 = FeatData{hij,1}{m,3};
        list3 = reshape(curFeat3',1,size(curFeat3,1)*size(curFeat3,2));
        curFeat4 = FeatData{hij,1}{m,4};
        list4 = mean(curFeat4,2)';
        list4 = list4/norm(list4);

        list = [list1 list2 list3 list4];
        [a] = find(isnan(list));
        if(~isempty(a))
            list(a) = 0;
        end
        
        sensCell{m,1} = list;
    end
    ResFeature{hij,1} = sensCell;
end

end