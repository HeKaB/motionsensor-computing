function Result = feature_globalGyroRate(motion,MotionGyr)
    Result = quatrot(MotionGyr,motion);
end