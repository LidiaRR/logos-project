close all
clear

images_directory = "..\images_logos\";

images = ["apple\2.jpg", "apple\16.jpg", "apple\14.jpg", "apple\22.jpg", "apple\50.jpg", "apple\34.jpg", "apple\5.jpg", "apple\10.jpg", "apple\13.jpg",...
    "Cisco Systems\1.jpg","Cisco Systems\18.jpg","Cisco Systems\22.jpg","Cisco Systems\26.jpg","Cisco Systems\31.jpg","Cisco Systems\44.jpg", "Cisco Systems\4.jpg", "Cisco Systems\9.jpg", "Cisco Systems\33.jpg",...
    "Daewoo Electronics\3.jpg", "Daewoo Electronics\34.jpg", "Daewoo Electronics\17.jpg", "Daewoo Electronics\21.jpg", "Daewoo Electronics\42.jpg", "Daewoo Electronics\47.jpg", "Daewoo Electronics\7.jpg", "Daewoo Electronics\8.jpg", "Daewoo Electronics\61.jpg",...
    "IBM\2.jpg","IBM\9.jpg","IBM\12.jpg","IBM\14.jpg","IBM\45.jpg","IBM\56.jpg", "IBM\3.jpg","IBM\4.jpg","IBM\7.jpg",...
    "hp\77.jpg", "hp\78.jpg", "hp\80.jpg", "hp\10.jpg", "hp\23.jpg", "hp\27.jpg", "hp\1.jpg", "hp\4.jpg", "hp\6.jpg",...
    "Intel\2.jpg","Intel\4.jpg","Intel\9.jpg","Intel\22.jpg","Intel\46.jpg","Intel\35.jpg","Intel\3.jpg","Intel\11.jpg","Intel\5.jpg"];

data = [];

response = ["apple","apple","apple","apple","apple","apple","apple","apple","apple",...
            "cisco","cisco","cisco","cisco","cisco","cisco","cisco","cisco","cisco",...
            "daewoo","daewoo","daewoo","daewoo","daewoo","daewoo","daewoo","daewoo","daewoo",...
            "ibm","ibm","ibm","ibm","ibm","ibm","ibm","ibm","ibm",...
            "hp","hp","hp","hp","hp","hp","hp","hp","hp",...
            "intel","intel","intel","intel","intel","intel","intel","intel","intel"];

for i = 1:length(images)
    pathIm = images_directory + images(i);
    im = imread(pathIm);
    im_grey = im2gray(im);
   
    houghLines = descriptorsHough(im_grey);
    houghCircles = findCircles(im_grey);
    [hog] = extractHOGFeatures(im_grey, 'CellSize', [64,64]);
    desc = [houghLines ; houghCircles; hog'];

    data = [data desc];
end

function descriptors = findCircles(im)
    edges = edge(im, 'canny');
    [centers, radii] = imfindcircles(edges,[10,250]);
    descriptors = [];
    if length(radii) ~= 0
        [~,pos] = maxk(radii, 4);
        centers = centers(pos,:);
        [r,c] = size(centers);
        descriptors = [imresize(centers,[r*c,1]); radii(pos)];
    end
    for i = length(descriptors)+1:12
        descriptors = [descriptors ; 0];
    end
end
