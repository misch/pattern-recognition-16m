function output = outputResults(data, labels, dissimilarities)

% add labels and dissimilarities to the data, so we can sort it
data(:,4)=num2cell(dissimilarities);
data(:,5)=num2cell(labels);
data = sortrows(data,[1,4,2]);

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
    output(row,col) = data(i,4);
    col = col+1;
end

% write data to txt-file
table = cell2table(output);
writetable(table,'data/results.txt','WriteRowNames',false,'WriteVariableNames',false)

end