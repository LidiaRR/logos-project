function borders = preprocess_image(path_im)
    im = imread(path_im);

    % Pasar imagen a gris
    im_grey = rgb2gray(im);
    % figure, imshow(im_grey);
    
    % Filtrar imagen con filtro de mediana (va bien para la iluminación)
    im_filtrada = medfilt2(im_grey, [3 3]);
    % figure, imshow(im_filtrada)
    
    % Filtrado gaussiano para reducir el ruido, sobre todo en los bordes
    sigma = 4; 
    im_gauss = imgaussfilt(im_filtrada, sigma);
    % figure, imshow(im_gauss);
    
    % Sacamos los bordes por Canny
    im_borders = edge(im_gauss, 'Canny');
    % figure, imshow(im_borders);
    
    % Nos aseguramos de que los bordes estan cerrados con un close
    se = strel('disk', 4); 
    im_cerrada = imclose(im_borders, se);
    % figure, imshow(im_cerrada);
    
    % Hacemos una máscara con los huecos rellenados
    mask = imfill(im_cerrada, 'holes');
    % figure, imshow(mask)
    
    % Dilatamos la máscara para obtener los contornos 
    ee = strel('disk', 1);
    mask_dilated = imdilate(mask, ee);
    % figure, imshow(mask_dilated);
    
    % Obtenemos los bordes
    borders = mask_dilated - mask;
    % figure, imshow(borders);
end

