%% Load test and training data and the ground truth data

trainingSet = loadData('data/enrollment/');
verificationSet = loadData('data/verification/');
groundTruth = loadGroundTruth('data/verification-gt.txt');


%% Compute dissimilarity of the signatures in the verification set

% estimate appropriate thresholds for each writer
trainingSet = computeThreshold(trainingSet);

% classify verification samples
[labels,dissimilarities] = verifySignatures(trainingSet, verificationSet);


%% Evaluate classifications

accuracy = evaluatePerformance(labels, dissimilarities, groundTruth);
accuracy


%% output dissimilarities to file for evaluation 

outputResults(groundTruth, labels, dissimilarities);
