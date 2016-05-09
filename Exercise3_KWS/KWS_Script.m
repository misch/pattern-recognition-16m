%% Preprocess the data if not already done

if (~exist('data/word_images/','dir') ...
        || ~exist('data/word_images_binary/','dir') ...
        || ~exist('data/dataset.mat'))
    preprocessing;
else
    load('data/dataset.mat');
end

%% Split data into training and validation set

trainFile = 'data/task/train.txt';
validFile = 'data/task/valid.txt';
[trainingSet, validationSet] = partitionData(trainFile,validFile,dataset);

%% Get keyword to spot in the validation set
% TODO: For now I just select a word-transcription from the keywords-file 

queries = textread('data/task/keywords.txt','%s');
%keyword = queries{23};
keyword = 'O-r-d-e-r-s';

%% Spot given keyword in the validation set
% TODO: improve accuracy...

foundWords = spotKeyword(keyword,trainingSet,validationSet);

%% Show the results
% TODO: For now I just output the transcriptions of the keyword and 
% the spotted words

keyword
validationSet.transcription(foundWords)

%% Evaluate performance
% TODO: I'm not sure what performance measure we should use

[precision, recall] = evaluatePerformance(keyword,foundWords,validationSet)
