function Result = feature_boneAngle(motion1, motion2)

    globalBoneGrowthDirM1 = repmat([0;1;0],1,size(motion1,2));
    RotM1 = quatrot(globalBoneGrowthDirM1,motion1);

    globalBoneGrowthDirM2 = repmat([0;1;0],1,size(motion2,2));
    RotM2X = quatrot(globalBoneGrowthDirM2,motion2);

    Result = acos(dot(RotM1,RotM2X));

end