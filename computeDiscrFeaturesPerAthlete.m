%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the basic function for computing normalized discrete features
% from the sensor input data. You can freely add or remove features.
% Methods for feature computation are stored within the features folders
% 
% Input: raw and processed sensor data
% -Accelerometer measurements
% -Gyroscopes
% -Magnetometer measurements
% -Sensor/segment orientation estimates
% -Joint position files
% 
% Output: discrete feature cell array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [discrFeatures] = computeDiscrFeaturesPerAthlete(AccFiles,GyroFiles,MagFiles, OriFiles, PosFiles)

    discrFeatures = cell(0,4);

    for k = 1:size(AccFiles,1)
        curAcc = AccFiles{k,1};
        curGyr = GyroFiles{k,1};
        curMag = MagFiles{k,1};
        curOri = OriFiles{k,1};
        [z,y,x] = quat2angle(curOri');
        curAng = [x';y';z'];
        curPos = PosFiles{k,1}';
        if(~isempty(curAcc))    
            % mean
            f1 = feature_discrMean(curAcc);
            f1 = f1/norm(f1);
            f2 = feature_discrMean(curGyr);
            f2 = f2/norm(f2);
            f3 = feature_discrMean(curMag);
            f3 = f3/norm(f3);
            % variance
            f4 = feature_discrVariance(curAcc);
            f4 = f4/norm(f4);
            f5 = feature_discrVariance(curGyr);
            f5 = f5/norm(f5);
            f6 = feature_discrVariance(curMag);
            f6 = f6/norm(f6);
            % skewness
            f7 = feature_discrSkewness(curAcc);
            f7 = f7/norm(f7);
            f8 = feature_discrSkewness(curGyr);
            f8 = f8/norm(f8);
            f9 = feature_discrSkewness(curMag);
            f9 = f9/norm(f9);
            % kurtosis
            f10 = feature_discrKurtosis(curAcc);
            f10 = f10/norm(f10);
            f11 = feature_discrKurtosis(curGyr);
            f11 = f11/norm(f11);
            f12 = feature_discrKurtosis(curMag);    
            f12 = f12/norm(f12);
            % 10 sample autocorrelation
            f13 = feature_discrAutoCorr(curAcc);
            f14 = feature_discrAutoCorr(curGyr);
            f15 = feature_discrAutoCorr(curMag);
            % zero crossing rate
            f16 = feature_ZeroCrossingRate(curAcc);
            f16 = f16/norm(f16);
            f17 = feature_ZeroCrossingRate(curGyr);
            f17 = f17/norm(f17);
            f18 = feature_ZeroCrossingRate(curMag);
            f18 = f18/norm(f18);
            % mean crossing rate
            f19 = feature_MeanCrossingRate(curAcc);
            f19 = f19/norm(f19);
            f20 = feature_MeanCrossingRate(curGyr);
            f20 = f20/norm(f20);
            f21 = feature_MeanCrossingRate(curMag); 
            f21 = f21/norm(f21);
            % 4 first peaks FFT
            f22 = feature_discrFFTPeaks(curAcc);
            f23 = feature_discrFFTPeaks(curGyr);
            f24 = feature_discrFFTPeaks(curMag);
            % power dft
            f25 = feature_PowerDFT(curAcc);
            f25 = f25/norm(f25);
            f26 = feature_PowerDFT(curGyr);
            f26 = f26/norm(f26);
            f27 = feature_PowerDFT(curMag);
            f27 = f27/norm(f27);
            
            featArray = [f1;f2;f3;f4;f5;f6;f7;f8;f9;f10;f11;f12;f16;f17;f18;f19;f20;f21;f25;f26;f27];
            featArrayAC = [f13;f14;f15];
            discrFeatures{k,1} = featArray;
            discrFeatures{k,2} = featArrayAC;

            % mean
            f1 = feature_discrMean(curAng);
            f1 = f1/norm(f1);
            f2 = feature_discrMean(curPos);
            f2 = f2/norm(f2);
            % variance
            f4 = feature_discrVariance(curAng);
            f4 = f4/norm(f4);
            f5 = feature_discrVariance(curPos);
            f5 = f5/norm(f5);
            % skewness
            f7 = feature_discrSkewness(curAng);
            f7 = f7/norm(f7);
            f8 = feature_discrSkewness(curPos);
            f8 = f8/norm(f8);
            % kurtosis
            f10 = feature_discrKurtosis(curAng);
            f10 = f10/norm(f10);
            f11 = feature_discrKurtosis(curPos);
            f11 = f11/norm(f11);
            % 10 sample autocorrelation
            f13 = feature_discrAutoCorr(curAng);
            f14 = feature_discrAutoCorr(curPos);
            % zero crossing rate
            f16 = feature_ZeroCrossingRate(curAng);
            f16 = f16/norm(f16);
            f17 = feature_ZeroCrossingRate(curPos);
            f17 = f17/norm(f17);
            % mean crossing rate
            f19 = feature_MeanCrossingRate(curAng);
            f19 = f19/norm(f19);
            f20 = feature_MeanCrossingRate(curPos);
            f20 = f20/norm(f20);
            % power dft
            f25 = feature_PowerDFT(curAng);
            f25 = f25/norm(f25);
            f26 = feature_PowerDFT(curPos);
            f26 = f26/norm(f26);
            
            % add as many features as you want to the feature vector
            featArray = [f1;f2;f4;f5;f7;f8;f10;f11;f16;f17;f19;f20;f25;f26];
            featArrayAC = [f13;f14];
            discrFeatures{k,3} = featArray;
            discrFeatures{k,4} = featArrayAC;
        end
    end


end