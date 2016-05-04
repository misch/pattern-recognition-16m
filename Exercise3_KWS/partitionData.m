function [train, valid] = partitionData(trainFile,validFile,dataset)
%PARTITIONDATA Split data into training set and validation set
%    Input: 
%       trainFile: file storing the pages used as training data
%       validFile: file storing the pages used as validation data
%       dataset: dataset storing features (and more) for all words
%    Return: 
%       train: subset of the dataset we use as training data
%       valid: subset of the dataset we use as validation data

% Get pages we use as training data
pages = importdata('data/task/train.txt');

% Extract entries from the dataset that belong to the training pages
indices = zeros(size(dataset.pageNo,1),1);
for i = 1:size(pages,1)
    indices = indices + (dataset.pageNo == pages(i));
end
indices = logical(indices);

% Create struct storing the training data
train = struct('pageNo',dataset.pageNo(indices),...
                    'lineNo',dataset.lineNo(indices),...
                    'wordNo',dataset.wordNo(indices),...
                    'transcription',{dataset.transcription(indices)},...
                    'timeseries',dataset.timeseries(indices));
     
% Get pages we use as validation data           
pages = importdata('data/task/valid.txt');

% Extract entries from the dataset that belong to the validation pages
indices = zeros(size(dataset.pageNo,1),1);
for i = 1:size(pages,1)
    indices = indices + (dataset.pageNo == pages(i));
end
indices = logical(indices);

% Create struct storing the validation data
valid = struct('pageNo',dataset.pageNo(indices),...
                    'lineNo',dataset.lineNo(indices),...
                    'wordNo',dataset.wordNo(indices),...
                    'transcription',{dataset.transcription(indices)},...
                    'timeseries',dataset.timeseries(indices));             
end