function Result = feature_MeanCrossingRate(InputData)

    meanVal = mean(InputData,2);
    Result = zeros(1,3);
    Result(1) = sum(abs(diff(InputData(1,:)>meanVal(1))))/size(InputData,2);
    Result(2) = sum(abs(diff(InputData(2,:)>meanVal(2))))/size(InputData,2);
    Result(3) = sum(abs(diff(InputData(3,:)>meanVal(3))))/size(InputData,2);

end