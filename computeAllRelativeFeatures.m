%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes rescaled relational time-series features in
% dependence on sensor location (case switch)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [featuresMatr] = computeAllRelativeFeatures(oriCell,relAngCell,bodyPosCell)

    featuresMatr = cell(0,1);

    for k = 1:size(oriCell,1)
        curOri = oriCell{k,1};
        sPos = relAngCell{k,1};
        relOriA11 = oriCell{sPos(1),1};
        relOriA12 = oriCell{sPos(2),1};
        relOriA21 = oriCell{sPos(3),1};
        relOriA22 = oriCell{sPos(4),1};        
        if(~isempty(curOri))
            switch k
                case 1
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.ShoulderRight;
                    pos2 = bodyPosCell.ShoulderLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3); 
                case 2
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.KneeRight;
                    pos2 = bodyPosCell.KneeLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3); 
                case 3
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.AnkleRight;
                    pos2 = bodyPosCell.AnkleLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3); 
                case 4
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.SkiTipRight;
                    pos2 = bodyPosCell.SkiTipLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3); 
                case 5
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.KneeRight;
                    pos2 = bodyPosCell.KneeLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3); 
                case 6
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.AnkleRight;
                    pos2 = bodyPosCell.AnkleLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3);                     
                case 7
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.SkiTipRight;
                    pos2 = bodyPosCell.SkiTipLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3);                     
                case 8
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.HandRight;
                    pos2 = bodyPosCell.HandLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3);                     
                case 9
                    f1 = feature_boneAngle(relOriA11, relOriA12);
                    maxVec = max(f1);
                    minVec = min(f1);
                    f1 = (f1-minVec)/(maxVec-minVec);
                    f2 = feature_boneAngle(relOriA21, relOriA22);
                    maxVec = max(f2);
                    minVec = min(f2);
                    f2 = (f2-minVec)/(maxVec-minVec);
                    pos1 = bodyPosCell.HandRight;
                    pos2 = bodyPosCell.HandLeft;
                    f3 = feature_posRelDifferences(pos1,pos2);
                    maxVec = max(f3,[],2);
                    minVec = min(f3,[],2);
                    n = (maxVec-minVec);
                    f3(1,:) = (f3(1,:)-minVec(1))/n(1);f3(2,:) = (f3(2,:)-minVec(2))/n(2);f3(3,:) = (f3(3,:)-minVec(3))/n(3);                     
                    f4 = feature_posRelDifferencesChange(pos1,pos2);
                    maxVec = max(f4,[],2);
                    minVec = min(f4,[],2);
                    n = (maxVec-minVec);
                    f4(1,:) = (f4(1,:)-minVec(1))/n(1);f4(2,:) = (f4(2,:)-minVec(2))/n(2);f4(3,:) = (f4(3,:)-minVec(3))/n(3);                     
            end  
            featStream = [f1;f2;f3;f4];
            featuresMatr{k,1} = featStream;
        end
    end

end