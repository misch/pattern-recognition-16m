function [precision, recall] = evaluatePerformance(keyword, results, validSet)
%EVALUATEPERFORMANCE compute precision and recall for the detected words 
%    Input: 
%       keyword: string storing the query word
%       results: mx1 vector storing the indices of the retrieved words
%       validSet: dataset in which we searched the keyword
%    Return: 
%       precision: how many of the retrieved words are correct
%       recall: how many of the query word occurrences did we find

% compute precision
relevant = 0;
retrieved = length(results);
for i = 1:retrieved
    % check if retrieved word is equal to the query word
    if (strcmp(keyword, validSet.transcription{results(i)}))
        relevant = relevant + 1;
    end
end
if (retrieved == 0)
    precision = 0;
else
    precision = relevant/retrieved;
end

% compute recall
retrieved = relevant;
relevant = 0;
for i = 1:size(validSet.transcription,1)
    % count the occurrences of the query word in the validation data
    if (strcmp(keyword, validSet.transcription{i}))
        relevant = relevant + 1;
    end
end
if (relevant == 0)
    recall = 0;
else
    recall = retrieved/relevant;
end

end