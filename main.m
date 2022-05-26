[filename,path] = uigetfile({'*.wav'});
fullPath = strcat(path,filename);

txt = 'What is the Gain' + '\n';
gain = input(txt);

gain

txt = '1-FIR' + '\n' + '2-IIR' + '\n';
filter_type = input(txt);


filter_type



























