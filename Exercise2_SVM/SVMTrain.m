function [ model ] = SVMTrain( data , numClasses )
%SVMTRAIN Train a multiclass SVM-classifier on the data
%   [model] = SVMTrain(data, numClasses) trains multiclass svm-classifers
%               on the data with numClasses different classes

% Build as many binary svm-classifiers as we have classes (one-vs-all)
% (first model classifies 0 vs not 0, second classifies 1 vs not 1, etc)
model = cell(numClasses,1);
for i = 1:numClasses
    model{i} = fitcsvm(data(:,2:end), data(:,1) == (i-1),...
        'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');
end
end

