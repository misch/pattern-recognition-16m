function [train, test] = partitionData(trainPages,testPages,dataset)
%PARTITIONDATA Split data into training set and validation set
%    Input: 
%       dataset: dataset storing features (and more) for all words
%    Return: 
%       train: subset of the dataset we use as training data
%       test: subset of the dataset we use as test data

% Extract entries from the dataset that belong to the training pages
indices = zeros(size(dataset.pageNo,1),1);
for i = 1:size(trainPages,1)
    indices = indices + (dataset.pageNo == trainPages(i));
end
indices = logical(indices);

% Create struct storing the training data
train = struct('pageNo',dataset.pageNo(indices),...
                    'lineNo',dataset.lineNo(indices),...
                    'wordNo',dataset.wordNo(indices),...
                    'filename',{dataset.filename(indices)},...
                    'transcription',{dataset.transcription(indices)},...
                    'timeseries',dataset.timeseries(indices));

% Extract entries from the dataset that belong to the test pages
indices = zeros(size(dataset.pageNo,1),1);
for i = 1:size(testPages,1)
    indices = indices + (dataset.pageNo == testPages(i));
end
indices = logical(indices);

% Create struct storing the test data
test = struct('pageNo',dataset.pageNo(indices),...
                    'lineNo',dataset.lineNo(indices),...
                    'wordNo',dataset.wordNo(indices),...
                    'filename',{dataset.filename(indices)},...
                    'transcription',{dataset.transcription(indices)},...
                    'timeseries',dataset.timeseries(indices));
                
end