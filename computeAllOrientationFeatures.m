%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes rescaled angular time-series features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [featuresMatr] = computeAllOrientationFeatures(oriCell,displCell)

    featuresMatr = cell(0,1);

    for k = 1:size(oriCell,1)
        curOri = oriCell{k,1};
        displ = displCell{k,1};
        if(~isempty(curOri))
            f1 = feature_boneRoll(curOri);
            maxVec = max(f1);
            minVec = min(f1);
            f1 = (f1-minVec)/(maxVec-minVec);
            f2 = feature_boneInclination(curOri);
            maxVec = max(f2);
            minVec = min(f2);
            f2 = (f2-minVec)/(maxVec-minVec);
            f3 = feature_boneYaw(curOri);
            maxVec = max(f3);
            minVec = min(f3);
            f3 = (f3-minVec)/(maxVec-minVec);
%             if(~isempty(displ))
%                 f4 = feature_boneRollPitchIMU(curOri,displ);
%             else
%                 displ = [1 0 0 0];
%                 f4 = feature_boneRollPitchIMU(curOri,displ);
%             end
            f5 = feature_boneInclinationDifferences(curOri);
            maxVec = max(f5);
            minVec = min(f5);
            f5 = (f5-minVec)/(maxVec-minVec);
            f6 = feature_boneRollDifferences(curOri); 
            maxVec = max(f6);
            minVec = min(f6);
            f6 = (f6-minVec)/(maxVec-minVec);
            f7 = feature_boneYawDifferences(curOri);
            maxVec = max(f7);
            minVec = min(f7);
            f7 = (f7-minVec)/(maxVec-minVec);

            featStream = [f1;f2;f3;f5;f6;f7];
            featuresMatr{k,1} = featStream;
        end
    end

end