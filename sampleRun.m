%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This sample file runs the complete classification of style errrors in a
% set of inertial capture ski jump data. The classification is k-fold and
% dependent on ground truth jump annotations collected from a judge during
% data acquisition. It is based on a SVM.
% 
% Necessary inputs:
% fileInfoTrainingDB: cell file containing all capture informations (file numbers, file lengths, etc)
% 
% trFilesAccAll: cell file of all raw accelerometer measurements for phase A and L
% trFilesGyrAll: cell file of all raw gyroscope measurements for phase A and L
% trFilesMagAll: cell file of all raw magnetometer measurements for phase A and L
% trFilesOrisWarpedAll: cell file of all processed sensor orientations for phase A and L
% trFilesPosWarpedAll: cell file of all processed joint positions for phase A and L
% 
% load all necessary input .mat files before running this file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sfSens = 500;

%% form groups of jumps with and without point deduction

detA1Fault = cell(0,1);detA1NoFault = cell(0,1);iterA1F = 1;iterA1NF = 1;
detA2Fault = cell(0,1);detA2NoFault = cell(0,1);iterA2F = 1;iterA2NF = 1;
detA3Fault = cell(0,1);detA3NoFault = cell(0,1);iterA3F = 1;iterA3NF = 1;
detA4Fault = cell(0,1);detA4NoFault = cell(0,1);iterA4F = 1;iterA4NF = 1;
detA5Fault = cell(0,1);detA5NoFault = cell(0,1);iterA5F = 1;iterA5NF = 1;
detL1Fault = cell(0,1);detL1NoFault = cell(0,1);iterL1F = 1;iterL1NF = 1;
detL2Fault = cell(0,1);detL2NoFault = cell(0,1);iterL2F = 1;iterL2NF = 1;
detL3Fault = cell(0,1);detL3NoFault = cell(0,1);iterL3F = 1;iterL3NF = 1;
detL4Fault = cell(0,1);detL4NoFault = cell(0,1);iterL4F = 1;iterL4NF = 1;
detL5Fault = cell(0,1);detL5NoFault = cell(0,1);iterL5F = 1;iterL5NF = 1;
detL6Fault = cell(0,1);detL6NoFault = cell(0,1);iterL6F = 1;iterL6NF = 1;

for trF = 1:size(fileInfoTrainingDB,1)-1
    currJD = judgeData{trF,1};
    % determinant A1
    if(currJD(1,2) ~= 0)
        detA1Fault{iterA1F,1} = trF;
        iterA1F = iterA1F+1;
    else
        detA1NoFault{iterA1NF,1} = trF;
        iterA1NF = iterA1NF+1;
    end
    % determinant A2
    if(currJD(2,2) ~= 0)
        detA2Fault{iterA2F,1} = trF;
        iterA2F = iterA2F+1;
    else
        detA2NoFault{iterA2NF,1} = trF;
        iterA2NF = iterA2NF+1;
    end
    % determinant A3
    if(currJD(3,2) ~= 0)
        detA3Fault{iterA3F,1} = trF;
        iterA3F = iterA3F+1;
    else
        detA3NoFault{iterA3NF,1} = trF;
        iterA3NF = iterA3NF+1;
    end
    % determinant A4
    if(currJD(4,2) ~= 0)
        detA4Fault{iterA4F,1} = trF;
        iterA4F = iterA4F+1;
    else
        detA4NoFault{iterA4NF,1} = trF;
        iterA4NF = iterA4NF+1;
    end
    % determinant A5
    if(currJD(5,2) ~= 0)
        detA5Fault{iterA5F,1} = trF;
        iterA5F = iterA5F+1;
    else
        detA5NoFault{iterA5NF,1} = trF;
        iterA5NF = iterA5NF+1;
    end
    % determinant L1
    if(currJD(6,2) ~= 0)
        detL1Fault{iterL1F,1} = trF;
        iterL1F = iterL1F+1;
    else
        detL1NoFault{iterL1NF,1} = trF;
        iterL1NF = iterL1NF+1;
    end
    % determinant L2
    if(currJD(7,2) ~= 0)
        detL2Fault{iterL2F,1} = trF;
        iterL2F = iterL2F+1;
    else
        detL2NoFault{iterL2NF,1} = trF;
        iterL2NF = iterL2NF+1;
    end
    % determinant L3
    if(currJD(8,2) ~= 0)
        detL3Fault{iterL3F,1} = trF;
        iterL3F = iterL3F+1;
    else
        detL3NoFault{iterL3NF,1} = trF;
        iterL3NF = iterL3NF+1;
    end
    % determinant L4
    if(currJD(9,2) ~= 0)
        detL4Fault{iterL4F,1} = trF;
        iterL4F = iterL4F+1;
    else
        detL4NoFault{iterL4NF,1} = trF;
        iterL4NF = iterL4NF+1;
    end
    % determinant L5
    if(currJD(10,2) ~= 0)
        detL5Fault{iterL5F,1} = trF;
        iterL5F = iterL5F+1;
    else
        detL5NoFault{iterL5NF,1} = trF;
        iterL5NF = iterL5NF+1;
    end
    % determinant L6
    if(currJD(11,2) ~= 0)
        detL6Fault{iterL6F,1} = trF;
        iterL6F = iterL6F+1;
    else
        detL6NoFault{iterL6NF,1} = trF;
        iterL6NF = iterL6NF+1;
    end
end

nA1 = min([length(detA1Fault) length(detA1NoFault)]);nA2 = min([length(detA2Fault) length(detA2NoFault)]);nA3 = min([length(detA3Fault) length(detA3NoFault)]);nA4 = min([length(detA4Fault) length(detA4NoFault)]);nA5 = min([length(detA5Fault) length(detA5NoFault)]);
nL1 = min([length(detL1Fault) length(detL1NoFault)]);nL2 = min([length(detL2Fault) length(detL2NoFault)]);nL3 = min([length(detL3Fault) length(detL3NoFault)]);nL4 = min([length(detL4Fault) length(detL4NoFault)]);nL5 = min([length(detL5Fault) length(detL5NoFault)]);

%% discrete features

trFilesDiscrFeatWarpAFault = cell(0,1); trFilesDiscrFeatWarpLFault = cell(0,1); 

for hij = 1:size(trFilesAccWarpedAll_A,1)
    [discrFeatures] = computeDiscrFeaturesPerAthlete(trFilesAccAll_A{hij,1},trFilesGyrAll_A{hij,1},trFilesMagAll_A{hij,1},trFilesOrisWarpedAll_A{hij,1},trFilesPosWarpedAll_A{hij,1});
    trFilesDiscrFeatWarpAFault{hij,1} = discrFeatures;
end
for hij = 1:size(trFilesAccWarpedAll_L,1)
    [discrFeatures] = computeDiscrFeaturesPerAthlete(trFilesAccAll_L{hij,1},trFilesGyrAll_L{hij,1},trFilesMagAll_L{hij,1},trFilesOrisWarpedAll_L{hij,1},trFilesPosWarpedAll_L{hij,1});
    trFilesDiscrFeatWarpLFault{hij,1} = discrFeatures;
end

%% compute continuous features group wise

relAngCell = {[1 2 1 5];[1 2 2 3];[2 3 3 4];[3 4 4 7];[1 5 5 6];[5 6 6 7];[6 7 7 4];[1 8 8 9];[1 9 9 8]};

trFilesOriFeatA = cell(0,1); trFilesPosFeatA = cell(0,1); trFilesRawFeatA = cell(0,1); trFilesRelFeatA = cell(0,1);
trFilesOriFeatL = cell(0,1); trFilesPosFeatL = cell(0,1); trFilesRawFeatL = cell(0,1); trFilesRelFeatL = cell(0,1);
arrayA = 1:size(trFilesOrisAll_A,1);
arrayL = 1:size(trFilesOrisAll_L,1);

% phase A
for hij = 1:size(trFilesOrisAll_A,1)
    [oriFeatures,posFeatures,rawFeatures,relFeatures] = computeContFeaturesPerAthlete(trFilesOrisAll_A{hij,1},trFilesPosAll_A{hij,1},trFilesSensDispl{arrayA(hij),1},trFilesAccAll_A{hij,1},trFilesGyrAll_A{hij,1},trFilesBodyPAll_A{hij,1},relAngCell,sfSens);
    trFilesOriFeatA{hij,1} = oriFeatures;trFilesPosFeatA{hij,1} = posFeatures;trFilesRawFeatA{hij,1} = rawFeatures;trFilesRelFeatA{hij,1} = relFeatures;
end

% phase L
for hij = 1:size(trFilesOrisAll_L,1)
    [oriFeatures,posFeatures,rawFeatures,relFeatures] = computeContFeaturesPerAthlete(trFilesOrisAll_L{hij,1},trFilesPosAll_L{hij,1},trFilesSensDispl{arrayL(hij),1},trFilesAccAll_L{hij,1},trFilesGyrAll_L{hij,1},trFilesBodyPAll_L{hij,1},relAngCell,sfSens);
    trFilesOriFeatL{hij,1} = oriFeatures;trFilesPosFeatL{hij,1} = posFeatures;trFilesRawFeatL{hij,1} = rawFeatures;trFilesRelFeatL{hij,1} = relFeatures;
end

%% form groups of jumps with and without point deduction k-fold

kFold = 8;
kFoldI = 5;
% split into training and testdatabase
[detA1FaultTR, detA1FaultTE] = splitListkFold(detA1Fault,kFold);[detA1NoFaultTR, detA1NoFaultTE] = splitListkFold(detA1NoFault,kFold);
[detA2FaultTR, detA2FaultTE] = splitListkFold(detA2Fault,kFold);[detA2NoFaultTR, detA2NoFaultTE] = splitListkFold(detA2NoFault,kFold);
[detA3FaultTR, detA3FaultTE] = splitListkFold(detA3Fault,kFold);[detA3NoFaultTR, detA3NoFaultTE] = splitListkFold(detA3NoFault,kFold);
[detA4FaultTR, detA4FaultTE] = splitListkFold(detA4Fault,kFold);[detA4NoFaultTR, detA4NoFaultTE] = splitListkFold(detA4NoFault,kFold);
[detA5FaultTR, detA5FaultTE] = splitListkFold(detA5Fault,kFold);[detA5NoFaultTR, detA5NoFaultTE] = splitListkFold(detA5NoFault,kFold);

[detL1FaultTR, detL1FaultTE] = splitListkFold(detL1Fault,kFold);[detL1NoFaultTR, detL1NoFaultTE] = splitListkFold(detL1NoFault,kFold);
[detL2FaultTR, detL2FaultTE] = splitListkFold(detL2Fault,kFold);[detL2NoFaultTR, detL2NoFaultTE] = splitListkFold(detL2NoFault,kFold);
[detL3FaultTR, detL3FaultTE] = splitListkFold(detL3Fault,kFold);[detL3NoFaultTR, detL3NoFaultTE] = splitListkFold(detL3NoFault,kFold);
[detL4FaultTR, detL4FaultTE] = splitListkFold(detL4Fault,kFold);[detL4NoFaultTR, detL4NoFaultTE] = splitListkFold(detL4NoFault,kFold);
[detL5FaultTR, detL5FaultTE] = splitListkFold(detL5Fault,kFold);[detL5NoFaultTR, detL5NoFaultTE] = splitListkFold(detL5NoFault,kFold);

%% cross validation k-fold cycle start

PrecRecDTWDiscr = cell(0,1);PrecRecDTWCont = cell(0,1);FMeasDTWDiscr = cell(0,1);FMeasDTWCont = cell(0,1);confMatDTWDiscr = cell(0,1);confMatDTWCont = cell(0,1);
PrecRecSVMDiscr = cell(0,1);PrecRecSVMCont = cell(0,1);FMeasSVMDiscr = cell(0,1);FMeasSVMCont = cell(0,1);confMatSVMDiscr = cell(0,1);confMatSVMCont = cell(0,1);

for k = 1:kFold
      
    % for use in training
    arrayDetA1FaultTR = cell2mat(detA1FaultTR{k,1})';arrayDetA1NoFaultTR = cell2mat(detA1NoFaultTR{k,1})';
    arrayDetA2FaultTR = cell2mat(detA2FaultTR{k,1})';arrayDetA2NoFaultTR = cell2mat(detA2NoFaultTR{k,1})';
    arrayDetA3FaultTR = cell2mat(detA3FaultTR{k,1})';arrayDetA3NoFaultTR = cell2mat(detA3NoFaultTR{k,1})';
    arrayDetA4FaultTR = cell2mat(detA4FaultTR{k,1})';arrayDetA4NoFaultTR = cell2mat(detA4NoFaultTR{k,1})';
    arrayDetA5FaultTR = cell2mat(detA5FaultTR{k,1})';arrayDetA5NoFaultTR = cell2mat(detA5NoFaultTR{k,1})';
    arrayDetL1FaultTR = cell2mat(detL1FaultTR{k,1})';arrayDetL1NoFaultTR = cell2mat(detL1NoFaultTR{k,1})';
    arrayDetL2FaultTR = cell2mat(detL2FaultTR{k,1})';arrayDetL2NoFaultTR = cell2mat(detL2NoFaultTR{k,1})';
    arrayDetL3FaultTR = cell2mat(detL3FaultTR{k,1})';arrayDetL3NoFaultTR = cell2mat(detL3NoFaultTR{k,1})';
    arrayDetL4FaultTR = cell2mat(detL4FaultTR{k,1})';arrayDetL4NoFaultTR = cell2mat(detL4NoFaultTR{k,1})';
    arrayDetL5FaultTR = cell2mat(detL5FaultTR{k,1})';arrayDetL5NoFaultTR = cell2mat(detL5NoFaultTR{k,1})';

    % for use in testing
    arrayDetA1FaultTE = cell2mat(detA1FaultTE{k,1})';arrayDetA1NoFaultTE = cell2mat(detA1NoFaultTE{k,1})';
    arrayDetA2FaultTE = cell2mat(detA2FaultTE{k,1})';arrayDetA2NoFaultTE = cell2mat(detA2NoFaultTE{k,1})';
    arrayDetA3FaultTE = cell2mat(detA3FaultTE{k,1})';arrayDetA3NoFaultTE = cell2mat(detA3NoFaultTE{k,1})';
    arrayDetA4FaultTE = cell2mat(detA4FaultTE{k,1})';arrayDetA4NoFaultTE = cell2mat(detA4NoFaultTE{k,1})';
    arrayDetA5FaultTE = cell2mat(detA5FaultTE{k,1})';arrayDetA5NoFaultTE = cell2mat(detA5NoFaultTE{k,1})';
    arrayDetL1FaultTE = cell2mat(detL1FaultTE{k,1})';arrayDetL1NoFaultTE = cell2mat(detL1NoFaultTE{k,1})';
    arrayDetL2FaultTE = cell2mat(detL2FaultTE{k,1})';arrayDetL2NoFaultTE = cell2mat(detL2NoFaultTE{k,1})';
    arrayDetL3FaultTE = cell2mat(detL3FaultTE{k,1})';arrayDetL3NoFaultTE = cell2mat(detL3NoFaultTE{k,1})';
    arrayDetL4FaultTE = cell2mat(detL4FaultTE{k,1})';arrayDetL4NoFaultTE = cell2mat(detL4NoFaultTE{k,1})';
    arrayDetL5FaultTE = cell2mat(detL5FaultTE{k,1})';arrayDetL5NoFaultTE = cell2mat(detL5NoFaultTE{k,1})';

    % prepare data

    trFilesDiscrFeatA = listDiscrFeaturesMatrix(trFilesDiscrFeatWarpAFault);
    trFilesContFeatA = listContFeaturesMatrix(trFilesOriFeatA,trFilesPosFeatA,trFilesRelFeatA);
    trFilesDiscrFeatL = listDiscrFeaturesMatrix(trFilesDiscrFeatWarpLFault);
    trFilesContFeatL = listContFeaturesMatrix(trFilesOriFeatL,trFilesPosFeatL,trFilesRelFeatL);

    % split features into groups training
    % discr
    [DiscrFeatListA1FaultTrain,DiscrFeatListA1NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA1FaultTR,arrayDetA1NoFaultTR);[DiscrFeatListL1FaultTrain,DiscrFeatListL1NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL1FaultTR,arrayDetL1NoFaultTR);
    [DiscrFeatListA2FaultTrain,DiscrFeatListA2NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA2FaultTR,arrayDetA2NoFaultTR);[DiscrFeatListL2FaultTrain,DiscrFeatListL2NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL2FaultTR,arrayDetL2NoFaultTR);
    [DiscrFeatListA3FaultTrain,DiscrFeatListA3NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA3FaultTR,arrayDetA3NoFaultTR);[DiscrFeatListL3FaultTrain,DiscrFeatListL3NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL3FaultTR,arrayDetL3NoFaultTR);
    [DiscrFeatListA4FaultTrain,DiscrFeatListA4NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA4FaultTR,arrayDetA4NoFaultTR);[DiscrFeatListL4FaultTrain,DiscrFeatListL4NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL4FaultTR,arrayDetL4NoFaultTR);
    [DiscrFeatListA5FaultTrain,DiscrFeatListA5NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA5FaultTR,arrayDetA5NoFaultTR);[DiscrFeatListL5FaultTrain,DiscrFeatListL5NoFaultTrain] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL5FaultTR,arrayDetL5NoFaultTR);
    % cont
    [ContFeatListA1FaultTrain,ContFeatListA1NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA1FaultTR,arrayDetA1NoFaultTR);[ContFeatListL1FaultTrain,ContFeatListL1NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL1FaultTR,arrayDetL1NoFaultTR);
    [ContFeatListA2FaultTrain,ContFeatListA2NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA2FaultTR,arrayDetA2NoFaultTR);[ContFeatListL2FaultTrain,ContFeatListL2NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL2FaultTR,arrayDetL2NoFaultTR);
    [ContFeatListA3FaultTrain,ContFeatListA3NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA3FaultTR,arrayDetA3NoFaultTR);[ContFeatListL3FaultTrain,ContFeatListL3NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL3FaultTR,arrayDetL3NoFaultTR);
    [ContFeatListA4FaultTrain,ContFeatListA4NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA4FaultTR,arrayDetA4NoFaultTR);[ContFeatListL4FaultTrain,ContFeatListL4NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL4FaultTR,arrayDetL4NoFaultTR);
    [ContFeatListA5FaultTrain,ContFeatListA5NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA5FaultTR,arrayDetA5NoFaultTR);[ContFeatListL5FaultTrain,ContFeatListL5NoFaultTrain] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL5FaultTR,arrayDetL5NoFaultTR);

    % split features into groups testing
    % discr
    [DiscrFeatListA1FaultTest,DiscrFeatListA1NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA1FaultTE,arrayDetA1NoFaultTE);[DiscrFeatListL1FaultTest,DiscrFeatListL1NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL1FaultTE,arrayDetL1NoFaultTE);
    [DiscrFeatListA2FaultTest,DiscrFeatListA2NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA2FaultTE,arrayDetA2NoFaultTE);[DiscrFeatListL2FaultTest,DiscrFeatListL2NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL2FaultTE,arrayDetL2NoFaultTE);
    [DiscrFeatListA3FaultTest,DiscrFeatListA3NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA3FaultTE,arrayDetA3NoFaultTE);[DiscrFeatListL3FaultTest,DiscrFeatListL3NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL3FaultTE,arrayDetL3NoFaultTE);
    [DiscrFeatListA4FaultTest,DiscrFeatListA4NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA4FaultTE,arrayDetA4NoFaultTE);[DiscrFeatListL4FaultTest,DiscrFeatListL4NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL4FaultTE,arrayDetL4NoFaultTE);
    [DiscrFeatListA5FaultTest,DiscrFeatListA5NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatA,arrayDetA5FaultTE,arrayDetA5NoFaultTE);[DiscrFeatListL5FaultTest,DiscrFeatListL5NoFaultTest] = splitMotionsIntoGroup(trFilesDiscrFeatL,arrayDetL5FaultTE,arrayDetL5NoFaultTE);
    % cont
    [ContFeatListA1FaultTest,ContFeatListA1NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA1FaultTE,arrayDetA1NoFaultTE);[ContFeatListL1FaultTest,ContFeatListL1NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL1FaultTE,arrayDetL1NoFaultTE);
    [ContFeatListA2FaultTest,ContFeatListA2NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA2FaultTE,arrayDetA2NoFaultTE);[ContFeatListL2FaultTest,ContFeatListL2NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL2FaultTE,arrayDetL2NoFaultTE);
    [ContFeatListA3FaultTest,ContFeatListA3NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA3FaultTE,arrayDetA3NoFaultTE);[ContFeatListL3FaultTest,ContFeatListL3NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL3FaultTE,arrayDetL3NoFaultTE);
    [ContFeatListA4FaultTest,ContFeatListA4NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA4FaultTE,arrayDetA4NoFaultTE);[ContFeatListL4FaultTest,ContFeatListL4NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL4FaultTE,arrayDetL4NoFaultTE);
    [ContFeatListA5FaultTest,ContFeatListA5NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatA,arrayDetA5FaultTE,arrayDetA5NoFaultTE);[ContFeatListL5FaultTest,ContFeatListL5NoFaultTest] = splitMotionsIntoGroup(trFilesContFeatL,arrayDetL5FaultTE,arrayDetL5NoFaultTE);

    % evaluate complete features combined by SVM with SVD
    % select features
    % discr
    selFeatDiscrA1FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA1FaultTrain,featSelListDiscrA1);selFeatDiscrA1NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA1NoFaultTrain,featSelListDiscrA1);selFeatDiscrA2FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA2FaultTrain,featSelListDiscrA2);selFeatDiscrA2NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA2NoFaultTrain,featSelListDiscrA2);
    selFeatDiscrA3FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA3FaultTrain,featSelListDiscrA3);selFeatDiscrA3NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA3NoFaultTrain,featSelListDiscrA3);selFeatDiscrA4FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA4FaultTrain,featSelListDiscrA4);selFeatDiscrA4NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA4NoFaultTrain,featSelListDiscrA4);
    selFeatDiscrA5FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA5FaultTrain,featSelListDiscrA5);selFeatDiscrA5NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA5NoFaultTrain,featSelListDiscrA5);
    selFeatDiscrL1FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL1FaultTrain,featSelListDiscrL1);selFeatDiscrL1NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL1NoFaultTrain,featSelListDiscrL1);selFeatDiscrL2FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL2FaultTrain,featSelListDiscrL2);selFeatDiscrL2NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL2NoFaultTrain,featSelListDiscrL2);
    selFeatDiscrL3FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL3FaultTrain,featSelListDiscrL3);selFeatDiscrL3NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL3NoFaultTrain,featSelListDiscrL3);selFeatDiscrL4FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL4FaultTrain,featSelListDiscrL4);selFeatDiscrL4NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL4NoFaultTrain,featSelListDiscrL4);
    selFeatDiscrL5FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL5FaultTrain,featSelListDiscrL5);selFeatDiscrL5NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL5NoFaultTrain,featSelListDiscrL5);
    
    ResultModelDiscrAllSelA1 = TrainSVMData(selFeatDiscrA1FaultMatr,selFeatDiscrA1NoFaultMatr);ResultModelDiscrAllSelL1 = TrainSVMData(selFeatDiscrL1FaultMatr,selFeatDiscrL1NoFaultMatr);
    ResultModelDiscrAllSelA2 = TrainSVMData(selFeatDiscrA2FaultMatr,selFeatDiscrA2NoFaultMatr);ResultModelDiscrAllSelL2 = TrainSVMData(selFeatDiscrL2FaultMatr,selFeatDiscrL2NoFaultMatr);
    ResultModelDiscrAllSelA3 = TrainSVMData(selFeatDiscrA3FaultMatr,selFeatDiscrA3NoFaultMatr);ResultModelDiscrAllSelL3 = TrainSVMData(selFeatDiscrL3FaultMatr,selFeatDiscrL3NoFaultMatr);
    ResultModelDiscrAllSelA4 = TrainSVMData(selFeatDiscrA4FaultMatr,selFeatDiscrA4NoFaultMatr);ResultModelDiscrAllSelL4 = TrainSVMData(selFeatDiscrL4FaultMatr,selFeatDiscrL4NoFaultMatr);
    ResultModelDiscrAllSelA5 = TrainSVMData(selFeatDiscrA5FaultMatr,selFeatDiscrA5NoFaultMatr);ResultModelDiscrAllSelL5 = TrainSVMData(selFeatDiscrL5FaultMatr,selFeatDiscrL5NoFaultMatr);
    
    selFeatDiscrA1FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA1FaultTest,featSelListDiscrA1);selFeatDiscrA1NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA1NoFaultTest,featSelListDiscrA1);selFeatDiscrA2FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA2FaultTest,featSelListDiscrA2);selFeatDiscrA2NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA2NoFaultTest,featSelListDiscrA2);
    selFeatDiscrA3FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA3FaultTest,featSelListDiscrA3);selFeatDiscrA3NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA3NoFaultTest,featSelListDiscrA3);selFeatDiscrA4FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA4FaultTest,featSelListDiscrA4);selFeatDiscrA4NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA4NoFaultTest,featSelListDiscrA4);
    selFeatDiscrA5FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA5FaultTest,featSelListDiscrA5);selFeatDiscrA5NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListA5NoFaultTest,featSelListDiscrA5);
    selFeatDiscrL1FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL1FaultTest,featSelListDiscrL1);selFeatDiscrL1NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL1NoFaultTest,featSelListDiscrL1);selFeatDiscrL2FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL2FaultTest,featSelListDiscrL2);selFeatDiscrL2NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL2NoFaultTest,featSelListDiscrL2);
    selFeatDiscrL3FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL3FaultTest,featSelListDiscrL3);selFeatDiscrL3NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL3NoFaultTest,featSelListDiscrL3);selFeatDiscrL4FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL4FaultTest,featSelListDiscrL4);selFeatDiscrL4NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL4NoFaultTest,featSelListDiscrL4);
    selFeatDiscrL5FaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL5FaultTest,featSelListDiscrL5);selFeatDiscrL5NoFaultMatr = buildFeaturesFromFeatSelectionList(DiscrFeatListL5NoFaultTest,featSelListDiscrL5);

    [ResultLabelDiscrAllSelA1SVM, TrueLabelDiscrAllSelA1SVM] = PredictLabelsSVM(ResultModelDiscrAllSelA1, selFeatDiscrA1FaultMatr,selFeatDiscrA1NoFaultMatr);[ResultLabelDiscrAllSelL1SVM, TrueLabelDiscrAllSelL1SVM] = PredictLabelsSVM(ResultModelDiscrAllSelL1, selFeatDiscrL1FaultMatr,selFeatDiscrL1NoFaultMatr);
    [ResultLabelDiscrAllSelA2SVM, TrueLabelDiscrAllSelA2SVM] = PredictLabelsSVM(ResultModelDiscrAllSelA2, selFeatDiscrA2FaultMatr,selFeatDiscrA2NoFaultMatr);[ResultLabelDiscrAllSelL2SVM, TrueLabelDiscrAllSelL2SVM] = PredictLabelsSVM(ResultModelDiscrAllSelL2, selFeatDiscrL2FaultMatr,selFeatDiscrL2NoFaultMatr);
    [ResultLabelDiscrAllSelA3SVM, TrueLabelDiscrAllSelA3SVM] = PredictLabelsSVM(ResultModelDiscrAllSelA3, selFeatDiscrA3FaultMatr,selFeatDiscrA3NoFaultMatr);[ResultLabelDiscrAllSelL3SVM, TrueLabelDiscrAllSelL3SVM] = PredictLabelsSVM(ResultModelDiscrAllSelL3, selFeatDiscrL3FaultMatr,selFeatDiscrL3NoFaultMatr);
    [ResultLabelDiscrAllSelA4SVM, TrueLabelDiscrAllSelA4SVM] = PredictLabelsSVM(ResultModelDiscrAllSelA4, selFeatDiscrA4FaultMatr,selFeatDiscrA4NoFaultMatr);[ResultLabelDiscrAllSelL4SVM, TrueLabelDiscrAllSelL4SVM] = PredictLabelsSVM(ResultModelDiscrAllSelL4, selFeatDiscrL4FaultMatr,selFeatDiscrL4NoFaultMatr);
    [ResultLabelDiscrAllSelA5SVM, TrueLabelDiscrAllSelA5SVM] = PredictLabelsSVM(ResultModelDiscrAllSelA5, selFeatDiscrA5FaultMatr,selFeatDiscrA5NoFaultMatr);[ResultLabelDiscrAllSelL5SVM, TrueLabelDiscrAllSelL5SVM] = PredictLabelsSVM(ResultModelDiscrAllSelL5, selFeatDiscrL5FaultMatr,selFeatDiscrL5NoFaultMatr);

    % cont
    selFeatContA1Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA1FaultTrain,featSelListContA1);selFeatContA1NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA1NoFaultTrain,featSelListContA1);selFeatContA2Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA2FaultTrain,featSelListContA2);selFeatContA2NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA2NoFaultTrain,featSelListContA2);
    selFeatContA3Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA3FaultTrain,featSelListContA3);selFeatContA3NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA3NoFaultTrain,featSelListContA3);selFeatContA4Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA4FaultTrain,featSelListContA4);selFeatContA4NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA4NoFaultTrain,featSelListContA4);
    selFeatContA5Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA5FaultTrain,featSelListContA5);selFeatContA5NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA5NoFaultTrain,featSelListContA5);
    selFeatContL1Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL1FaultTrain,featSelListContL1);selFeatContL1NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL1NoFaultTrain,featSelListContL1);selFeatContL2Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL2FaultTrain,featSelListContL2);selFeatContL2NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL2NoFaultTrain,featSelListContL2);
    selFeatContL3Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL3FaultTrain,featSelListContL3);selFeatContL3NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL3NoFaultTrain,featSelListContL3);selFeatContL4Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL4FaultTrain,featSelListContL4);selFeatContL4NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL4NoFaultTrain,featSelListContL4);
    selFeatContL5Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL5FaultTrain,featSelListContL5);selFeatContL5NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL5NoFaultTrain,featSelListContL5);

    SVDFeatMatricesContA1Fault = prepareContFeatForSVM(selFeatContA1Fault);SVDFeatMatricesContA1NoFault = prepareContFeatForSVM(selFeatContA1NoFault);SVDFeatMatricesContA2Fault = prepareContFeatForSVM(selFeatContA2Fault);SVDFeatMatricesContA2NoFault = prepareContFeatForSVM(selFeatContA2NoFault);SVDFeatMatricesContA3Fault = prepareContFeatForSVM(selFeatContA3Fault);SVDFeatMatricesContA3NoFault = prepareContFeatForSVM(selFeatContA3NoFault);
    SVDFeatMatricesContA4Fault = prepareContFeatForSVM(selFeatContA4Fault);SVDFeatMatricesContA4NoFault = prepareContFeatForSVM(selFeatContA4NoFault);SVDFeatMatricesContA5Fault = prepareContFeatForSVM(selFeatContA5Fault);SVDFeatMatricesContA5NoFault = prepareContFeatForSVM(selFeatContA5NoFault);
    SVDFeatMatricesContL1Fault = prepareContFeatForSVM(selFeatContL1Fault);SVDFeatMatricesContL1NoFault = prepareContFeatForSVM(selFeatContL1NoFault);SVDFeatMatricesContL2Fault = prepareContFeatForSVM(selFeatContL2Fault);SVDFeatMatricesContL2NoFault = prepareContFeatForSVM(selFeatContL2NoFault);SVDFeatMatricesContL3Fault = prepareContFeatForSVM(selFeatContL3Fault);SVDFeatMatricesContL3NoFault = prepareContFeatForSVM(selFeatContL3NoFault);
    SVDFeatMatricesContL4Fault = prepareContFeatForSVM(selFeatContL4Fault);SVDFeatMatricesContL4NoFault = prepareContFeatForSVM(selFeatContL4NoFault);SVDFeatMatricesContL5Fault = prepareContFeatForSVM(selFeatContL5Fault);SVDFeatMatricesContL5NoFault = prepareContFeatForSVM(selFeatContL5NoFault);

    ResultModelContAllSelA1 = TrainSVMData(SVDFeatMatricesContA1Fault,SVDFeatMatricesContA1NoFault);ResultModelContAllSelL1 = TrainSVMData(SVDFeatMatricesContL1Fault,SVDFeatMatricesContL1NoFault);
    ResultModelContAllSelA2 = TrainSVMData(SVDFeatMatricesContA2Fault,SVDFeatMatricesContA2NoFault);ResultModelContAllSelL2 = TrainSVMData(SVDFeatMatricesContL2Fault,SVDFeatMatricesContL2NoFault);
    ResultModelContAllSelA3 = TrainSVMData(SVDFeatMatricesContA3Fault,SVDFeatMatricesContA3NoFault);ResultModelContAllSelL3 = TrainSVMData(SVDFeatMatricesContL3Fault,SVDFeatMatricesContL3NoFault);
    ResultModelContAllSelA4 = TrainSVMData(SVDFeatMatricesContA4Fault,SVDFeatMatricesContA4NoFault);ResultModelContAllSelL4 = TrainSVMData(SVDFeatMatricesContL4Fault,SVDFeatMatricesContL4NoFault);
    ResultModelContAllSelA5 = TrainSVMData(SVDFeatMatricesContA5Fault,SVDFeatMatricesContA5NoFault);ResultModelContAllSelL5 = TrainSVMData(SVDFeatMatricesContL5Fault,SVDFeatMatricesContL5NoFault);

    selFeatContA1Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA1FaultTest,featSelListContA1);selFeatContA1NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA1NoFaultTest,featSelListContA1);selFeatContA2Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA2FaultTest,featSelListContA2);selFeatContA2NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA2NoFaultTest,featSelListContA2);
    selFeatContA3Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA3FaultTest,featSelListContA3);selFeatContA3NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA3NoFaultTest,featSelListContA3);selFeatContA4Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA4FaultTest,featSelListContA4);selFeatContA4NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA4NoFaultTest,featSelListContA4);
    selFeatContA5Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListA5FaultTest,featSelListContA5);selFeatContA5NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListA5NoFaultTest,featSelListContA5);
    selFeatContL1Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL1FaultTest,featSelListContL1);selFeatContL1NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL1NoFaultTest,featSelListContL1);selFeatContL2Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL2FaultTest,featSelListContL2);selFeatContL2NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL2NoFaultTest,featSelListContL2);
    selFeatContL3Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL3FaultTest,featSelListContL3);selFeatContL3NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL3NoFaultTest,featSelListContL3);selFeatContL4Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL4FaultTest,featSelListContL4);selFeatContL4NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL4NoFaultTest,featSelListContL4);
    selFeatContL5Fault = buildFeaturesFromFeatSelectionListCell(ContFeatListL5FaultTest,featSelListContL5);selFeatContL5NoFault = buildFeaturesFromFeatSelectionListCell(ContFeatListL5NoFaultTest,featSelListContL5);

    SVDFeatMatricesContAllSelA1Fault = prepareContFeatForSVM(selFeatContA1Fault);SVDFeatMatricesContAllSelA1NoFault = prepareContFeatForSVM(selFeatContA1NoFault);SVDFeatMatricesContAllSelA2Fault = prepareContFeatForSVM(selFeatContA2Fault);SVDFeatMatricesContAllSelA2NoFault = prepareContFeatForSVM(selFeatContA2NoFault);SVDFeatMatricesContAllSelA3Fault = prepareContFeatForSVM(selFeatContA3Fault);SVDFeatMatricesContAllSelA3NoFault = prepareContFeatForSVM(selFeatContA3NoFault);
    SVDFeatMatricesContAllSelA4Fault = prepareContFeatForSVM(selFeatContA4Fault);SVDFeatMatricesContAllSelA4NoFault = prepareContFeatForSVM(selFeatContA4NoFault);SVDFeatMatricesContAllSelA5Fault = prepareContFeatForSVM(selFeatContA5Fault);SVDFeatMatricesContAllSelA5NoFault = prepareContFeatForSVM(selFeatContA5NoFault);
    SVDFeatMatricesContAllSelL1Fault = prepareContFeatForSVM(selFeatContL1Fault);SVDFeatMatricesContAllSelL1NoFault = prepareContFeatForSVM(selFeatContL1NoFault);SVDFeatMatricesContAllSelL2Fault = prepareContFeatForSVM(selFeatContL2Fault);SVDFeatMatricesContAllSelL2NoFault = prepareContFeatForSVM(selFeatContL2NoFault);SVDFeatMatricesContAllSelL3Fault = prepareContFeatForSVM(selFeatContL3Fault);SVDFeatMatricesContAllSelL3NoFault = prepareContFeatForSVM(selFeatContL3NoFault);
    SVDFeatMatricesContAllSelL4Fault = prepareContFeatForSVM(selFeatContL4Fault);SVDFeatMatricesContAllSelL4NoFault = prepareContFeatForSVM(selFeatContL4NoFault);SVDFeatMatricesContAllSelL5Fault = prepareContFeatForSVM(selFeatContL5Fault);SVDFeatMatricesContAllSelL5NoFault = prepareContFeatForSVM(selFeatContL5NoFault);

    [ResultLabelContAllSelA1SVM, TrueLabelContAllSelA1SVM] = PredictLabelsSVM(ResultModelContAllSelA1, SVDFeatMatricesContAllSelA1Fault,SVDFeatMatricesContAllSelA1NoFault);[ResultLabelContAllSelL1SVM, TrueLabelContAllSelL1SVM] = PredictLabelsSVM(ResultModelContAllSelL1, SVDFeatMatricesContAllSelL1Fault,SVDFeatMatricesContAllSelL1NoFault);
    [ResultLabelContAllSelA2SVM, TrueLabelContAllSelA2SVM] = PredictLabelsSVM(ResultModelContAllSelA2, SVDFeatMatricesContAllSelA2Fault,SVDFeatMatricesContAllSelA2NoFault);[ResultLabelContAllSelL2SVM, TrueLabelContAllSelL2SVM] = PredictLabelsSVM(ResultModelContAllSelL2, SVDFeatMatricesContAllSelL2Fault,SVDFeatMatricesContAllSelL2NoFault);
    [ResultLabelContAllSelA3SVM, TrueLabelContAllSelA3SVM] = PredictLabelsSVM(ResultModelContAllSelA3, SVDFeatMatricesContAllSelA3Fault,SVDFeatMatricesContAllSelA3NoFault);[ResultLabelContAllSelL3SVM, TrueLabelContAllSelL3SVM] = PredictLabelsSVM(ResultModelContAllSelL3, SVDFeatMatricesContAllSelL3Fault,SVDFeatMatricesContAllSelL3NoFault);
    [ResultLabelContAllSelA4SVM, TrueLabelContAllSelA4SVM] = PredictLabelsSVM(ResultModelContAllSelA4, SVDFeatMatricesContAllSelA4Fault,SVDFeatMatricesContAllSelA4NoFault);[ResultLabelContAllSelL4SVM, TrueLabelContAllSelL4SVM] = PredictLabelsSVM(ResultModelContAllSelL4, SVDFeatMatricesContAllSelL4Fault,SVDFeatMatricesContAllSelL4NoFault);
    [ResultLabelContAllSelA5SVM, TrueLabelContAllSelA5SVM] = PredictLabelsSVM(ResultModelContAllSelA5, SVDFeatMatricesContAllSelA5Fault,SVDFeatMatricesContAllSelA5NoFault);[ResultLabelContAllSelL5SVM, TrueLabelContAllSelL5SVM] = PredictLabelsSVM(ResultModelContAllSelL5, SVDFeatMatricesContAllSelL5Fault,SVDFeatMatricesContAllSelL5NoFault);

    % compute precision/recall for labels
    discrPrecRecSVMA1SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelA1SVM,TrueLabelDiscrAllSelA1SVM);discrPrecRecSVMA2SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelA2SVM,TrueLabelDiscrAllSelA2SVM);discrPrecRecSVMA3SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelA3SVM,TrueLabelDiscrAllSelA3SVM);discrPrecRecSVMA4SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelA4SVM,TrueLabelDiscrAllSelA4SVM);discrPrecRecSVMA5SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelA5SVM,TrueLabelDiscrAllSelA5SVM);
    discrPrecRecSVML1SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelL1SVM,TrueLabelDiscrAllSelL1SVM);discrPrecRecSVML2SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelL2SVM,TrueLabelDiscrAllSelL2SVM);discrPrecRecSVML3SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelL3SVM,TrueLabelDiscrAllSelL3SVM);discrPrecRecSVML4SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelL4SVM,TrueLabelDiscrAllSelL4SVM);discrPrecRecSVML5SelAllF = determinePrecRecallSVM(ResultLabelDiscrAllSelL5SVM,TrueLabelDiscrAllSelL5SVM);
    contPrecRecSVMA1SelAllF = determinePrecRecallSVM(ResultLabelContAllSelA1SVM,TrueLabelContAllSelA1SVM);contPrecRecSVMA2SelAllF = determinePrecRecallSVM(ResultLabelContAllSelA2SVM,TrueLabelContAllSelA2SVM);contPrecRecSVMA3SelAllF = determinePrecRecallSVM(ResultLabelContAllSelA3SVM,TrueLabelContAllSelA3SVM);contPrecRecSVMA4SelAllF = determinePrecRecallSVM(ResultLabelContAllSelA4SVM,TrueLabelContAllSelA4SVM);contPrecRecSVMA5SelAllF = determinePrecRecallSVM(ResultLabelContAllSelA5SVM,TrueLabelContAllSelA5SVM);
    contPrecRecSVML1SelAllF = determinePrecRecallSVM(ResultLabelContAllSelL1SVM,TrueLabelContAllSelL1SVM);contPrecRecSVML2SelAllF = determinePrecRecallSVM(ResultLabelContAllSelL2SVM,TrueLabelContAllSelL2SVM);contPrecRecSVML3SelAllF = determinePrecRecallSVM(ResultLabelContAllSelL3SVM,TrueLabelContAllSelL3SVM);contPrecRecSVML4SelAllF = determinePrecRecallSVM(ResultLabelContAllSelL4SVM,TrueLabelContAllSelL4SVM);contPrecRecSVML5SelAllF = determinePrecRecallSVM(ResultLabelContAllSelL5SVM,TrueLabelContAllSelL5SVM);
    
    PrecRecSVMDiscr{k,1} = discrPrecRecSVMA1SelAllF;PrecRecSVMDiscr{k,2} = discrPrecRecSVMA2SelAllF;PrecRecSVMDiscr{k,3} = discrPrecRecSVMA3SelAllF;PrecRecSVMDiscr{k,4} = discrPrecRecSVMA4SelAllF;PrecRecSVMDiscr{k,5} = discrPrecRecSVMA5SelAllF;
    PrecRecSVMDiscr{k,6} = discrPrecRecSVML1SelAllF;PrecRecSVMDiscr{k,7} = discrPrecRecSVML2SelAllF;PrecRecSVMDiscr{k,8} = discrPrecRecSVML3SelAllF;PrecRecSVMDiscr{k,9} = discrPrecRecSVML4SelAllF;PrecRecSVMDiscr{k,10} = discrPrecRecSVML5SelAllF;
    PrecRecSVMCont{k,1} = contPrecRecSVMA1SelAllF;PrecRecSVMCont{k,2} = contPrecRecSVMA2SelAllF;PrecRecSVMCont{k,3} = contPrecRecSVMA3SelAllF;PrecRecSVMCont{k,4} = contPrecRecSVMA4SelAllF;PrecRecSVMCont{k,5} = contPrecRecSVMA5SelAllF;
    PrecRecSVMCont{k,6} = contPrecRecSVML1SelAllF;PrecRecSVMCont{k,7} = contPrecRecSVML2SelAllF;PrecRecSVMCont{k,8} = contPrecRecSVML3SelAllF;PrecRecSVMCont{k,9} = contPrecRecSVML4SelAllF;PrecRecSVMCont{k,10} = contPrecRecSVML5SelAllF;
    
    % F-measure
    % discr
    FMeasSVMDiscrA1 = 2*(discrPrecRecSVMA1SelAllF(1).*discrPrecRecSVMA1SelAllF(2)./(sum(discrPrecRecSVMA1SelAllF)));FMeasSVMDiscrL1 = 2*(discrPrecRecSVML1SelAllF(1).*discrPrecRecSVML1SelAllF(2)./(sum(discrPrecRecSVML1SelAllF)));
    FMeasSVMDiscrA2 = 2*(discrPrecRecSVMA2SelAllF(1).*discrPrecRecSVMA2SelAllF(2)./(sum(discrPrecRecSVMA2SelAllF)));FMeasSVMDiscrL2 = 2*(discrPrecRecSVML2SelAllF(1).*discrPrecRecSVML2SelAllF(2)./(sum(discrPrecRecSVML2SelAllF)));
    FMeasSVMDiscrA3 = 2*(discrPrecRecSVMA3SelAllF(1).*discrPrecRecSVMA3SelAllF(2)./(sum(discrPrecRecSVMA3SelAllF)));FMeasSVMDiscrL3 = 2*(discrPrecRecSVML3SelAllF(1).*discrPrecRecSVML3SelAllF(2)./(sum(discrPrecRecSVML3SelAllF)));
    FMeasSVMDiscrA4 = 2*(discrPrecRecSVMA4SelAllF(1).*discrPrecRecSVMA4SelAllF(2)./(sum(discrPrecRecSVMA4SelAllF)));FMeasSVMDiscrL4 = 2*(discrPrecRecSVML4SelAllF(1).*discrPrecRecSVML4SelAllF(2)./(sum(discrPrecRecSVML4SelAllF)));
    FMeasSVMDiscrA5 = 2*(discrPrecRecSVMA5SelAllF(1).*discrPrecRecSVMA5SelAllF(2)./(sum(discrPrecRecSVMA5SelAllF)));FMeasSVMDiscrL5 = 2*(discrPrecRecSVML5SelAllF(1).*discrPrecRecSVML5SelAllF(2)./(sum(discrPrecRecSVML5SelAllF)));
    % cont
    FMeasSVMContA1 = 2*(contPrecRecSVMA1SelAllF(1).*contPrecRecSVMA1SelAllF(2)./(sum(contPrecRecSVMA1SelAllF)));FMeasSVMContL1 = 2*(contPrecRecSVML1SelAllF(1).*contPrecRecSVML1SelAllF(2)./(sum(contPrecRecSVML1SelAllF)));
    FMeasSVMContA2 = 2*(contPrecRecSVMA2SelAllF(1).*contPrecRecSVMA2SelAllF(2)./(sum(contPrecRecSVMA2SelAllF)));FMeasSVMContL2 = 2*(contPrecRecSVML2SelAllF(1).*contPrecRecSVML2SelAllF(2)./(sum(contPrecRecSVML2SelAllF)));
    FMeasSVMContA3 = 2*(contPrecRecSVMA3SelAllF(1).*contPrecRecSVMA3SelAllF(2)./(sum(contPrecRecSVMA3SelAllF)));FMeasSVMContL3 = 2*(contPrecRecSVML3SelAllF(1).*contPrecRecSVML3SelAllF(2)./(sum(contPrecRecSVML3SelAllF)));
    FMeasSVMContA4 = 2*(contPrecRecSVMA4SelAllF(1).*contPrecRecSVMA4SelAllF(2)./(sum(contPrecRecSVMA4SelAllF)));FMeasSVMContL4 = 2*(contPrecRecSVML4SelAllF(1).*contPrecRecSVML4SelAllF(2)./(sum(contPrecRecSVML4SelAllF)));
    FMeasSVMContA5 = 2*(contPrecRecSVMA5SelAllF(1).*contPrecRecSVMA5SelAllF(2)./(sum(contPrecRecSVMA5SelAllF)));FMeasSVMContL5 = 2*(contPrecRecSVML5SelAllF(1).*contPrecRecSVML5SelAllF(2)./(sum(contPrecRecSVML5SelAllF)));

    FMeasSVMDiscr{k,1} = FMeasSVMDiscrA1;FMeasSVMDiscr{k,2} = FMeasSVMDiscrA2;FMeasSVMDiscr{k,3} = FMeasSVMDiscrA3;FMeasSVMDiscr{k,4} = FMeasSVMDiscrA4;FMeasSVMDiscr{k,5} = FMeasSVMDiscrA5;
    FMeasSVMDiscr{k,6} = FMeasSVMDiscrL1;FMeasSVMDiscr{k,7} = FMeasSVMDiscrL2;FMeasSVMDiscr{k,8} = FMeasSVMDiscrL3;FMeasSVMDiscr{k,9} = FMeasSVMDiscrL4;FMeasSVMDiscr{k,10} = FMeasSVMDiscrL5;
    FMeasSVMCont{k,1} = FMeasSVMContA1;FMeasSVMCont{k,2} = FMeasSVMContA2;FMeasSVMCont{k,3} = FMeasSVMContA3;FMeasSVMCont{k,4} = FMeasSVMContA4;FMeasSVMCont{k,5} = FMeasSVMContA5;
    FMeasSVMCont{k,6} = FMeasSVMContL1;FMeasSVMCont{k,7} = FMeasSVMContL2;FMeasSVMCont{k,8} = FMeasSVMContL3;FMeasSVMCont{k,9} = FMeasSVMContL4;FMeasSVMCont{k,10} = FMeasSVMContL5;

    % conf Matrices
    discrConfMatA1SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelA1SVM,TrueLabelDiscrAllSelA1SVM);discrConfMatA2SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelA2SVM,TrueLabelDiscrAllSelA2SVM);discrConfMatA3SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelA3SVM,TrueLabelDiscrAllSelA3SVM);discrConfMatA4SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelA4SVM,TrueLabelDiscrAllSelA4SVM);discrConfMatA5SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelA5SVM,TrueLabelDiscrAllSelA5SVM);
    discrConfMatL1SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelL1SVM,TrueLabelDiscrAllSelL1SVM);discrConfMatL2SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelL2SVM,TrueLabelDiscrAllSelL2SVM);discrConfMatL3SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelL3SVM,TrueLabelDiscrAllSelL3SVM);discrConfMatL4SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelL4SVM,TrueLabelDiscrAllSelL4SVM);discrConfMatL5SelAllF = determineConfMatrSVM(ResultLabelDiscrAllSelL5SVM,TrueLabelDiscrAllSelL5SVM);
    contConfMatA1SelAllF = determineConfMatrSVM(ResultLabelContAllSelA1SVM,TrueLabelContAllSelA1SVM);contConfMatA2SelAllF = determineConfMatrSVM(ResultLabelContAllSelA2SVM,TrueLabelContAllSelA2SVM);contConfMatA3SelAllF = determineConfMatrSVM(ResultLabelContAllSelA3SVM,TrueLabelContAllSelA3SVM);contConfMatA4SelAllF = determineConfMatrSVM(ResultLabelContAllSelA4SVM,TrueLabelContAllSelA4SVM);contConfMatA5SelAllF = determineConfMatrSVM(ResultLabelContAllSelA5SVM,TrueLabelContAllSelA5SVM);
    contConfMatL1SelAllF = determineConfMatrSVM(ResultLabelContAllSelL1SVM,TrueLabelContAllSelL1SVM);contConfMatL2SelAllF = determineConfMatrSVM(ResultLabelContAllSelL2SVM,TrueLabelContAllSelL2SVM);contConfMatL3SelAllF = determineConfMatrSVM(ResultLabelContAllSelL3SVM,TrueLabelContAllSelL3SVM);contConfMatL4SelAllF = determineConfMatrSVM(ResultLabelContAllSelL4SVM,TrueLabelContAllSelL4SVM);contConfMatL5SelAllF = determineConfMatrSVM(ResultLabelContAllSelL5SVM,TrueLabelContAllSelL5SVM);

    confMatSVMDiscr{k,1} = discrConfMatA1SelAllF;confMatSVMDiscr{k,2} = discrConfMatA2SelAllF;confMatSVMDiscr{k,3} = discrConfMatA3SelAllF;confMatSVMDiscr{k,4} = discrConfMatA4SelAllF;confMatSVMDiscr{k,5} = discrConfMatA5SelAllF;
    confMatSVMDiscr{k,6} = discrConfMatL1SelAllF;confMatSVMDiscr{k,7} = discrConfMatL2SelAllF;confMatSVMDiscr{k,8} = discrConfMatL3SelAllF;confMatSVMDiscr{k,9} = discrConfMatL4SelAllF;confMatSVMDiscr{k,10} = discrConfMatL5SelAllF;
    confMatSVMCont{k,1} = contConfMatA1SelAllF;confMatSVMCont{k,2} = contConfMatA2SelAllF;confMatSVMCont{k,3} = contConfMatA3SelAllF;confMatSVMCont{k,4} = contConfMatA4SelAllF;confMatSVMCont{k,5} = contConfMatA5SelAllF;
    confMatSVMCont{k,6} = contConfMatL1SelAllF;confMatSVMCont{k,7} = contConfMatL2SelAllF;confMatSVMCont{k,8} = contConfMatL3SelAllF;confMatSVMCont{k,9} = contConfMatL4SelAllF;confMatSVMCont{k,10} = contConfMatL5SelAllF;
    
end

