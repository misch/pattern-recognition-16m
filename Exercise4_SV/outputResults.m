function output = outputResults(dataSet, dissimilarities)

% create dataset storing writerID, signatureID and computed dissimilarity
data(:,1)=dataSet.writerID;
data(:,2)=dataSet.filename;
data(:,3)=num2cell(dissimilarities);
data = sortrows(data,[1,3,2]);

% bring data in desired form:
% user1, signature_i, dissimilarity_i, signature_j, dissimilarity_j, ...
% user2, signature_m, dissimilarity_m, signature_n, dissimilarity_n, ...
% ...
output = cell(0);
col=2;
row = 1;
writer = data{1,1};
output(1,1) = data(1,1);
for i = 1:size(data,1);
    if (strcmp(writer,data{i,1}) == 0)
        writer = data{i,1};
        row = row+1;
        col = 1;
        output(row,col) = data(i,1);
        col = col+1;
    end
    output(row,col) = data(i,2);
    col = col+1;
    output(row,col) = data(i,3);
    col = col+1;
end

% write data to csv-file
table = cell2table(output);
writetable(table,'../resultFiles/signatures_result.csv','WriteRowNames',false,'WriteVariableNames',false)

end