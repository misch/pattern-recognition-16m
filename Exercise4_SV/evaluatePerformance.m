function perf = evaluatePerformance(labels, dissimilarities, groundTruth)
% labels: cell array storing the predicted classes 'f' or 'g' as nx1 array
% dissimilarities: nx1 vector storing the distances for each test signature
% groundTruth: cell matrix storing the true classes 'f', 'g' in 3rd column

% output confusion matrix
confusionmat(groundTruth(:,3),labels)

% compute accuracy
perf = sum(strcmp(labels,groundTruth(:,3))) / length(labels);
