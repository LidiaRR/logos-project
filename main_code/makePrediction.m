function [prediction, score] = makePrediction(im, trainedModel)
    im_grey = im2gray(im);
    im_pre = imresize(im_grey,[256,256]);

    prediction = [];
    score = [];

    desc = getAllDescriptors(im_pre);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(:,1:127);
    sub_im = imresize(sub_im,[256,256]);
    figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(:,128:end);
    sub_im = imresize(sub_im,[256,256]);
    figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(1:127,:);
    sub_im = imresize(sub_im,[256,256]);
    figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(128:end,:);
    sub_im = imresize(sub_im,[256,256]);
    figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    if (max(score) ~= 1)
        for i = 1:3
            for j = 1:3
                i_ini = 1 + 63*(i-1);
                j_ini = 1 + 63*(j-1);
                sub_im = im_pre(i_ini:i_ini+129, j_ini:j_ini+129);
                sub_im = imresize(sub_im,[256,256]);
                figure, imshow(sub_im)
                desc = getAllDescriptors(sub_im);
                [yfit,scores] = trainedModel.predictFcn(desc);
                prediction = [prediction yfit];
                score = [score max(scores)];
            end
        end
    end

    if (max(score) ~= 1)
        for i = 1:4
            for j = 1:4
                i_ini = 1 + 63*(i-1);
                j_ini = 1 + 63*(j-1);
                sub_im = im_pre(i_ini:i_ini+66, j_ini:j_ini+66);
                sub_im = imresize(sub_im,[256,256]);
                figure, imshow(sub_im)
                desc = getAllDescriptors(sub_im);
                [yfit,scores] = trainedModel.predictFcn(desc);
                prediction = [prediction yfit];
                score = [score max(scores)];
            end
        end
    end

end