function Result = feature_posRelDifferences(pos1,pos2)
    mat = zeros(size(pos1,1),size(pos1,2),2);
    mat(:,:,1) = pos1;
    mat(:,:,2) = pos2;
    diffX = diff(mat,[],3)';
    [posZero] = find(diffX(1,:)==0);
    if(~isempty(posZero))
        for p = 1:length(posZero)
            diffX(:,posZero(p)) = nan;
        end
    end
    Result = diffX;
end

