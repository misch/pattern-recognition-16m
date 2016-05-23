%% Load test and training data and the ground truth data

trainingSet = loadData('data/enrollment/');
verificationSet = loadData('data/verification_small/');
groundTruthAvailable = false;
if (exist('data/verification-gt.txt'))
    groundTruth = loadGroundTruth('data/verification-gt_small.txt');
    groundTruthAvailable = true;
end


%% Compute dissimilarity of the signatures in the verification set

% estimate appropriate thresholds for each writer
trainingSet = computeThreshold(trainingSet);

% classify verification samples
[labels,dissimilarities] = verifySignatures(trainingSet, verificationSet);


%% Evaluate classifications

if (groundTruthAvailable==true)
    meanAvgPrec = evaluatePerformance(labels, dissimilarities, groundTruth);
    meanAvgPrec
end


%% output dissimilarities to file for evaluation 

outputResults(verificationSet, dissimilarities);
