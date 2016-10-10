function Result = feature_globalMagnData(motion,MotionMag)
    Result = quatrot(MotionMag,motion);
end