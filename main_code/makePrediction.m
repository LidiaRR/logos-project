function [prediction, score, result] = makePrediction(im, trainedModel)
    im_grey = im2gray(im);
    im_pre = imresize(im_grey,[256,256]);

    prediction = [];
    score = [];
    
    %{
    desc = getAllDescriptors(im_pre);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(:,1:127);
    sub_im = imresize(sub_im,[256,256]);
    %figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(:,128:end);
    sub_im = imresize(sub_im,[256,256]);
    %figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(1:127,:);
    sub_im = imresize(sub_im,[256,256]);
    %figure, imshow(sub_im)
    desc = getAllDescriptors(sub_im);
    [yfit,scores] = trainedModel.predictFcn(desc);
    prediction = [prediction yfit];
    score = [score max(scores)];

    sub_im = im_pre(128:end,:);
    sub_im = imresize(sub_im,[256,256]);
    %figure, imshow(sub_im)
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
                %figure, imshow(sub_im)
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
                %figure, imshow(sub_im)
                desc = getAllDescriptors(sub_im);
                [yfit,scores] = trainedModel.predictFcn(desc);
                prediction = [prediction yfit];
                score = [score max(scores)];
            end
        end
    end
    %}

    length_v = [256, 128, 86, 171, 64];
    jumps = [0, 64, 86, 86, 32];
    iterations = [1, 3, 3, 2, 7];

    for a = 1:5
        for b = 1:5
            x_ini = 1;
            x_fin = length_v(a);
            for iter_i = 1:iterations(a)
                y_ini = 1;
                y_fin = length_v(b);
                for iter_j = 1:iterations(b)
                    %a, b, x_ini, x_fin, y_ini, y_fin
                    sub_im = im_pre(x_ini:min(x_fin,256),y_ini:min(y_fin,256));
                    sub_im = imresize(sub_im,[256,256]);
                    desc = getAllDescriptors(sub_im);
                    [yfit,scores] = trainedModel.predictFcn(desc);
                    prediction = [prediction yfit];
                    score = [score max(scores)];
                    if max(scores) >= -0.1
                        figure, imshow(sub_im), title(length(score));
                    end
                    y_ini = y_ini + jumps(b);
                    y_fin = y_fin + jumps(b);
                end
                x_ini = x_ini + jumps(a);
                x_fin = x_fin + jumps(a);
            end
        end
    end

    [num, index] = max(score);
    result = [prediction(index), num, index];
end