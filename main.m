[filename,path] = uigetfile({'*.wav'});
fullPath = strcat(path,filename);

gain = input('What is the Gain: ');

gain

filter_type = input('select: 1-FIR , 2-IIR: ');
while filter_type ~= 1 && filter_type ~=2
    filter_type = input('Incorrect response! select: 1-FIR , 2-IIR: ');
end

filter_type

Fs= input('Enter Output Sample Rate: ');


























