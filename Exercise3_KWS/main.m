% main script for the keyword spotting task

%% Pre-processing: get and binarize word images
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