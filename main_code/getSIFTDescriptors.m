function desc = getSIFTDescriptors(im)
    kp = detectSIFTFeatures(im);
    kp = selectStrongest(kp,50);
    desc = [];
    for i = 1:length(kp)
        desc = [desc single(kp.Scale(i)) single(kp.Orientation(i)) single(kp.Octave(i)) single(kp.Layer(i)) single(kp.Location(i)) single(kp.Metric(i))];
    end
    for i = length(desc)+1:7*50
        desc = [desc 0];
    end
end