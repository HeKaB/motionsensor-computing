%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes rescaled positional time-series features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [featuresMatr] = computeAllPositionFeatures(posCell)

    featuresMatr = cell(0,1);

    for k = 1:size(posCell,1)
        curPos = posCell{k,1};
        if(~isempty(curPos))
            f0 = feature_posAbsLoc(curPos);
            maxVec = max(f0,[],2);
            minVec = min(f0,[],2);
            n = (maxVec-minVec);
            f0(1,:) = (f0(1,:)-minVec(1))/n(1);f0(2,:) = (f0(2,:)-minVec(2))/n(2);f0(3,:) = (f0(3,:)-minVec(3))/n(3);
            f2 = feature_posSlopeLoc(curPos);
            maxVec = max(f2,[],2);
            minVec = min(f2,[],2);
            n = (maxVec-minVec);
            f2(1,:) = (f2(1,:)-minVec(1))/n(1);f2(2,:) = (f2(2,:)-minVec(2))/n(2);f2(3,:) = (f2(3,:)-minVec(3))/n(3);                      
            f3 = feature_posCurvatureLoc(curPos);
            maxVec = max(f3,[],2);
            minVec = min(f3,[],2);
            n = (maxVec-minVec);
            f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);
           
            featStream = [f0;f2;f3];
            featuresMatr{k,1} = featStream;
        end
    end

end