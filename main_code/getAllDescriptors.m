function desc = getAllDescriptors(im)
    houghLines = houghDescriptors_lines(im);
    houghCircles = houghDescriptors_circles(im);
    [hog] = extractHOGFeatures(im, 'CellSize', [64,64]);
    SIFTDesc = getSIFTDescriptors(im);
    fourier = fourierDescriptors(im);

    desc = [houghLines ; houghCircles; hog'; SIFTDesc'; fourier];
end