function Result = feature_boneInclinationDifferences(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    RotX = quatrot(globalBoneGrowthDir,motion);

    Ang = acos(RotX(2,:));
    Result = [0 diff(Ang)];

end