function [] = binarizeImages(inputImagesFolder, outputFolder,threshold)
%BINARIZEIMAGES binarize the images of a folder using simple thresholding

%% Throw error, if folder doesn't exist
if (~exist(inputImagesFolder,'dir'))
    error(['directory ', inputImagesFolder,' could not be found.']);
end

%% Read all images
[files] = dir([inputImagesFolder,'*.png']);
images = cell(length(files),1);
for ii = 1:length(files)
    images{ii} = im2double(imread([inputImagesFolder,files(ii).name]));
end

%% Binarize them (simple thresholding)

binaryImages = cellfun(@(x) x>threshold,images,'UniformOutput',false);

% Save the images to folder.
if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

for ii = 1:length(files)
   imwrite(binaryImages{ii},[outputFolder,files(ii).name]);
end
disp(['Saved binary images to ',outputFolder]);