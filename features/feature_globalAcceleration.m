function Result = feature_globalAcceleration(motion,MotionAcc)
    a_glob = quatrot(MotionAcc,motion);
    Result = a_glob - repmat([0;0;-1],1,size(MotionAcc,2));
end