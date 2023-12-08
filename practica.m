%% GET DATA

close all
clear
im = imread('Daewoo Electronics\47.jpg');
imshow(im), title('im 47 Daewoo')

% Trobar contorns
im_grey = im2bw(im);
dil = imdilate(im_grey, strel('disk',1));
cont = imsubtract(dil, im_grey);
%figure, imshow(cont), title('contorns');

cont_bw = imbinarize(cont);
%figure, imshow(cont_bw), title('contorn bw')

% Reconstruir per tenir imatge lógica
[files,cols] = size(cont_bw);
markers = ones(files, cols);
markers(2:end-1,2:end-1) = 0;
im_bw = ~imreconstruct(markers, double(~cont_bw),4);
figure, imshow(im_bw), title('reconstrucció bw')

% Dades varies
dades = regionprops(im_bw, 'all');
relativeHorizontalDistance = abs(dades(2).Centroid(1)-dades(3).Centroid(1))/abs(dades(2).Centroid(1)-dades(1).Centroid(1));
relativeDistance23 = pdist2(dades(2).Centroid, dades(3).Centroid)^2/dades(2).Area;
relativeArea = dades(1).Area/dades(3).Area;

ero = imerode(im_bw, strel('disk',1));
new_cont = imsubtract(im_bw, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo


%% 

im = imread('Daewoo Electronics\37.jpg');
imshow(im), title('im 34 Daewoo')

% Trobar contorns
im_grey = im2bw(im);
dil = imdilate(im_grey, strel('disk',1));
cont = imsubtract(dil, im_grey);
%figure, imshow(cont), title('contorns');

cont_bw = imbinarize(cont);
%figure, imshow(cont_bw), title('contorn bw')

% Reconstruir per tenir imatge lógica
[files,cols] = size(cont_bw);
markers = ones(files, cols);
markers(2:end-1,2:end-1) = 0;
im_bw = ~imreconstruct(markers, double(~cont_bw),4);
figure, imshow(im_bw), title('reconstrucció bw')

% Dades varies
dadesNoves = regionprops(im_bw, 'all');

% Find Fourier descriptors
ero = imerode(im_bw, strel('disk',1));
new_cont = imsubtract(im_bw, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo

L = max(labeledImage(:));


for i = 1:L
    for j = 1:L
        if j ~= i
            for k = 1:L
                if k ~= i & k ~= j
                    newRelativeDistance = pdist2(dadesNoves(j).Centroid, dadesNoves(k).Centroid)/pdist2(dadesNoves(j).Centroid,dadesNoves(i).Centroid);
                    newRelativeHorizontalDistance = abs(dadesNoves(j).Centroid(1)-dadesNoves(k).Centroid(1))/abs(dadesNoves(j).Centroid(1)-dadesNoves(i).Centroid(1));
                    newRelativeDistance23 = pdist2(dadesNoves(j).Centroid, dadesNoves(k).Centroid)^2/dadesNoves(j).Area;
                    newRelativeDistance12 = dadesNoves(i).Area/abs(dadesNoves(i).Centroid(2)-dadesNoves(j).Centroid(2))^2;
                    newRelativeArea = dadesNoves(i).Area/dadesNoves(k).Area;
                    if abs(newRelativeArea-relativeArea) < 8 & abs(newRelativeHorizontalDistance-relativeHorizontalDistance) < 0.1 & abs(newRelativeDistance23 - relativeDistance23) < 0.11 & ...
                            abs(dadesNoves(i).Solidity - dades(1).Solidity) < 0.15 &...
                            abs(dadesNoves(j).Circularity - dades(2).Circularity) < 0.15 & abs(dadesNoves(j).Solidity - dades(2).Solidity) < 0.15 &...
                            abs(dadesNoves(k).Solidity - dades(3).Solidity) < 0.15
                        [i,j,k]
                        %{
                        newRelativeDistance
                        newRelativeHorizontalDistance
                        newRelativeDistance23
                        newRelativeDistance12
                        newRelativeArea
                        %}
                    end
                end
            end
        end
       
    end
end







