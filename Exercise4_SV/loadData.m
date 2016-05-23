function [ dataset ] = loadData(dataFolder)

allSignatureFiles = dir([dataFolder,'*.txt'])';
n_files = length(allSignatureFiles);
dataset = struct(   'writerID',{cell(n_files,1)},...
                    'filename',{cell(n_files,1)},...
                    'threshold',zeros(n_files,1),...
                    'timeseries',[]);

for ii = 1:n_files
    % read the data
    filename = allSignatureFiles(ii).name;
    data = importdata([dataFolder,filename]);
    
    % compute velocities in x and y
    data(2:end,end+1)=(data(2:end,2)-data(1:(end-1),2))./(data(2:end,1)-data(1:(end-1),1));
    data(2:end,end+1)=(data(2:end,3)-data(1:(end-1),3))./(data(2:end,1)-data(1:(end-1),1));
    
    % data standardization
    data = zscore(data);
    
    % create timeseries object
    ts = timeseries(data(:,[2,3,4,end-1,end]), 1:size(data,1));
    
    % extract writerID from filename
    filename = char(filename);
    signatureInfo = regexp(filename,'(?<writerID>\d+)-.','names');
    
    % store the data in the dataset struct
    dataset.writerID{ii} = signatureInfo.writerID;
    dataset.filename{ii} = filename(1:end-4);
    dataset.timeseries = cat(1,dataset.timeseries,ts);
end           