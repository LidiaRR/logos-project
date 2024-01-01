close all
clear

images_directory = "..\images_logos\";

images = ["apple\2.jpg", "apple\16.jpg", "apple\14.jpg", "apple\22.jpg", "apple\50.jpg", "apple\34.jpg",...
    "Cisco Systems\1.jpg","Cisco Systems\18.jpg","Cisco Systems\22.jpg","Cisco Systems\26.jpg","Cisco Systems\31.jpg","Cisco Systems\44.jpg",...
    "Daewoo Electronics\3.jpg", "Daewoo Electronics\34.jpg", "Daewoo Electronics\17.jpg", "Daewoo Electronics\21.jpg", "Daewoo Electronics\42.jpg", "Daewoo Electronics\47.jpg",...
    "IBM\2.jpg","IBM\9.jpg","IBM\12.jpg","IBM\14.jpg","IBM\45.jpg","IBM\56.jpg",...
    "hp\77.jpg", "hp\78.jpg", "hp\80.jpg", "hp\10.jpg", "hp\23.jpg", "hp\27.jpg",...
    "Intel\2.jpg","Intel\4.jpg","Intel\9.jpg","Intel\22.jpg","Intel\46.jpg","Intel\35.jpg"];

data = [];

response = ["apple","apple","apple","apple","apple","apple",...
            "cisco","cisco","cisco","cisco","cisco","cisco",...
            "daewoo","daewoo","daewoo","daewoo","daewoo","daewoo",...
            "ibm","ibm","ibm","ibm","ibm","ibm",...
            "hp","hp","hp","hp","hp","hp",...
            "intel","intel","intel","intel","intel","intel"];

for i = 1:length(images)
    pathIm = images_directory + images(i);
    % --- esto es para que me funcione en linux
    pathIm = strrep(pathIm, '\', '/');
    % ---
    im = imread(pathIm);
    im_grey = im2gray(im);
    im_processed = preprocess_image(im_grey);

    labelIm = bwlabel(~im_processed);
    %figure,imshow(labelIm, []),impixelinfo
    dades = regionprops(labelIm, 'all');
    [~,indexMaxArea] = max([dades.Area]);
    %figure, imshow(labelIm == indexMaxArea)

    desc1 = fourierDescriptors(labelIm == indexMaxArea);
    desc2 = descriptorsHough(im_processed);
    desc = [desc1 ; desc2];

    data = [data desc];
end

%{
for i = 1:length(images_compl)
    im = imread(images_compl(i));
    im_grey = im2gray(im);
    im_processed = preprocess_image(im_grey);

    labelIm = bwlabel(~im_bw);
    %figure,imshow(labelIm, []),impixelinfo
    dades = regionprops(labelIm, 'all');
    [~,indexMaxArea] = max([dades.Area]);
    %figure, imshow(labelIm == indexMaxArea)

    desc1 = fourierDescriptors(labelIm == indexMaxArea);
    desc2 = descriptorsHough(rec);
    desc = [desc1 ; desc2];

    data = [data desc];
end
%}
