function [ dataset ] = loadData(dataFolder)

allSignatureFiles = dir([dataFolder,'*.txt'])';
n_files = length(allSignatureFiles);
dataset = struct(   'writerID',zeros(n_files,1),...
                    'filename',{cell(n_files,1)},...
                    'threshold',zeros(n_files,1),...
                    'timeseries',[]);

for ii = 1:n_files
    filename = allSignatureFiles(ii).name;
    data = importdata([dataFolder,filename]);
    data = zscore(data);
    ts = timeseries(data(:,2:4), 1:size(data,1));
    wordInfo = regexp(filename,'(?<writerID>\d+)-.','names');
    
    dataset.writerID(ii) = str2num(wordInfo.writerID);
    dataset.filename{ii} = filename;
    dataset.timeseries = cat(1,dataset.timeseries,ts);
end           