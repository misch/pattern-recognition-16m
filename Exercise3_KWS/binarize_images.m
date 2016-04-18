% Script binarize_images: Binarize the images of a folder using simple
% thresholding.

%% Read all images
imagesPath = 'data/images/';

[files] = dir([imagesPath,'*.jpg']);
images = cell(length(files),1);
for ii = 1:length(files)
    images{ii} = im2double(imread([imagesPath,files(ii).name]));
end

%% Binarize them (simple thresholding)
threshold = 0.7;
binaryImages = cellfun(@(x) x>threshold,images,'UniformOutput',false);

% Save the images to folder.
binaryPath = 'data/binary-images/';
if ~exist(binaryPath,'dir')
    mkdir(binaryPath);
end

for ii = 1:length(files)
   imwrite(binaryImages{ii},[binaryPath,files(ii).name]);
end