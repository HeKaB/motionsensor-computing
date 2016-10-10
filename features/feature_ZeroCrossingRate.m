function Result = feature_ZeroCrossingRate(InputData)

    Result = sum(abs(diff(InputData>0,[],2)),2)/size(InputData,2);
    Result = Result';

end