%% Read svg file
bb_path = 'data/ground-truth/locations/';

fileID = fopen([bb_path,'270.svg']);

bounding_boxes_raw = textscan(fileID,'%s','Delimiter','\n');
bounding_boxes_raw = bounding_boxes_raw{1}(3:end-1);
fclose(fileID); 

%% Parse svg file
clear collected_polygons;
collected_polygons(length(bounding_boxes_raw)).id = [];

for n_poly = 1:length(bounding_boxes_raw)
    box_str = bounding_boxes_raw(n_poly);
    out = regexp(box_str,'[ML] (?<x>\d*\.\d*) (?<y>\d*\.\d*)','names');
    id = regexp(box_str,'id="(\w+-\w+-\w+)"','tokens');
    
    x_coords = arrayfun(@(ar) str2double(ar.x), out{1},'UniformOutput',false);
    y_coords = arrayfun(@(ar) str2double(ar.y), out{1},'UniformOutput',false);
    
    collected_polygons(n_poly).id = id{1}{1};    
    collected_polygons(n_poly).polygoncoordinates = [[x_coords{:}]', [y_coords{:}]'];
end

%% Get word image
test_poly = collected_polygons(4);

img = im2double(imread('data/images/270.jpg'));

mask = roipoly(img,test_poly.polygoncoordinates(:,1),test_poly.polygoncoordinates(:,2));

min_x = min(test_poly.polygoncoordinates(:,1));
max_x = max(test_poly.polygoncoordinates(:,1));
min_y = min(test_poly.polygoncoordinates(:,2));
max_y = max(test_poly.polygoncoordinates(:,2));
masked = mask.*img + ~mask;
word_img = masked(min_y:max_y,min_x:max_x);
imtool(mask.*img);
imtool(word_img);
