%% 

close all
clear
im = imread('hp\23.jpg');
imshow(im), title('im 23 hp')

% Trobar contorns
im_grey = im2bw(im);
dil = imdilate(im_grey, strel('disk',1));
cont = imsubtract(dil, im_grey);
figure, imshow(cont), title('contorns');

cont_bw = imbinarize(cont);

% Reconstruir per tenir imatge lógica
[files,cols] = size(cont_bw);
markers = ones(files, cols);
markers(2:end-1,2:end-1) = 0;
im_bw = imreconstruct(markers, double(~cont_bw),4);
figure, imshow(im_bw), title('reconstrucció bw')

ero = imerode(im_bw, strel('disk',1));
new_cont = imsubtract(im_bw, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo

N = 20;
fourierDescriptors = [];

% Find descrete coordinates
[fila, col] = find(labeledImage==1);
[~,ind] = min(fila);
fila = fila(ind); col = col(ind);

B = bwtraceboundary(new_cont, [fila, col], 'E');

mig = mean(B);
Bc = B - mig;
s = Bc(:,1) + 1i*Bc(:,2);
z = fft(s);

tmp = z;
%tmp = (10000*z)/z(2)
tmp(N+1:end-N) = 0;
fourierDescriptors = z(1:N)/z(2);

ss = ifft(tmp);
aux2 = zeros(300);
files = round(real(ss) + 150);
cols = round(imag(ss) + 150);
aux2(sub2ind(size(aux2),files,cols)) = 1;
figure, imshow(aux2), title('image with 20 descriptors')




%% 
%close all
im = imread('hp\15.jpg');
figure, imshow(im), title('im 15 hp')

% Trobar contorns
im_grey = im2bw(im);
dil = imdilate(im_grey, strel('disk',1));
cont = imsubtract(dil, im_grey);
figure, imshow(cont), title('contorns');

cont_bw = imbinarize(cont);

% Reconstruir per tenir imatge lógica
[files,cols] = size(cont_bw);
markers = ones(files, cols);
markers(2:end-1,2:end-1) = 0;
im_bw = imreconstruct(markers, double(~cont_bw),4);
figure, imshow(im_bw), title('reconstrucció bw')

% Find Fourier descriptors
ero = imerode(im_bw, strel('disk',1));
new_cont = imsubtract(im_bw, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo


[files, cols] = find(new_cont);
data = zeros(100,100,80,80);
for i = 1:size(files)
    fila = files(i);
    col = cols(i);
    for r1 = 51:130
        for r2 = 51:130
            for a = fila-r1:fila+r1
                b1 = floor(col - r2*sqrt(1 - (fila - a)^2/r1^2));
                if a > 50 & a <= 150 & b1 > 50 & b1 <= 150
                    data(a-50,b1-50,r1-50,r2-50) = data(a-50,b1-50,r1-50,r2-50) + 1;
                end
                b2 = floor(col + r2*sqrt(1 - (fila - a)^2/r1^2));
                if a > 50 & a <= 150 & b2 > 50 & b2 <= 150
                    data(a-50,b2-50,r1-50,r2-50) = data(a-50,b2-50,r1-50,r2-50) + 1;
                end
            end
        end
    end
end


idx = find(data == max(data(:)));
[cx, cy, r1, r2] = ind2sub([100,100,80,80], idx);
figure, imshow(im)
hold on
%plotEllipse([cx,cy],[r1,r2]);
viscircles([cx+50,cy+50],max(r1,r2)+50,'Edgecolor','g')
viscircles([cx+50,cy+50],min(r1,r2)+50,'Edgecolor','g')

%% 

[n,m,~] = size(im);
new_im = logical(ones(n,m));
new_im(2:n-1,2:m-1) = false;
for i = 2:n-1
    for j = 2:m-1
        dist = pdist2([i,j],[cx+50,cy+50]);
        new_im(i,j) = dist > max(r1+50,r2+50) | ~im_bw(i,j);
    end
end
new_im = imclose(new_im, strel('disk',3));
figure, imshow(new_im)

%% 

ero = imerode(new_im, strel('disk',1));
new_cont = imsubtract(new_im, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo

N = 20;
newFourierDescriptors = [];

% Find descrete coordinates
[fila, col] = find(labeledImage==1);
[~,ind] = min(fila);
fila = fila(ind); col = col(ind);

B = bwtraceboundary(new_cont, [fila, col], 'E');

mig = mean(B);
Bc = B - mig;
s = Bc(:,1) + max(r1+50,r2+50)/min(r1+50,r2+50)*1i*Bc(:,2);
z = fft(s);

tmp = z;
%tmp = (10000*z)/z(2)
tmp(N+1:end-N) = 0;
%tmpIm = imag(tmp);
%tmp = tmp + 1i*tmpIm;
newFourierDescriptors = z(1:N)/z(2);

ss = ifft(tmp);
aux2 = zeros(400);
files = round(real(ss) + 200);
cols = round(imag(ss) + 200);
aux2(sub2ind(size(aux2),files,cols)) = 1;
figure, imshow(aux2), title('image with 20 descriptors')
