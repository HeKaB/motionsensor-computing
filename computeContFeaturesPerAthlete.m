%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the basic function for computing rescaled continuous features
% from the sensor input data. You can freely add or remove features within every feature type.
% Methods for feature computation are stored within the features folders
% 
% Input: Raw and processed, time-serial sensor data
% -Sensor orientations
% -Body joint positions
% -Sensor-bone displacement
% -Accelerometer measurements
% -Gyroscope measurements
% -Abolsute body positions
% -Relative body angles
%
% Output: continuous feature cell arrays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [oriFeatures,posFeatures,rawFeatures,relFeatures] = computeContFeaturesPerAthlete(trFilesOrientations,trFilesPositions,trFilesSensDispl,trFilesAccData,trFilesGyroRate,trFilesBodyPos,relAngCell,sf)

    oriCell = trFilesOrientations;
    posCell = trFilesPositions;
    displCell = trFilesSensDispl;
    accCell = trFilesAccData;
    gyrCell = trFilesGyroRate;
    bodyPosCell = trFilesBodyPos;
    [oriFeatures] = computeAllOrientationFeatures(oriCell,displCell,sf);
    [posFeatures] = computeAllPositionFeatures(posCell,sf);
    [rawFeatures] = computeAllRawFeatures(oriCell,accCell,gyrCell,displCell);
    [relFeatures] = computeAllRelativeFeatures(oriCell,relAngCell,bodyPosCell);

end