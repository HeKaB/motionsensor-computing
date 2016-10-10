function Result = feature_boneYawDifferences(motion)

    globalBoneGrowthDir = repmat([0;1;0],1,size(motion,2));
    RotX = quatrot(globalBoneGrowthDir,motion);

    Ang = atan2(RotX(1,:),RotX(2,:));
    Result = [0 diff(Ang)];
    
end