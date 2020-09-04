function [average] = IPfourierspectrum (img)
    %Perform fourier transform
    F = fft2(img);
    %Size of img
    [m, n] = size(img);
    %Compute average
    average = F(1,1)/(m*n);
    %Apply shift, scaling, and show image
    imagesc(log(abs(fftshift(F)))+1); 
    %Set colormap for the image to gray
    colormap(gray);
    title('Fourier Spectrum magnitude');
end