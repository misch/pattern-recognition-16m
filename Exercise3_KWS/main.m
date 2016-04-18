% main script for the keyword spotting task
%% Pre-processing: get and binarize word images
boundingBoxFolder = 'data/ground-truth/locations/';
inputImagesFolder = 'data/images/'
outputFolder = 'data/word_images/';

getWordImages(boundingBoxFolder,inputImagesFolder,outputFolder);