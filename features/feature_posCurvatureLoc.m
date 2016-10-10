function Result = feature_posCurvatureLoc(motionPos)
    slope = gradient(motionPos');
    Result = gradient(slope);
    
end

