function desc = getAllDescriptors(im)
    houghLines = houghDescriptors_lines(im);
    houghCircles = houghDescriptors_circles(im);
    [hog, vis] = extractHOGFeatures(im, 'CellSize', [64,64]);
    SIFTDesc = getSIFTDescriptors(im);

    %figure, plot(vis), title('cell 64x64')
    desc = [houghLines ; houghCircles; hog'; SIFTDesc'];
end