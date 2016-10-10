function Result = feature_globOri(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    Result = quatrot(globalBoneGrowthDir,motion);

end