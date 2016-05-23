function perf = evaluatePerformance(labels, dissimilarities, groundTruth)
% labels: cell array storing the predicted classes 'f' or 'g' as nx1 array
% dissimilarities: nx1 vector storing the distances for each test signature
% groundTruth: cell matrix storing the true classes 'f', 'g' in 3rd column

% Compute mean average-precision
groundTruth(:,4)=num2cell(dissimilarities);
groundTruth(:,5)=labels;
groundTruth = sortrows(groundTruth,[1,4,2]);

writers = unique(groundTruth(:,1));
nWriters = length(writers);
avgPrecisions = zeros(1,nWriters);
for i = 1:nWriters
    indices = find(strcmp(groundTruth(:,1),writers(i)));
    nSignatures = length(indices);
    precision = zeros(1,sum(strcmp(groundTruth(indices,3),'g')));
    count = 0;
    for j = 1:nSignatures
        if (strcmp(groundTruth(indices(j),3),'g'))
            count = count+1;
            precision(count) = count/j;
        end
    end
    avgPrecisions(i) = mean(precision);
end
perf = mean(avgPrecisions);

% output confusion matrix
%confusionmat(groundTruth(:,3),labels)

% compute accuracy
%perf = sum(strcmp(labels,groundTruth(:,3))) / length(labels);
