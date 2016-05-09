function foundWords = spotKeyword(keyword, trainingSet, validationSet, nResults)
%SPOTKEYWORD spot a keyword in the validation data 
%    Input: 
%       keyword: transcription of the keyword to spot
%       trainingSet: dataset storing the training data
%       validationSet: dataset in which we searche the keyword
%    Return: 
%       foundWords: vector storing the indices of the spotted words

% find all occurrences of the keyword in the training set using the 
% transcriptions and store their indices
keywordIndices = [];
for i = 1:size(trainingSet.transcription,1)
    if (strcmp(keyword, trainingSet.transcription{i}))
        keywordIndices(end+1) = i;
    end
end

% get nr of words in the validation set 
nWords = size(validationSet.timeseries,1);

% get nr of occurrences of the keyword in the training set (limit it to 4
% for performance reasons)
% Note: Setting it to 1, i.e. Using just one image, often gives the best results.
nKeywordImages = 1;%min(4,length(keywordIndices));

% initialize vector storing the distances between each word and the keyword
% first column: index of the word, second column: dtw-distance to keyword
distances = (1:nWords)';
distances(:,2) = 0;
tmpDist = zeros(nKeywordImages,1);

for i = 1:nWords
    % compute for each word the distance to the different images of the 
    % keyword, and sum them up to get the final word-keyword-distance
    % (or take the mean, or the min. Have to test what works best)
    for j = 1:nKeywordImages
        keywordData = trainingSet.timeseries(keywordIndices(j)).Data;
        tmpDist(j) = dtwDistance(keywordData, validationSet.timeseries(i).Data);
    end
    distances(i,2) = sum(tmpDist);
end

% sort the words by their dtw-distance to the keyword
distances = sortrows(distances,2);

% return the nResults words with smallest distances as the spotting result
% TODO: Use a threshold
foundWords = distances(1:nResults,1);