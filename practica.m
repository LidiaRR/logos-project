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

% Dades varies. Potser utilitzar solidity
dades = regionprops(im_bw, 'all');
cc = bwconncomp(im_bw, 4);

% Find Fourier descriptors
ero = imerode(im_bw, strel('disk',1));
new_cont = imsubtract(im_bw, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo


N = 10;
fourierDescriptors = zeros(max(labeledImage(:)), N);
for i = 1:max(labeledImage(:))
    % Find descrete coordinates
    [fila, col] = find(labeledImage==i);
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
    fourierDescriptors(i, :) = z(1:N)/z(2);

    ss = ifft(tmp);
    aux = zeros(300);
    files = round(real(ss) + 150);
    cols = round(imag(ss) + 150);
    aux(sub2ind(size(aux),files,cols)) = 1;
    figure, imshow(aux), title('image with 10 descriptors')
end


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

% Dades varies. Potser utilitzar solidity
dades = regionprops(im_bw, 'all');
cc = bwconncomp(im_bw, 4);

% Find Fourier descriptors
ero = imerode(im_bw, strel('disk',1));
new_cont = imsubtract(im_bw, ero);
labeledImage = bwlabel(new_cont);
figure, imshow(labeledImage, []), colormap('colorcube'), impixelinfo


N = 10;
newFourierDescriptors = zeros(max(labeledImage(:)), N);
for i = 1:max(labeledImage(:))
    % Find descrete coordinates
    [fila, col] = find(labeledImage==i);
    [~,ind] = min(fila);
    fila = fila(ind); col = col(ind);
    B = bwtraceboundary(new_cont, [fila, col], 'E');

    mig = mean(B);
    Bc = B - mig;
    s = Bc(:,1) + 1i*Bc(:,2);
    z = fft(s);

    tmp = z;
    tmp(N+1:end-N) = 0;
    newFourierDescriptors(i, :) = z(1:N)/z(2);

    ss = ifft(tmp);
    aux = zeros(500);
    files = round(real(ss) + 250);
    cols = round(imag(ss) + 250);
    aux(sub2ind(size(aux),files,cols)) = 1;
    figure, imshow(aux), title('image with 10 descriptors')
end

found = [];
for i=1:max(labeledImage(:))
    div = newFourierDescriptors(i,2);
    for j = 1:3
        aux = fourierDescriptors(j,:) - fourierDescriptors(j,2)*newFourierDescriptors(i,:)/div;
        for k = 1:N
            aux(k) = abs(aux(k));
        end
        if max(aux) < 0.05 & ~ ismember(j,found)
            found = [found j]
        end
    end
end


%% 





