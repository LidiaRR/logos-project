function [prediction, scores] = fastPrediction(im, trainedModel)
    im_grey = im2gray(im);
    im_grey = imresize(im_grey,[256,256]);
    desc = getAllDescriptors(im_grey);
    [prediction,scores] = trainedModel.predictFcn(desc);
end

