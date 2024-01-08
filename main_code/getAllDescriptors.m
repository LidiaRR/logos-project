function desc = getAllDescriptors(im)
    houghLines = houghDescriptors_lines(im);
    houghCircles = houghDescriptors_circles(im);
    [hog] = extractHOGFeatures(im, 'CellSize', [64,64]);
    SIFTDesc = getSIFTDescriptors(im);
    fourier = fourierDescriptors(im);
    fourier2 = fourierDescriptors(255-im);

    desc = [houghLines ; houghCircles; hog'; SIFTDesc'; fourier; fourier2];
end