% DO NOT EDIT
function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 27-May-2022 21:28:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code



% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, ~, handles, varargin)

global gain; 

% sliers setting 
MAX_DB = 50;
MIN_DB = -50;
INIT_VALUE = 0;

gain = zeros(1,9); % create an array with the size of this 1 row 9 column for 9 bands

axes(handles.axes1); %Mengatur tag axes1
xlabel('Time'); %memberi nama label x pada tag axes1 
ylabel('Magnitude'); %memberi nama label y pada tag axes1

axes(handles.axes2);
title('Input Signal');
xlabel('Frequency');  
ylabel('Magnitude'); 

axes(handles.axes3);
title('Output Signal');
xlabel('Frequency');
ylabel('Magnitude');

set(handles.slider1,'min',MIN_DB); % max value
set(handles.slider1,'max',MAX_DB); % min value
set(handles.slider1,'value',INIT_VALUE); % initial value
set(handles.slider1,'SliderStep',[0.025,0.05]); % range of the step
set(handles.edit1_box,'string',num2str(INIT_VALUE)); % set the value in the eit box

set(handles.slider2,'min',MIN_DB);
set(handles.slider2,'max',MAX_DB);
set(handles.slider2,'value',INIT_VALUE);
set(handles.slider2,'SliderStep',[0.025,0.05]);
set(handles.edit2_box,'string',num2str(INIT_VALUE));

set(handles.slider3,'min',MIN_DB);
set(handles.slider3,'max',MAX_DB);
set(handles.slider3,'value',INIT_VALUE);
set(handles.slider3,'SliderStep',[0.025,0.05]);
set(handles.edit3_box,'string',num2str(INIT_VALUE));

set(handles.slider4,'min',MIN_DB);
set(handles.slider4,'max',MAX_DB);
set(handles.slider4,'value',INIT_VALUE);
set(handles.slider4,'SliderStep',[0.025,0.05]);
set(handles.edit4_box,'string',num2str(INIT_VALUE));

set(handles.slider5,'min',MIN_DB);
set(handles.slider5,'max',MAX_DB); 
set(handles.slider5,'value',INIT_VALUE); 
set(handles.slider5,'SliderStep',[0.025,0.05]);
set(handles.edit5_box,'string',num2str(INIT_VALUE)); 

set(handles.slider6,'min',MIN_DB);
set(handles.slider6,'max',MAX_DB); 
set(handles.slider6,'value',INIT_VALUE);
set(handles.slider6,'SliderStep',[0.025,0.05]);
set(handles.edit6_box,'string',num2str(INIT_VALUE));

set(handles.slider7,'min',MIN_DB);
set(handles.slider7,'max',MAX_DB);
set(handles.slider7,'value',INIT_VALUE);
set(handles.slider7,'SliderStep',[0.025,0.05]);
set(handles.edit7_box,'string',num2str(INIT_VALUE));

set(handles.slider8,'min',MIN_DB);
set(handles.slider8,'max',MAX_DB);
set(handles.slider8,'value',INIT_VALUE);
set(handles.slider8,'SliderStep',[0.025,0.05]);
set(handles.edit8_box,'string',num2str(INIT_VALUE));

set(handles.slider9,'min',MIN_DB);
set(handles.slider9,'max',MAX_DB);
set(handles.slider9,'value',INIT_VALUE);
set(handles.slider9,'SliderStep',[0.025,0.05]);
set(handles.edit9_box,'string',num2str(INIT_VALUE));

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.gui_window);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key press with focus on open_btn and none of its controls.
function open_btn_Callback(~, ~, handles)
% hObject    handle to open_btn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

global filename;
% all ys is where to store the output of the filter
global y2; 
global y3; 
global y4; 
global y5;
global y6;
global y7;
global y8;
global y9;
global y10;
global Fs; 
global X;  

% open file
[filename,pathname] = uigetfile({'*.wav'});
set(handles.edit0_filename_place,'string',filename); %display the file name

[X,Fs] = audioread(filename);

h2 = fir1(100, 170/Fs, 'low');
h3 = fir1(100, [171/Fs 310/Fs], 'bandpass');
h4 = fir1(100, [311/Fs 600/Fs], 'bandpass');
h5 = fir1(100, [601/Fs 1000/Fs], 'bandpass');
h6 = fir1(100, [1001/Fs 3000/Fs], 'bandpass');
h7 = fir1(100, [3001/Fs 6000/Fs], 'bandpass');
%{
h8 = fir1(100, [6001/Fs 12000/Fs], 'bandpass');
h9 = fir1(100, [12001/Fs 14000/Fs], 'bandpass');
h10 = fir1(100,[14001/Fs 16000/Fs], 'high');
%}
y2 = filter(h2, 1, X);
y3 = filter(h3, 1, X);
y4 = filter(h4, 1, X);
y5 = filter(h5, 1, X);
y6 = filter(h6, 1, X);
y7 = filter(h7, 1, X);
%{
y8 = filter(h8, 1, X);
y9 = filter(h9, 1, X);
y10 = filter(h10, 1, X);
%}


% --- Executes on button press in play_btn.
function play_btn_Callback(hObject, eventdata, handles)
% hObject    handle to play_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global filename;
global player;
global y;
global gain;
global y2;
global y3;
global y4;
global y5;
global y6;
global Fs;

global X;
for i = 1:9
    gain(1)
end
y = y2*gain(1) + y3*gain(2) + y4*gain(3) + y5*gain(4) + y6*gain(5); % summing filter output after multiplied by gain of each one

if y == 0
    
    y = X;
end
player = audioplayer(y,Fs);
play(player)




% --- Executes on button press in pause_btn.
function pause_btn_Callback(hObject, eventdata, handles)
% hObject    handle to pause_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
pause(player) % pause variabel player




% --- Executes on button press in resume_btn.
function resume_btn_Callback(hObject, eventdata, handles)
% hObject    handle to resume_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
resume(player) % resume variabel player



% --- Executes on button press in stop_btn.
function stop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to stop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
stop(player) % stop variabel player



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(1) = get(hObject,'value');
set(handles.edit1_box,'string',num2str(gain(1)));



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(2)=get(hObject,'value');
set(handles.edit2_box,'string',num2str(gain(2)));



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(3)=get(hObject,'value');
set(handles.edit3_box,'string',num2str(gain(3)));


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(4) = get(hObject,'value');
set(handles.edit4_box,'string',num2str(gain(4))); 


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(5) = get(hObject,'value');
set(handles.edit5_box,'string',num2str(gain(5)));


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(6) = get(hObject,'value');
set(handles.edit6_box,'string',num2str(gain(6)));

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(7) = get(hObject,'value');
set(handles.edit7_box,'string',num2str(gain(7)));

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(8) = get(hObject,'value');
set(handles.edit8_box,'string',num2str(gain(8)));

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gain;
gain(9) = get(hObject,'value');
set(handles.edit9_box,'string',num2str(gain(9)));

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end








function edit1_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_box as text
%        str2double(get(hObject,'String')) returns contents of edit1_box as a double
global gain;
gain(1) = str2num(get(hObject,'string'));
minn = get(handles.slider1,'min');
maxx = get(handles.slider1,'max');
if(gain(1)<minn || gain(1)>maxx)
    gain(1) = get(handles.slider1,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider1,'value',gain(1));
end


% --- Executes during object creation, after setting all properties.
function edit1_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_box as text
%        str2double(get(hObject,'String')) returns contents of edit2_box as a double
global gain;
gain(2) = str2num(get(hObject,'string'));
minn = get(handles.slider2,'min');
maxx = get(handles.slider2,'max');
if(gain(2) < minn || gain(2) > maxx)
    gain(2)=get(handles.slider2,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider2,'value',gain(2));
end



% --- Executes during object creation, after setting all properties.
function edit2_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_box as text
%        str2double(get(hObject,'String')) returns contents of edit3_box as a double
global gain;
gain(3) = str2num(get(hObject,'string'));
minn = get(handles.slider3,'min');
maxx = get(handles.slider3,'max');
if(gain(3) < minn || gain(3) > maxx)
    gain(3) = get(handles.slider3,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider3,'value',gain(3));
end


% --- Executes during object creation, after setting all properties.
function edit3_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_box as text
%        str2double(get(hObject,'String')) returns contents of edit4_box as a double
global gain;
gain(4) = str2num(get(hObject,'string'));
minn = get(handles.slider4,'min');
maxx = get(handles.slider4,'max');
if(gain(4)<minn || gain(4)>maxx)
    gain(4) = get(handles.slider4,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider4,'value',gain(4));
end


% --- Executes during object creation, after setting all properties.
function edit4_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit5_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5_box as text
%        str2double(get(hObject,'String')) returns contents of edit5_box as a double
global gain;
gain(5) = str2num(get(hObject,'string'));
minn = get(handles.slider5,'min');
maxx = get(handles.slider5,'max');
if(gain(5) < minn || gain(5) > maxx)
    gain(5)=get(handles.slider5,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider5,'value',gain(5));
end


% --- Executes during object creation, after setting all properties.
function edit5_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit6_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6_box as text
%        str2double(get(hObject,'String')) returns contents of edit6_box as a double
global gain;
gain(6) = str2num(get(hObject,'string'));
minn = get(handles.slider6,'min');
maxx = get(handles.slider6,'max');
if(gain(5) < minn || gain(6) > maxx)
    gain(5)=get(handles.slider6,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider6,'value',gain(6));
end

% --- Executes during object creation, after setting all properties.
function edit6_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit7_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7_box as text
%        str2double(get(hObject,'String')) returns contents of edit7_box as a double
global gain;
gain(7) = str2num(get(hObject,'string'));
minn = get(handles.slider7,'min');
maxx = get(handles.slider7,'max');
if(gain(7) < minn || gain(7) > maxx)
    gain(7)=get(handles.slider7,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider7,'value',gain(7));
end

% --- Executes during object creation, after setting all properties.
function edit7_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit8_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8_box as text
%        str2double(get(hObject,'String')) returns contents of edit8_box as a double
global gain;
gain(8) = str2num(get(hObject,'string'));
minn = get(handles.slider8,'min');
maxx = get(handles.slider8,'max');
if(gain(8) < minn || gain(8) > maxx)
    gain(8)=get(handles.slider8,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider8,'value',gain(8));
end

% --- Executes during object creation, after setting all properties.
function edit8_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit9_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9_box as text
%        str2double(get(hObject,'String')) returns contents of edit9_box as a double
global gain;
gain(9) = str2num(get(hObject,'string'));
minn = get(handles.slider9,'min');
maxx = get(handles.slider9,'max');
if(gain(9) < minn || gain(9) > maxx)
    gain(9)=get(handles.slider9,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.slider9,'value',gain(9));
end

% --- Executes during object creation, after setting all properties.
function edit9_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit0_filename_place_Callback(hObject, eventdata, handles)
% hObject    handle to edit0_filename_place (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
set(hObject,'string',filename);
% Hints: get(hObject,'String') returns contents of edit0_filename_place as text



% --- Executes during object creation, after setting all properties.
function edit0_filename_place_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit0_filename_place (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in plot1_btn.
function plot1_btn_Callback(hObject, eventdata, handles)
% hObject    handle to plot1_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%{
global C;
global y2;
global y3;
global y4;
global y5;
global y6;
global y;

y = y2*C(1)+y3*C(2)+y4*C(3)+y5*C(4)+y6*C(5);

axes(handles.axes1);
plot(y);
xlabel('Time');
ylabel('Magnitude');
%}






% --- Executes when gui_window is resized.
function gui_window_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to gui_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when user attempts to close gui_window.
function gui_window_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gui_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function open_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to open_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on open_btn and none of its controls.
function open_btn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to open_btn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function play_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to play_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
