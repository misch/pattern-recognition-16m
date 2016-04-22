% pre-processing:
% - get and binarize word images: will create folders word_images and
% word_images_binary
% - create features and normalize them: will create file dataset.mat

%% get and binarize word images
% get word images
boundingBoxFolder = 'data/ground-truth/locations/';
inputImagesFolder = 'data/images/'
outputFolder = 'data/word_images/';

getWordImages(boundingBoxFolder,inputImagesFolder,outputFolder);

% binarize
inputImagesFolder = 'data/word_images/';
outputFolder = 'data/word_images_binary/';
threshold = 0.7;

binarizeImages(inputImagesFolder, outputFolder,threshold);

%% Create features
% A word is a sequence of feature vectors
binWordImagesFolder = 'data/word_images_binary/';
allWordFiles = dir([binWordImagesFolder,'*.png'])';

n_files = length(allWordFiles);
dataset = struct(   'pageNo',zeros(n_files,1),...
                    'lineNo',zeros(n_files,1),...
                    'wordNo',zeros(n_files,1),...
                    'timeseries',[],...
                    'mu',[],...
                    'sigma',[]);
                
wholeFeatureMatrix = []; % needed for later calculation of normalization factors

for ii = 1:n_files
    filename = allWordFiles(ii).name;
    wordImg = im2double(imread([binWordImagesFolder,filename]));

    [row, col] = find(~wordImg);
    lowerContour = accumarray(col,row,[size(wordImg,2) 1],@max);
    upperContour = accumarray(col,row,[size(wordImg,2) 1],@min);

    fractionOfBlackPixels = ((sum(~wordImg))/size(wordImg,1))';

    gradientLowerContour = [lowerContour(2:end) - lowerContour(1:end-1); 0];
    gradientUpperContour = [upperContour(2:end) - upperContour(1:end-1); 0];

    ts = timeseries([lowerContour,upperContour,fractionOfBlackPixels,gradientLowerContour,gradientUpperContour],1:size(wordImg,2));
    wordInfo = regexp(filename,'(?<pageNo>\d+)-(?<lineNo>\d+)-(?<wordNo>\d+)','names');
    
    dataset.pageNo(ii) = str2num(wordInfo.pageNo);
    dataset.lineNo(ii) = str2num(wordInfo.lineNo);
    dataset.wordNo(ii) = str2num(wordInfo.wordNo);
    dataset.timeseries = cat(1,dataset.timeseries,ts);
    
    wholeFeatureMatrix = cat(1,wholeFeatureMatrix,dataset.timeseries(ii).Data);
end

% get normalization factors
[~,mu,sigma] = zscore(wholeFeatureMatrix);
dataset.mu = mu;
dataset.sigma = sigma;

% normalize data
for ii = 1:length(dataset.timeseries)
    dat = dataset.timeseries(ii).Data;
    dataset.timeseries(ii).Data = (dat-repmat(mu,size(dat,1),1))./(repmat(sigma,size(dat,1),1));
end

%%
save('data/dataset.mat','dataset','-v7.3');