function [ classif ] = classifySVM( model, data, numClasses )
%CLASSIFYSVM Classify samples using multiclass svm-classifiers
%   [classif] = classifySVM(model, data, numClasses) classify the samples 
%                   in the data using the binary svm-models

% Classify the test samples using one-vs-all multiclass svm
probabilities = zeros(size(data,1),numClasses);
for i = 1:numClasses
    % classify test samples using the i-th svm-model. 'score' gets the 
    % probability for each sample that it belongs to class i-1 
    [~,score] = predict(model{i},data);
    probabilities(:,i) = score(:,2);
end

% index of largest element per row (minus one) is the predicted label
% (minus one since we have indices 1-10 but labels 0-9)
[~,classif] = max(probabilities,[],2);
classif = classif-1;

end

