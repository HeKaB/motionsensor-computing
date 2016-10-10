function Result = feature_boneYaw(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    RotX = quatrot(globalBoneGrowthDir,motion);

    Result = atan2(RotX(1,:),RotX(2,:));

end