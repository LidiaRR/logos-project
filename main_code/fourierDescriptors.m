function coefficients = fourierDescriptors(im_bw)
    im_label = bwlabel(im_bw);
    dades = regionprops(im_bw, 'all');
    [~,indexMaxArea] = max([dades.Area]);

    im_comp = im_label == indexMaxArea;
    % Find descrete coordinates
    N = 20;
    [fila, col] = find(im_comp,1);
    B = bwtraceboundary(im_comp, [fila, col], 'N');
    
    mig = mean(B);
    Bc = B - mig;
    s = Bc(:,1) + 1i*Bc(:,2);
    z = fft(s);
    
    tmp = z;
    tmp(N+1:end-N) = 0;
    coefficients = z(1:min(N,size(tmp)))/z(2);
    coefficients = [real(coefficients) ; imag(coefficients)];
    
    % Descomentar si quieres pintar
    %{
    ss = ifft(tmp);
    aux = zeros(400);
    files = round(real(ss) + 200);
    cols = round(imag(ss) + 200);
    aux(sub2ind(size(aux),files,cols)) = 1;
    figure, imshow(aux), title('image with 20 descriptors')
    %}
end