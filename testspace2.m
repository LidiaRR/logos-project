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


