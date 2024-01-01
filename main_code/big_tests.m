% Este archivo ejecuta una prueba con todas las imágenes que tenemos,
% excepto las de complex_background

close all
clear

[image_paths, response] = getImagePathsAndResponse();

data = [];

for i = 1:length(image_paths)
    im = imread(image_paths(i));
    im_grey = im2gray(im);
    im_pre = preprocess_image(im_grey);
   
    % Tipos de descriptores que usamos
    houghLines = houghDescriptors_lines(im_pre);
    houghCircles = houghDescriptors_circles(im_pre);
    [hog] = extractHOGFeatures(im_pre, 'CellSize', [64,64]);
    desc = [houghLines ; houghCircles; hog'];

    data = [data desc];
end