function Result = feature_boneInclination(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    RotX = quatrot(globalBoneGrowthDir,motion);

    Result = acos(RotX(2,:));

end