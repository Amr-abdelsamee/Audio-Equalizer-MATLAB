
function main()


file = Read_file();

[Y, fs] = wavread(file);

gain = input('What is the Gain: ');

filter_type = input('select: 1-FIR , 2-IIR: ');
while filter_type ~= 1 && filter_type ~=2
    filter_type = input('Incorrect response! select: 1-FIR , 2-IIR: ');
end

Fs= input('Enter Output Sample Rate: ');



% play the sound
% sound(Y,fs) % to stop the sound type :" clear sound " in matlab console

end



function file = Read_file()

[filename,path] = uigetfile({'*.wav'});

file = strcat(path,filename); % file fullPath
end



function BandFilters()


bandpass(song,[230 450],fs)
 
 
end









