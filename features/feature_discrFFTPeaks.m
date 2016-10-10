function Result = feature_discrFFTPeaks(InputData)

    Result = zeros(3,6);
    
    fftDataComplex = fft(InputData,[],2);
    fftData = real(fftDataComplex);
    [Val1,Indx1] = findpeaks(fftData(1,:),'MinPeakProminence',3);
    [Val2,Indx2] = findpeaks(fftData(2,:),'MinPeakProminence',3);
    [Val3,Indx3] = findpeaks(fftData(3,:),'MinPeakProminence',3);

    if(length(Val1)>=3)
        Result(1,1:2:end) = Val1(1:3);
        Result(1,2:2:end) = Indx1(1:3);
    else
        Result(1,1:end) = nan;
    end  
    if(length(Val2)>=3)
        Result(2,1:2:end) = Val2(1:3);
        Result(2,2:2:end) = Indx2(1:3);
    else
        Result(2,1:end) = nan;
    end
    if(length(Val3)>=3)
        Result(3,1:2:end) = Val3(1:3);
        Result(3,2:2:end) = Indx3(1:3);
    else
        Result(3,1:end) = nan;
    end

    Result(:,1:2:end) = Result(:,1:2:end)/norm(Result(:,1));
end