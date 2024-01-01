% Reconstruccion y binarizacion de la imagen.
function im_result = preprocess_image(im_grey)
    % Ajustar niveles de intensidad:
    im_grey = imadjust(im_grey);
    %figure,imshow(im_grey),title('adjusted image')

    % Reconstruir imagen:
    mark = im_grey;
    mark(2:end-1,2:end-1) = 0;
    im_reconstruct = imreconstruct(mark,im_grey);
    %figure,imshow(im_reconstruct),title('imagen reconstruida'),impixelinfo

    % Binarizar con umbral de Otsu:
    threshold = graythresh(im_reconstruct);
    im_result = imbinarize(im_reconstruct,threshold);
end