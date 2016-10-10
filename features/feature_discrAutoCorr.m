function Result = feature_discrAutoCorr(InputData)
    
    Result = zeros(3,10);
    V1 = autocorr(InputData(1,:));
    V2 = autocorr(InputData(2,:));
    V3 = autocorr(InputData(3,:));
    
    V = [V1(2:11);V2(2:11);V3(2:11)];
    V = V*2-1;
    Result(:,:) = V;

end