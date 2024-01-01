% Devuelve descriptores basados en círculos usando Hough. 
function descriptors = houghDescriptors_circles(im)
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