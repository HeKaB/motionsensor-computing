function Result = feature_posDifferences(motionPos)
    diffX = diff(motionPos*1000);
    [posZero] = find(diffX(:,1)==0);
    if(~isempty(posZero))
        for p = 1:length(posZero)
            diffX(posZero(p),:) = nan;
        end
    end
    Result = [[0 0 0]' diffX'];
end

