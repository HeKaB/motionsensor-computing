function Result = feature_boneRollDifferences(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    RotX = quatrot(globalBoneGrowthDir,motion);

    Ang = asin(RotX(1,:));
    Result = [0 diff(Ang)];

end