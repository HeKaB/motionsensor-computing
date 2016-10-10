function Result = feature_boneRoll(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    RotX = quatrot(globalBoneGrowthDir,motion);

    Result = asin(RotX(1,:));

end