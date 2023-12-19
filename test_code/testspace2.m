%% Clasificación apple vs hp con 20 descriptores de fourier de la componente de más area

images = ["apple\2.jpg", "apple\23.jpg", "apple\14.jpg", "apple\22.jpg", "apple\50.jpg", "apple\34.jpg",...
    "hp\77.jpg", "hp\78.jpg", "hp\80.jpg", "hp\10.jpg", "hp\23.jpg", "hp\27.jpg"];
data = [];
response = ["apple","apple","apple","apple","apple","apple","hp","hp","hp","hp","hp","hp"];
maxDescriptorSize = 0;

for i = 1:12
    im = imread(images(i));
    im_bw = im2bw(im);
     if i ~= 2 && i ~= 1
        im_bw = ~im_bw;
    end

    %figure, imshow(im_bw)

    % Need to do preprocessing

    labelIm = bwlabel(im_bw);
    dades = regionprops(im_bw, 'all');
    [~,indexMaxArea] = max([dades.Area]);

    figure, imshow(im_bw == indexMaxArea)

    desc = fourierDescriptors(labelIm == indexMaxArea);
    data = [data desc];
end

%% Clasificación motorola vs IBM con 6 rectas encontradas con Hough

images = ["motorola\1.jpg", "motorola\2.jpg", "motorola\3.jpg", "motorola\4.jpg", "motorola\5.jpg", "motorola\86.jpg",...
    "IBM\2.jpg", "IBM\3.jpg", "IBM\4.jpg", "IBM\7.jpg", "IBM\8.jpg", "IBM\9.jpg"];
response = ["motorola","motorola","motorola","motorola","motorola","motorola","ibm","ibm","ibm","ibm","ibm","ibm"];
data = [];
for i = 1:12
    im = imread(images(i));
    im_bw = rgb2gray(im);
    desc = descriptorsHough(im_bw);
    data = [data desc];
end

%% Preprocesado de imágenes: (los paths estan puestos para mi maquina que es linux, en windows las barras van al reves)
images_preprocess = ["./apple/2.jpg", "./apple/64.jpg", "./apple/10.jpg", "./apple/13.jpg", "./apple/16.jpg", "./apple/59.jpg",...
    "./apple/23.jpg", "./apple/14.jpg", "./apple/22.jpg", "./apple/50.jpg", "./apple/34.jpg", "./apple/35.jpg", "./apple/25.jpg",...
    "./apple/54.jpg", "./apple/65.jpg", "./apple/29.jpg", "./apple/61.jpg", "./hp/77.jpg", "./hp/78.jpg", "./hp/80.jpg",... 
    "./hp/10.jpg", "./hp/23.jpg", "./hp/27.jpg"];

[~, num_imgs] = size(images_preprocess);

for i = 1:1
    borders = preprocess_image(images_preprocess(i));
    figure, imshow(borders);
end

borders = preprocess_image("./apple/43.jpg");
figure, imshow(borders);

%% 
close all
%borders = preprocess_image("Apple\24.jpg");

im = imread('Apple\59.jpg');
im_grey = im2gray(im);
ee = strel('disk', 1);
grad = imsubtract(imdilate(im_grey,ee),im_grey);
figure,imshow(grad,[]),title('gradiente morfológico')

%% 
close all
im = imread('Intel\7.jpg');
figure,imshow(im),title('original image')
im_grey = im2gray(im);
%im_grey = imadjust(imcomplement(im_grey));
im_grey = imadjust(im_grey);
figure,imshow(im_grey),title('adjusted image')
mark = im_grey;
mark(2:end-1,2:end-1) = 0;
rec = imreconstruct(mark,im_grey);
figure,imshow(rec),title('imagen reconstruida'),impixelinfo
th = graythresh(rec);
im_bw = im2bw(rec,th);
%mark2 = im_bw;
%mark2(2:end-1,2:end-1) = 0;
%rec2 = imreconstruct(mark2,im_bw);
%figure,imshow(rec2),title('imagen reconstruida final'),impixelinfo

%% 





