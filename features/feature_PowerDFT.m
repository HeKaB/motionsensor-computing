function Result = feature_PowerDFT(InputData)

    Result = zeros(1,3);
    n = pow2(nextpow2(size(InputData,2)));
    y = fft(InputData,n,2); 
    Result(1) = y(1).*conj(y(1))/n; 
    Result(2) = y(2).*conj(y(2))/n;
    Result(3) = y(3).*conj(y(3))/n;

end