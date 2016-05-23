function dataSet = computeThreshold(dataSet)

nSignatures = size(dataSet.timeseries,1);

for i = 1:nSignatures
    if (dataSet.threshold(i) == 0)
        % get the writer of the current signature
        writerID = dataSet.writerID(i);

        % get this writers genuine signatures from the training set
        indices = find(strcmp(dataSet.writerID,writerID));

        % compute the distances between each pair of genuine signatures of  
        % this writer. The average between maximal distance and mean 
        % distance will be the threshold
        nWriterSignatures = length(indices);
        nPairs = nWriterSignatures * (nWriterSignatures-1) * 0.5;
        distances = zeros(nPairs,1);
        idx = 1;
        for m = 1:(nWriterSignatures-1)
            for n = (m+1):nWriterSignatures
                signature_m = dataSet.timeseries(indices(m)).Data;
                signature_n = dataSet.timeseries(indices(n)).Data;
                distances(idx) = dtwDistance(signature_m, signature_n);
                idx = idx+1;
            end
        end
        threshold = (max(distances)+mean(distances))*0.5;
        dataSet.threshold(indices) = threshold;
    end
end

end