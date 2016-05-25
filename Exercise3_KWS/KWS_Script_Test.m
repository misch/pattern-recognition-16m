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
trainPages = [trainPages;importdata('data/task/valid.txt')];
testPages = importdata('data/task/test.txt');
[trainingSet, testSet] = partitionData(trainPages,testPages,dataset);

%% Search keyword in the validation set 

queries = textread('data/task/keywords.txt','%s');
output = cell(0,0);
for i = 1:size(queries,1)
    keyword = queries{i};
    [foundWords, distances] = spotKeyword(keyword,trainingSet,testSet,size(testSet.filename,1));
    %[keyword,testSet.transcription(foundWords(1:7))']
    result = [testSet.filename(foundWords),num2cell(distances)]';
    result = result(:)';
    result = [cellstr(keyword),result(:)'];
    output(i,:) = result;
end

%% Write results to file
table = cell2table(output);
writetable(table,'../resultFiles/kws_result.csv','WriteRowNames',false,'WriteVariableNames',false);
