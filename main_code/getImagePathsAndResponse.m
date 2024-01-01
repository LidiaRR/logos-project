% Obtiene los paths de las imágenes y la variable response para entrenar
% los modelos. Funciona tanto para Linux como Windows.
function [images_paths, response] = getImagePathsAndResponse()
    parent_folder = '..';
    images_directory_name = 'images_logos';
    images_directory = fullfile(parent_folder, images_directory_name);

    % Obtener los nombres de las carpetas (logos)
    entries = dir(images_directory);
    logos = strings(0);
    for i = 1:length(entries)
        if entries(i).isdir && ~ismember(entries(i).name, {'.', '..'})
            logos(end+1) = entries(i).name;
        end
    end
    
    % Obtener paths de todas las imágenes
    images_paths = strings(0);
    response = strings(0);
    
    for i = 1:length(logos)
        img_folder = fullfile(images_directory, logos(i));
        
        % Obtiene una lista de todos los archivos .jpg en el directorio
        files = dir(fullfile(img_folder, '*.jpg'));
    
        % Agrega el nombre de cada archivo a la lista 'images_paths'
        for j = 1:length(files)
            images_paths(end+1) = fullfile(img_folder, files(j).name);
            response(end+1) = logos(i);
        end
    end
end
