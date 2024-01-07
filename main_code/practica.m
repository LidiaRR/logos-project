model = trainModel();

im = imread('../my_images/motorola3.jpg');
[prediction, score] = fastPrediction(im, model)
[prediction, score] = makePrediction(im, model)