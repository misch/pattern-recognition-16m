function [ optC, optKernel, optAcc ] = crossValidateSVM( data, numClasses, k)
%CROSSALIDATESVM Optimize svm-parameters using cross validation
%   [optC, optCAcc] = crossValidateSVM(data, numClasses, k) apply k-fold
%                        cross validation on the specified dataset

% The values for C to test
C = [1,2,4,10,100,1000];

% Allocate memory to store the computed accuracies
accuracies = zeros(size(C,2),2);

% Divide data into k groups
cv = cvpartition(data(:,1), 'kfold', k);

% Do cross validation with rbf-kernel for the different C values
for p = 1:size(C,2)
    accuracy = 0;
    param_c = C(p);
    for i = 1:k
        % Get indices of training and test sets
        testIdx = cv.test(i);
        trainIdx = cv.training(i);
        
        % Train a svm model on the training set
        SVMModel = SVMTrain(data(trainIdx,:), numClasses, param_c, 'rbf');
        
        % Predict the test samples
        classes = classifySVM(SVMModel, data(testIdx,2:end), numClasses);
        
        % Compute the accuracy
        accur = classes == data(testIdx,1);
        succ = sum(accur==1);
        accuracy = accuracy + succ/size(accur,1);
    end
    
    % Compute and store average accuracy of the k classifications
    accuracies(p,1) = accuracy/k;
end

% Do cross validation with linear kernel for the different C values
for p = 1:size(C,2)
    accuracy = 0;
    param_c = C(p);
    for i = 1:k
        testIdx = cv.test(i);
        trainIdx = cv.training(i);
        SVMModel = SVMTrain(data(trainIdx,:), numClasses, param_c, 'linear');
        classes = classifySVM(SVMModel, data(testIdx,2:end), numClasses);
        accur = classes == data(testIdx,1);
        succ = sum(accur==1);
        accuracy = accuracy + succ/size(accur,1);
    end
    accuracies(p,2) = accuracy/k;
end

% Find indices of highest accuracy
[~,ind] = max(accuracies(:));
[r,c] = ind2sub(size(accuracies),ind);

% Get and return kernel and C value that gave best accuracy 
if (c==1) 
    optKernel = 'rbf';
elseif (c==2) 
    optKernel = 'linear'; 
end
optC = C(r);
optAcc = accuracies(r,c);