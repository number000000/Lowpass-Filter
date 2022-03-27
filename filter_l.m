%Function - lowpass filter:
%Input:
%   input: matrix - Audio data in the file (needs to be a single column matrix)
%       -recommended input: value y from audioread)
%   Fs: Sample rate of the audio data, in hertz
%   cutoff: desired frequency cutoff. frequency higher than cutoff will be
%   eliminated
%Output:
%   Audio data after being lowpassed
function output = filter_l(input, Fs, cutoff)
    
    %Fourier Transform inputted audio data and center it
    ft_input = fft(input);
    centered_freq = fftshift(ft_input);
    %PLOT: use as desired
    %subplot(7, 1, 3);
    %plot(real(ft_input));
    %title('fourier transform of input wave');

    %find frequency of the input data after fourier transform
    totalSample = length(input);
    F = Fs * (-totalSample/2 : (totalSample/2 - 1)) / totalSample;
    
    %initialize multiplier
    %a square wave with value 1 on areas that will be saved
    %value 0 on areas that will be eliminated
    len_freq = length(centered_freq);  
    multiplier = zeros(1, len_freq);
    middle = (Fs * (totalSample/2-1))/totalSample;
    left_most = Fs * (-totalSample/2)/totalSample;
    for i = 1 : len_freq
        if(cutoff > middle)
            if((F(i) < 0) && ((F(i) - left_most) > (cutoff - middle)))
                multiplier(i) = 0;
            else
                multiplier(i) = 1;
            end
        else
            if((F(i) >= 0) && (F(i) < cutoff))
                multiplier(i) = 1;
            else
                multiplier(i) = 0;
            end
        end
    end

    %PLOT: use as desired
    %subplot(7, 1, 4);
    %plot(multiplier);
    %title('multiplier');

    %modify input in frequency domain
    centered_freq = centered_freq.';
    notShift_ft_input = multiplier .* centered_freq;
    mod_ft_input = fftshift(notShift_ft_input);
    
    %PLOT: use as desired
    %subplot(7, 1, 5);
    %plot(real(mod_ft_input));
    %title('input wave after lowpass filter in frequency domain');

    %use inverse fourier transform to get the filtered output waveform
    %frequency domain -> time domain
    output = real(ifft(mod_ft_input));
    
    %PLOT: use as desired
    %subplot(7, 1, 6);
    %plot(output);
    %title('input wave after lowpass filter in time domain');
end
