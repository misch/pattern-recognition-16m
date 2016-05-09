function [final_precision, final_recall, auc] = evaluatePerformance(keyword, results, validSet)
%EVALUATEPERFORMANCE compute precision and recall for the detected words 
%    Input: 
%       keyword: string storing the query word
%       results: mx1 vector storing the indices of the retrieved words
%       validSet: dataset in which we searched the keyword
%    Return: 
%       precision: how many of the retrieved words are correct
%       recall: how many of the query word occurrences did we find
%       auc: the area under curve. A high value means: "with a well-chosen
%       number of retrieved results, we can achieve good results." 0.5 is
%       the worst value and means random decisions

retrieved = length(results);
correct_word = zeros(1,retrieved);
for i = 1:retrieved
    % check if retrieved word is equal to the query word
    if (strcmp(keyword, validSet.transcription{results(i)}))
        correct_word(i) = 1;
    end
end

sorted_predicted_labels = correct_word'; % if we ever return scores instead of sorted results, here would be the place to sort them
positives = sorted_predicted_labels == 1;

% Plot Precision-Recall and ROC curves over time - like this we can better
% decide how many results should be returned, as the Tradeoffs are
% visualized.

    % Precision: TP / (TP + FP) = TP/#{all predicted positives}
    % What fraction of the predicted positives are actually positive?
    precision = cumsum(positives)./(1:retrieved)'; % is less than 1, if the number of (actual) positives are found (hopefully, recall is 1 then)

    % Recall = TPR (true positive rate) = TP / (TP + FN) = TP/#{positives} 
    % How many of the positive test labels are actually found?
    recall = cumsum(positives)/sum(positives); % is less than 1, if not yet all points are considered (hopefully, precision is 1 then)

    figure;
    plot(recall,precision,'LineWidth',2);
    axis( [0 1 0 1] );
    title('Precision-Recall curve');
    xlabel('Recall');
    ylabel('Precision');

    % Receiver Operating Characteristic curve (ROC)
    % FPR = FP / (FP + TN) = FP/#{negatives}
    false_positive_rate = cumsum(~positives) ./ sum(~positives)';
    auc = sum(recall)/length(recall);
    
    figure;
    plot(false_positive_rate,recall, 'LineWidth',2);
    axis( [0 1 0 1] );
    title(sprintf('ROC curve (AUC = %f)',auc));
    xlabel('False Positive Rate');
    ylabel('True Positive Rate (Recall)');

    final_precision = precision(end);
    final_recall = recall(end);
    
end


