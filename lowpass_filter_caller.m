%Function - lowpass filter caller:
%Input:
%   filename: the name of the sound file you want to process
%   cutoff: desired frequency cutoff. frequency higher than cutoff will be
%   eliminated
%Output:
%   Audio data after being lowpassed
function output = lowpass_filter_caller(filename, cutoff)
    [y, fs] = audioread(filename);

    disp('sample frequency:');
    disp(fs);

    if ((fs/2) < cutoff)
        error('Cutoff too large. Please make it less than half of the sample frequency.');
    end
    %PLOT: use as desired
    %subplot(7, 1, 1);
    %plot(y);
    %title('sound input');
    output = filter_l(y, fs, cutoff);
end
