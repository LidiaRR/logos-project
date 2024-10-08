% Este archivo ejecuta una prueba con todas las imágenes que tenemos,
% excepto las de complex_background

close all
%clear

[image_paths, response] = getImagePathsAndResponse();

data = [];

for i = 1:length(image_paths)
    im = imread(image_paths(i));
    im_grey = im2gray(im);
    im_pre = imresize(im_grey,[256,256]);
    %im_pre = preprocess_image(im_grey);
   
    % Tipos de descriptores que usamos
    %houghLines = houghDescriptors_lines(im_pre);
    %houghCircles = houghDescriptors_circles(im_pre);
    %[hog, vis] = extractHOGFeatures(im_pre, 'CellSize', [64,64]);
    %figure, plot(vis), title('cell 64x64')
    desc = getAllDescriptors(im_pre);

    data = [data desc];
end

%%

im = imread('../my_images/dog2.png');
im_grey = im2gray(im);
im_pre = imresize(im_grey,[256,256]);
   
% Tipos de descriptores que usamos
houghLines = houghDescriptors_lines(im_pre);
houghCircles = houghDescriptors_circles(im_pre);
[hog, vis] = extractHOGFeatures(im_pre, 'CellSize', [64,64]);
%figure, plot(vis), title('cell 64x64')
desc = [houghLines ; houghCircles; hog'];

[yfit,scores] = trainedModel.predictFcn(desc);

%%

trainedModel = trainClassifierSVM(data, response);

%%

im = imread('../my_images/motorola3.jpg');
[prediction, scores, result] = makePrediction(im, trainedModel);