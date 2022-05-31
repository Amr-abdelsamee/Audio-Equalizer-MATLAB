
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

% Last Modified by GUIDE v2.5 31-May-2022 04:51:36

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
global FIR;
FIR = 1;
gain = zeros(1,9); % create an array with the size of this 1 row 9 column for 9 bands

% sliers setting 
MAX_DB = 50;
MIN_DB = -50;
INIT_VALUE = 0;

axes(handles.input_axes);
title('Input Signal');
xlabel('Time')
ylabel('Audio Signal')

axes(handles.output_axes);
title('output Signal');
xlabel('Time')
ylabel('Audio Signal')

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


% all ys is where to store the output of the filter

global Fs;
global X; 
global new_Fs;
new_Fs = Fs;

% open file
[filename,pathname] = uigetfile({'*.wav'});

disp(' Loading the file... ');

[X,Fs] = audioread(filename);

set(handles.edit0_filename_place,'string',filename); %display the file name
set(handles.edit_newFs,'string',int2str(Fs)); %display the Fs

make_filters()
output_signal()
disp(' *Loading is done* ');

global info;
info = audioinfo(filename)



function make_filters()
% make_filters 
disp('make_filters is called');
global y2; 
global y3; 
global y4; 
global y5;
global y6;
global y7;
global y8;
global y9;
global y10;

global FIR;
global X;
global Fs;

temp = Fs/2;
if FIR == 1
    
    disp('FIR starts');
    
    %----------------------------------------------------------------------
    h2 = fir1(100, 170/temp, 'low');
    % phases of digital filter
    figure(98);
    set(figure(98), 'name', 'Phase of FIR filter')
    subplot(3,3,1);
    phasez(h2,1);
    title('Phase 0-170');
    % Impulse response of digital filter
    figure(99)
    set(figure(99), 'name', 'Impulse response of FIR filter')
    subplot(3,3,1);
    impz(h2)
    title('0-170 HZ');
    % Step response of digital filter
    figure(100)
    set(figure(100), 'name', 'Step response of FIR filter')
    subplot(3,3,1);
    stepz(h2)
    title('0-170 HZ'); 
    
    %----------------------------------------------------------------------
    h3 = fir1(100, [170 310]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,2); 
    phasez(h3,1); 
    title('Phase 170-310');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,2);
    impz(h3)
    title('170-310 HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,2);
    stepz(h3)
    title('170-310 HZ');
    
    %----------------------------------------------------------------------
    h4 = fir1(100, [310 600]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,3);
    phasez(h4,1);
    title('Phase 310-600');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,3);
    impz(h4)
    title('310-600 HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,3);
    stepz(h4)
    title('310-600 HZ');
    
    %----------------------------------------------------------------------
    h5 = fir1(100, [600 1000]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,4); 
    phasez(h5,1); 
    title('Phase 600-1000');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,4);
    impz(h5)
    title('600-1k HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,4);
    stepz(h5)
    title('600-1k HZ');
    
    %----------------------------------------------------------------------
    h6 = fir1(100, [1000 3000]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,5); 
    phasez(h6,1); 
    title('Phase 1000-3000');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,5);
    impz(h6)
    title('1k-3k HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,5);
    stepz(h6)
    title('1k-3k HZ');
    
    %----------------------------------------------------------------------
    h7 = fir1(100, [3000 6000]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,6);
    phasez(h7,1); 
    title('Phase 3000-6000');
    % Impulse response of digital filter
    figure(99);
    subplot(3,3,6);
    impz(h7)
    title('3k-6k HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,6);
    stepz(h7)
    title('3k-6k HZ');
    
    %----------------------------------------------------------------------
    h8 = fir1(100, [6000 12000]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,7); 
    phasez(h8,1); 
    title('Phase 6000-12000');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,7);
    impz(h8)
    title('6k-12k HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,7);
    stepz(h8)
    title('6k-12k HZ');
    
    %----------------------------------------------------------------------
    h9 = fir1(100, [12000 14000]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,8);
    phasez(h9,1);
    title('Phase 12000-14000');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,8);
    impz(h9)
    title('12k-14k HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,8);
    stepz(h9)
    title('12k-14k HZ');
    
    %----------------------------------------------------------------------
    h10 = fir1(100,[14000 16000]/temp, 'bandpass');
    % phases of digital filter
    figure(98);
    subplot(3,3,9);
    phasez(h10,1);
    title('Phase 14000-16000');
    % Impulse response of digital filter
    figure(99)
    subplot(3,3,9);
    impz(h10)
    title('14k-16k HZ');
    % Step response of digital filter
    figure(100)
    subplot(3,3,9);
    stepz(h10)
    title('14k-16k HZ');
    
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    
    y2 = filter(h2, 1, X);
    [z,p,k] = tf2zpk(h2,1);
    % zeros and poles plot
    figure(101)
    set(figure(101), 'name', 'Zeros and Poles of FIR')
    subplot(3,3,1);
    pzmap(tf(h2,1));
    title('0-170 Hz');
    %gain
    disp('0-170') ;
    k
    %----------------------------------------------------------------------
    
    y3 = filter(h3, 1, X);
    [z,p,k] = tf2zpk(h3,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,2);
    pzmap(tf(h3,1));
    figure(101);
    title('170-310 Hz'); 
    %gain
    disp('170-310') ;
    k
    %----------------------------------------------------------------------
    
    y4 = filter(h4, 1, X);
    [z,p,k] = tf2zpk(h4,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,3);
    pzmap(tf(h4,1));
    title('310-600 Hz');
    %gain
    disp('310-600') ;
    k
    %----------------------------------------------------------------------
    
    y5 = filter(h5, 1, X);
    [z,p,k] = tf2zpk(h5,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,4);
    pzmap(tf(h5,1));
    title('600-1K Hz');
    %gain
    disp('600-1K') ;
    k
    %----------------------------------------------------------------------
    
    y6 = filter(h6, 1, X);
    [z,p,k] = tf2zpk(h6,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,5);
    pzmap(tf(h6,1));
    title('1K-3K Hz');
    %gain
    disp('1K-3K') ;
    k
    %----------------------------------------------------------------------
    
    y7 = filter(h7, 1, X);
    [z,p,k] = tf2zpk(h7,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,6);
    pzmap(tf(h7,1));
    title('3K-6K Hz');
    %gain
    disp('3K-6K') ;
    k
    %----------------------------------------------------------------------
    
    y8 = filter(h8, 1, X);
    [z,p,k] = tf2zpk(h8,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,7);
    pzmap(tf(h8,1));
    title('6K-12K Hz'); 
    %gain
    disp('6K-12K') ; 
    k
    %----------------------------------------------------------------------
    
    y9 = filter(h9, 1, X);
    [z,p,k] = tf2zpk(h9,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,8);
    pzmap(tf(h9,1));
    title('12K-14K Hz');
    %gain
    disp('12K-14K') ; 
    k
    %----------------------------------------------------------------------
    
    y10 = filter(h10, 1, X);
    [z,p,k] = tf2zpk(h10,1);
    % zeros and poles plot
    figure(101)
    subplot(3,3,9);
    pzmap(tf(h10,1));
    title('14K-16K Hz');
    %gain
    disp('14K-16K'); 
    k
    %----------------------------------------------------------------------
    
else
    
    disp('IIR starts');
    %----------------------------------------------------------------------
    
    Wp= 170/temp; Ws=220/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'low');
    [sos,g] = zp2sos(z,p,k);
    y2 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    set(figure(102), 'name', 'Zeros and Poles of IIR filter')
    subplot(3,3,1); 
    zplane(z,p); title('0-170 Hz');
    % phase of IIR filter
    figure(202);
    set(figure(202),'name','Phase of IIR filter ');
    subplot(3,3,1);phasez(sos,512)
    title('0-170Hz');
    % Impulse response of digital filter
    figure(203)
    set(figure(203), 'name', 'Impulse response of IIR filter')
    subplot(3,3,1);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('0-170 HZ');
    % Step response of digital filter
    figure(204)
    set(figure(204), 'name', 'Step response of IIR filter')
    subplot(3,3,1);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g; 
    stem(tstep,hstep);
    title('0-170 HZ');
    %gain
    disp('0-170: ');
    k
    %----------------------------------------------------------------------
    
    Wp= [171 300]/temp; Ws=[121 350]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y3 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,2);
    zplane(z,p); title('170-310 Hz');
    % phase of IIR filter
    figure(202);
    figure(202);subplot(3,3,2); phasez(sos,512);  title('170-310 Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,2);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('170-310 HZ');
    % Step response of digital filter
    figure(204)
    subplot(3,3,2);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('170-310 HZ');
    %gain
    disp('170-310: ');
    k
    %----------------------------------------------------------------------
    
    Wp= [311 600]/temp; Ws=[261 650]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y4 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,3);
    zplane(z,p); title('310-600 Hz');
    % phase of IIR filter
    figure(202);
    figure(202);subplot(3,3,3); phasez(sos,512);  title('310-600 Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,3);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('310-600 Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,3);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('310-600 Hz');
    %gain
    disp('310-600: ');
    k
    %----------------------------------------------------------------------
    
    Wp = [601 1000]/temp; Ws=[551 1050]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y5 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,4);
    zplane(z,p); title('600-1K Hz');
    % phase of IIR filter
    figure(202);
    figure(202);subplot(3,3,4); phasez(sos,512);  title('600-1K Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,4);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('600-1K Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,4);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('600-1K Hz');
    %gain
    disp('600-1K: ');
    k
    %----------------------------------------------------------------------
    
    Wp = [1001 3000]/temp; Ws=[951 3050]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y6 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,5);
    zplane(z,p); title('1K-3K Hz');
    % phase of IIR filter
    figure(202);
    figure(202);subplot(3,3,5); phasez(sos,512);  title('1K-3K Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,5);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('1K-3K Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,5);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('1K-3K Hz');
    %gain
    disp('1K-3K: ');
    k
    %----------------------------------------------------------------------
    
    Wp= [3001 6000]/temp; Ws=[2951 6050]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y7 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,6);
    zplane(z,p); title('3K-6K Hz');
    % phase of IIR filter
    figure(202);
    figure(202);subplot(3,3,6); phasez(sos,512);  title('3K-6K Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,6);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('3K-6K Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,6);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('3K-6K Hz');
    %gain
    disp('3K-6K: ');
    k
    %----------------------------------------------------------------------
    
    Wp= [6001 12000]/temp; Ws=[5950 12050]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y8 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,7);
    zplane(z,p); title ('6K-12K Hz');
    % phase of IIR filter
   %[a,b]=zp2tf(z,p,k);
    figure(202);subplot(3,3,7); phasez(sos,512);  title('6K-12K Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,7);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('6K-12K Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,7);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('6K-12K Hz');
    %gain
    disp('6K-12K:');
    k
    %----------------------------------------------------------------------
    
    Wp= [12001 14000]/temp; Ws=[11950 14050]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y9 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,8);
    zplane(z,p); title ('12K-14K Hz');
    % phase of IIR filter
    figure(202);
    figure(202);subplot(3,3,8); phasez(sos,512);  title('12K-14K Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,8);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('12K-14K Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,8);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('12K-14K Hz');
    %gain
    disp('12K-14K:');
    k
    %----------------------------------------------------------------------
    
    Wp= [14001 16000]/temp; Ws=[13950 16050]/temp;
    [n,Wn]= buttord(Wp,Ws,4,8);
    [z,p,k] = butter(n,Wn, 'bandpass');
    [sos,g] = zp2sos(z,p,k);
    y10 = filtfilt(sos,g,X);
    % poles and zeros of IIR
    figure(102);
    subplot(3,3,9);
    zplane(z,p); title ('14k-16K Hz');
    % phase of IIR filter
    figure(202);subplot(3,3,9); phasez(sos,512);  title('14K-16K Hz');
    % Impulse response of digital filter
    figure(203)
    subplot(3,3,9);
    [himp,timp] = impz(sos); himp = himp*g; stem(timp,himp)
    title('14K-16K Hz');
    % Step response of digital filter
    figure(204)
    subplot(3,3,9);
    [hstep,tstep] = stepz(sos);
    hstep = hstep*g;
    stem(tstep,hstep);
    title('14K-16K Hz');
    %gain
    disp('14K-16K:');
    k
    %----------------------------------------------------------------------

end
disp('make_filters is done');


function output_signal()
disp('output_signal is called');

global y2; 
global y3; 
global y4; 
global y5;
global y6;
global y7;
global y8;
global y9;
global y10;

global gain;
global player;
global X;
global new_Fs;
global y;

for i = 1:9
    gain(i) = 10^(gain(i)/20);
end

y = y2*gain(1) + y3*gain(2) + y4*gain(3) + y5*gain(4) + y6*gain(5) + y7*gain(6) + y8*gain(7) + y9*gain(8) + y10*gain(9); % summing filter output after multiplied by gain of each one

if y == 0
    y = X;
end

player = audioplayer(y, new_Fs);
disp('output_signal is done');


function update_Fs()
disp('update_Fs is called');
global player;
global y;
global new_Fs;
pause(player)
player = audioplayer(y, new_Fs);
play(player)
disp('update_Fs is done');



% --- Executes on button press in play_btn.
function play_btn_Callback(hObject, eventdata, handles)
% hObject    handle to play_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('play button is pressed');
output_signal()
global player;

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


% --- Executes on button press in input_plot_btn.
function input_plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to input_plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X;
global Fs;
global info;
t = linspace(0,info.TotalSamples/Fs,length(X));
axes(handles.input_axes);
plot(t,X);


% --- Executes on button press in output_plot_btn.
function output_plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to output_plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y;
global new_Fs;
global info;
t = linspace(0,info.TotalSamples/new_Fs,length(y));
axes(handles.output_axes);
plot(t,y);


% --- Executes when gui_window is resized.
function gui_window_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to gui_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%{
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
%}

% --- Executes when user attempts to close gui_window.
function gui_window_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gui_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);

% --- Executes during object creation, after setting all properties.
function input_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate input_axes

% --- Executes during object creation, after setting all properties.
function output_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate output_axes

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

function edit_newFs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_newFs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_newFs as text
%        str2double(get(hObject,'String')) returns contents of edit_newFs as a double
global new_Fs;
new_Fs = str2num(get(hObject,'string'));
update_Fs()
output_signal()

% --- Executes during object creation, after setting all properties.
function edit_newFs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_newFs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in fir_btn.
function fir_btn_Callback(hObject, eventdata, handles)
% hObject    handle to fir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of fir_btn

% --- Executes on button press in iir_btn.
function iir_btn_Callback(hObject, eventdata, handles)
% hObject    handle to iir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of iir_btn

% --- Executes during object creation, after setting all properties.
function fir_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function iir_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes when selected object is changed in filter_type_grp.
function filter_type_grp_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in filter_type_grp 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FIR;


selected = get(handles.filter_type_grp,'SelectedObject');

if strcmp(selected.String, 'FIR') == 1
    FIR = 1;
else
    FIR = 0;
end
make_filters()
output_signal()


    % --- Executes on button press in save_btn.
function save_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y;
global new_Fs;
audiowrite('output.wav',y,new_Fs);
%mp3write(y,new_Fs,'output.mp3');


% --- Executes on button press in plot2_filters_btn.
function plot2_filters_btn_Callback(hObject, eventdata, handles)
% hObject    handle to plot2_filters_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Filter 1 try
global y2;
global y3;
global y4;
global y5;
global y6;
global y7;
global y8;
global y9;
global y10;


%Filter Y2,Y3,Y4 plot
figure(1);
plot_signal_freqdomain(y2,y3,y4,'0~170 HZ','170~310 HZ','310~600 HZ');
set(figure(1),'name','Y2,Y3,Y4');

%Filter Y5,Y6,Y7 plot
figure(2);
plot_signal_freqdomain(y5,y6,y7, '600~1000 HZ','1000~3000 HZ','3000~6000 HZ');
set(figure(2),'name','Y5,Y6,Y7');

%Filter Y8,Y9,Y10 plot
figure(3);
plot_signal_freqdomain(y8,y9,y10,'6000~12000 HZ','12000~14000 HZ','14000~16000 HZ');
set(figure(3),'name','Y8,Y9,Y10');


function plot3_filters_btn_Callback(hObject, eventdata, handles)
% hObject    handle to plot3_filters_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global y;
global y2;
global y3;
global y4;
global y5;
global y6;
global y7;
global y8;
global y9;
global y10;

figure(1);
plot_signal_timedomain(y,y2,y3,y4,y5,y6,y7,y8,y9,y10);
set(figure(1),'name','Time Domain');


%Function Draws Frequency Responce of filters signals
function plot_signal_freqdomain(y1, y2, y3, band1, band2, band3)
global info;
global new_Fs;

%Y1 signal magnitude and phase
%Magnitude
t = linspace(0,info.TotalSamples,length(y1));
Fvec = linspace(-new_Fs/2,new_Fs/2,length(t));
y2plot = fftshift(fft(y1));
subplot(2,3,1);
plot(Fvec,abs(y2plot));
grid;
title(band1);
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%Phase
subplot(2,3,4);
plot(Fvec,angle(y2plot));
grid;
title('Phase spectrum');
xlabel('Frequency (Hz)');
ylabel('Angle');
xlim([-3,3]);

%Y2 signal magnitude and phase
%Magnitude
t = linspace(0,info.TotalSamples,length(y2));
Fvec = linspace(-new_Fs/2,new_Fs/2,length(t));
y2plot = fftshift(fft(y2));
subplot(2,3,2);
plot(Fvec,abs(y2plot));
grid;
title(band2);
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%Phase
subplot(2,3,5);
plot(Fvec,angle(y2plot));
grid;
title('Phase spectrum');
xlabel('Frequency (Hz)');
ylabel('Angle');
xlim([-3,3]);


%Y3 signal magnitude and phase
%Magnitude
t = linspace(0,info.TotalSamples,length(y3));
Fvec = linspace(-new_Fs/2,new_Fs/2,length(t));
y2plot = fftshift(fft(y3));
subplot(2,3,3);
plot(Fvec,abs(y2plot));
grid;
title(band3);
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%Phase
subplot(2,3,6);
plot(Fvec,angle(y2plot));
grid;
title('Phase spectrum');
xlabel('Frequency (Hz)');
ylabel('Angle');
xlim([-3,3]);

% Function to draw the time domain of filters signals
function plot_signal_timedomain(y,y1,y2,y3,y4,y5,y6,y7,y8,y9)
global info;
global new_Fs;
t = linspace(0,info.TotalSamples/new_Fs,length(y));
%Y1 :0~170 HZ
subplot(3,3,1);
plot(t,y1);
grid;
title('0~170 HZ');
xlabel('t');
ylabel('y(t)');

%Y2 :171~310 HZ
subplot(3,3,2);
plot(t,y2);
grid;
title('170~310 HZ');
xlabel('t');
ylabel('y(t)');

%Y3 :311~600 HZ
subplot(3,3,3);
plot(t,y3);
grid;
title('310~600 HZ');
xlabel('t');
ylabel('y(t)');

%Y4 :601~1000 HZ
subplot(3,3,4);
plot(t,y4);
grid;
title('600~1000 HZ');
xlabel('t');
ylabel('y(t)');

%Y5 :1001~3000 HZ
subplot(3,3,5);
plot(t,y5);
grid;
title('1000~3000 HZ');
xlabel('t');
ylabel('y(t)');

%Y6 :3001~6000 HZ
subplot(3,3,6);
plot(t,y6);
grid;
title('3000~6000 HZ');
xlabel('t');
ylabel('y(t)');

%Y7 :6001~12000 HZ
subplot(3,3,7);
plot(t,y7);
grid;
title('6000~12000 HZ');
xlabel('t');
ylabel('y(t)');

%Y8 :12001~14000 HZ
subplot(3,3,8);
plot(t,y8);
grid;
title('12000~14000 HZ');
xlabel('t');
ylabel('y(t)');

%Y9 :14001~16000 HZ
subplot(3,3,9);
plot(t,y9);
grid;
title('14000~16000 HZ');
xlabel('t');
ylabel('y(t)');


function plot_io_signals()
global info;
global new_Fs;
global Fs;
global X;
global y;
%INPUT
%Magnitude
t = linspace(0,info.TotalSamples,length(X));
Fvec = linspace(-Fs/2,Fs/2,length(t));
Signalplot = fftshift(fft(X));
subplot(2,2,1);
plot(Fvec,abs(Signalplot));
grid;
title('Input Signal Magnitude');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%Phase
subplot(2,2,3);
plot(Fvec,angle(Signalplot));
grid;
title('Phase spectrum');
xlabel('Frequency (Hz)');
ylabel('Angle');
xlim([-3,3]);

%Output
%Magnitude
t = linspace(0,info.TotalSamples,length(y));
Fvec = linspace(-new_Fs/2,new_Fs/2,length(t));
Signalplot = fftshift(fft(y));
subplot(2,2,2);
plot(Fvec,abs(Signalplot));
grid;
title('Output Signal Magnitude');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%Phase
subplot(2,2,4);
plot(Fvec,angle(Signalplot));
grid;
title('Phase spectrum');
xlabel('Frequency (Hz)');
ylabel('Angle');
xlim([-3,3]);



% --- Executes on button press in in_out_btn.
function in_out_btn_Callback(hObject, eventdata, handles)
% hObject    handle to in_out_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(10);
set(figure(10),'name','Input - Output signals');
plot_io_signals();


