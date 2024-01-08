[image_paths, response] = getImagePathsAndResponse();

data = [];

for i = 1:length(image_paths)
    im = imread(image_paths(i));
    im_grey = im2gray(im);
    im_grey = imresize(im_grey,[256,256]);
    
    desc = getAllDescriptors(im_grey);

    data = [data desc];
end

