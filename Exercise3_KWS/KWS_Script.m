%% Preprocess the data if not already done

if (~exist('data/word_images/','dir') ...
        || ~exist('data/word_images_binary/','dir') ...
        || ~exist('data/dataset.mat'))
    preprocessing;
else
    load('data/dataset.mat');
end

%% Split data into training and validation set

trainPages = importdata('data/task/train.txt');    
validationPagses = importdata('data/task/valid.txt');
[trainingSet, validationSet] = partitionData(trainPages,validationPagses,dataset);

%% Get keyword to spot in the validation set

keyword = 'O-r-d-e-r-s';

%% Spot given keyword in the validation set

[foundWords,~] = spotKeyword(keyword,trainingSet,validationSet,10);

%% Show the results

keyword
validationSet.transcription(foundWords)

%% Evaluate performance

[precision, recall, auc] = evaluatePerformance(keyword,foundWords,validationSet);
