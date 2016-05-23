function [ labels, dissimilarities ] = verifySignatures(trainingSet, verificationSet)

% get nr of signatures in the data sets
nSignatures = size(verificationSet.timeseries,1);
nTrainSignatures = size(trainingSet.timeseries,1);

% initialize vector storing the distances of each signature to the users
% genuine signature
dissimilarities = zeros(nSignatures,1);
labels = zeros(nSignatures,1);

for i = 1:nSignatures
    % get the writer of the current signature
    writerID = verificationSet.writerID(i);
    
    % get this writers genuine signatures from the training set
    indices = find(strcmp(trainingSet.writerID,writerID));
    
    % compute for each signature the distance to the 5 given signatures of 
    % the user, and take the min to get the final dissimilarity
    tmpDist = zeros(length(indices),1);
    for j = 1:length(indices)
        signatureData = trainingSet.timeseries(indices(j)).Data;
        tmpDist(j) = dtwDistance(signatureData, verificationSet.timeseries(i).Data);
    end
    dissimilarities(i) = mean(tmpDist);
    
    % determine the label of the signature (genuine or forgery)
    threshold = trainingSet.threshold(indices(1));
    if (dissimilarities(i) < threshold)
        labels(i) = 'g';
    else
        labels(i) = 'f';
    end
end

labels = char(labels);
labels = cellstr(labels);

end