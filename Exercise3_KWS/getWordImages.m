function [] = getWordImages(boundingBoxFolder, inputImagesFolder, outputFolder)
%GETWORDIMAGES Create word images from given bounding boxes.

files = dir([boundingBoxFolder,'*.svg']);
for file = files'
    %% Read svg file
    fileID = fopen([boundingBoxFolder,file.name]);

    bounding_boxes_raw = textscan(fileID,'%s','Delimiter','\n');
    bounding_boxes_raw = bounding_boxes_raw{1}(3:end-1);
    fclose(fileID); 

    %% Parse svg file to get coordinates of polygons
    collected_polygons(length(bounding_boxes_raw)).id = [];

    for n_poly = 1:length(bounding_boxes_raw)
        box_str = bounding_boxes_raw(n_poly);
        out = regexp(box_str,'[ML] (?<x>\d*\.\d*) (?<y>\d*\.\d*)','names');
        id = regexp(box_str,'id="(\w+-\w+-\w+)"','tokens');

        % Convert weird arrays of cells to normal arrays and store them to
        % struct
        x_coord = arrayfun(@(ar) str2double(ar.x), out{1},'UniformOutput',false);
        y_coord = arrayfun(@(ar) str2double(ar.y), out{1},'UniformOutput',false);
        collected_polygons(n_poly).id = id{1}{1}{1};    
        collected_polygons(n_poly).x_coord = [x_coord{:}]';
        collected_polygons(n_poly).y_coord = [y_coord{:}]';
    end

    %% from gathered polygon coordinates, get the word images
    imgfile = [file.name(1:end-3),'jpg'];
    img = im2double(imread([inputImagesFolder,imgfile]));

    if ~exist(outputFolder,'dir')
        mkdir(outputFolder);
    end

    for n_word = 1:length(collected_polygons)
        p = collected_polygons(n_word);

        mask = roipoly(img,p.x_coord,p.y_coord);
        masked = mask.*img + ~mask;

        min_x = round(min(p.x_coord)); max_x = round(max(p.x_coord));
        min_y = round(min(p.y_coord)); max_y = round(max(p.y_coord));
        
        try
            word_img = masked(min_y:max_y , min_x:max_x);
        catch
            disp('whaaat')
        end

        imwrite(word_img,[outputFolder,p.id,'.png']);
    end
    clear collected_polygons;
end
