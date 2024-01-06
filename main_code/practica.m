model = trainModel();

im = imread('../my_images/apple2.jpg');
fastPrediction(im, model)
makePrediction(im, model)