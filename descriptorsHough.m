function [descriptors] = descriptorsHough(im)
    BW = edge(im,'canny');
    [H,alfa,rho] = hough(BW);
    
    P = houghpeaks(H,6);

    % Descomentar si quieres pintar
    %{
    lines = houghlines(BW, alfa, rho, P);
    figure, imshow(im, []), title("rectas principales")
    hold on
    for k = 1:length(lines)
     xy = [lines(k).point1; lines(k).point2];
     plot(xy(:,1), xy(:,2), "LineWidth", 2, "color", "red")
    end
    %}

    descriptors = [P(:,1) ; P(:,2)];
    for i = length(descriptors)+1:12
        descriptors = [descriptors ; 0];
    end
end