%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes rescaled raw signal time-series features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [featuresMatr] = computeAllRawFeatures(oriCell,AccCell,GyrCell,displCell)

    featuresMatr = cell(0,1);

    for k = 1:size(oriCell,1)
        curOri = oriCell{k,1};
        curAcc = AccCell{k,1};
        curGyr = GyrCell{k,1};
        displ = displCell{k,1};
        if(~isempty(curOri))
%             f1 = feature_absAcceleration(curAcc)/5;
%             f2 = feature_absGyroRate(curGyr)/1500;
%             f3 = feature_absMagnData(curMag);
            f4 = feature_globalAcceleration(curOri,curAcc);
            maxVec = max(f4,[],2);
            minVec = min(f4,[],2);
            n = (maxVec-minVec);
            f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3);            
            f5 = feature_globalGyroRate(curOri,curGyr);
            maxVec = max(f5,[],2);
            minVec = min(f5,[],2);
            n = (maxVec-minVec);
            f5(1,:) = (f5(1,:)-minVec(1))/n(1);f5(2,:) = (f5(2,:)-minVec(2))/n(2);f5(3,:) = (f5(3,:)-minVec(3))/n(3);            
            featStream = [f4;f5];
            featuresMatr{k,1} = featStream;
        end
    end

end