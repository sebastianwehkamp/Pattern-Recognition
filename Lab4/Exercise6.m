% Read image
image = imread('dogGrayRipples.png');
% Perform fourier transform
F = fft2(image);
% Shift fft spectrum
spectrum = fftshift(F);

% Remove the noise (locations identified using PlotFFTSpectrum.m)
for j = 155:175
    for n = 110:130
        spectrum(n,j) = 0;
    end
    for n = 170:190
        spectrum(n,j) = 0;
    end
end

% Reverse the FFT transform and plot image
cleanIm = real(ifft2(ifftshift(spectrum)));
imshow(cleanIm, []);
        

