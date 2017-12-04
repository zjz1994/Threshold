function varargout = Threshold(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                        Threshold Application
%                               By ZJZ
%                              Ver 0.3
%                        Create by 2017.09.06
%                      Last Update By 2017.12.04
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             UPDATE
% 2017.09.06 First Building
% 2017.11.19 Add Save Button
% 2017.12.04 Add Layer Function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You can clone it in: https://github.com/zjz1994/Threshold.git
%
%

% THRESHOLD M-file for Threshold.fig
%      THRESHOLD, by itself, creates a new THRESHOLD or raises the existing
%      singleton*.
%
%      H = THRESHOLD returns the handle to a new THRESHOLD or the handle to
%      the existing singleton*.
%
%      THRESHOLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THRESHOLD.M with the given input arguments.
%
%      THRESHOLD('Property','Value',...) creates a new THRESHOLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Threshold_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Threshold_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Threshold

% Last Modified by GUIDE v2.5 04-Dec-2017 16:52:35


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Threshold_OpeningFcn, ...
    'gui_OutputFcn',  @Threshold_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Threshold is made visible.
function Threshold_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Threshold (see VARARGIN)

% Choose default command line output for Threshold
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Threshold wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Threshold_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OrgImgData GrayImgData;
[Filename,Pathname]=uigetfile({'*.jpg'},'Select a Picture');
res=[Pathname Filename];
if (Filename~=0)
    set(handles.edit1,'String',res);
    OrgImgData=imread(res);
    imshow(OrgImgData, 'Parent', handles.axes1);
    sz=size(OrgImgData);
    GrayImgData=zeros(sz(1),sz(2));
    for i=1:1:sz(1)
        for j=1:1:sz(2);
            GrayImgData(i,j)=(double(OrgImgData(i,j,1))*0.299 + double(OrgImgData(i,j,2))*0.587 + double(OrgImgData(i,j,3))*0.114)/255;
        end
    end
    imshow(GrayImgData, 'Parent', handles.axes2);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global OrgImgData GrayImgData;
ts=get(hObject,'Value')/255;
BitImgData=get_threshold_dark(ts);
imshow(BitImgData, 'Parent', handles.axes2);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imsave(handles.axes2);


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
L_count=floor(get(hObject,'Value'));
set(handles.text1,'String',[num2str(L_count),' Layer']);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function BitImgData = get_threshold_window(int_bottom,int_top)
global OrgImgData GrayImgData;
ts=int_bottom;
sz=size(GrayImgData);
BitImgData=zeros(sz(1),sz(2));
for i=1:1:sz(1)
    for j=1:1:sz(2);
        if GrayImgData(i,j)>=int_bottom && int_top>=GrayImgData(i,j)
            BitImgData(i,j)=0;
        else
            BitImgData(i,j)=1;
        end
    end
end

function BitImgData = get_threshold_dark(int_bottom)
global OrgImgData GrayImgData;
ts=int_bottom;
sz=size(GrayImgData);
BitImgData=zeros(sz(1),sz(2));
for i=1:1:sz(1)
    for j=1:1:sz(2);
        if GrayImgData(i,j)>=ts
            BitImgData(i,j)=1;
        else
            BitImgData(i,j)=0;
        end
    end
end

function img_arr = split(times)
img_arr=[];
if times<=1
    BitImgData = get_threshold_dark(0.5);
    img_arr{1}=BitImgData;
else
pice=1/times;
for i=0:1:(times-1)
    BitImgData = get_threshold_window(i*pice,(i+1)*pice);
    img_arr{i+1}=BitImgData;
end
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global split_img_arr layer_count;
now_count=get(hObject,'Value');
if now_count<=layer_count
    imshow(split_img_arr{now_count}, 'Parent', handles.axes2);
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global split_img_arr layer_count;
split_img_arr={};
times=floor(get(handles.slider3,'Value'));
layer_count=times;
str='';
for i=1:1:times
    str=[str,'Layer ',num2str(i),'|'];
end
split_img_arr = split(times);
set(handles.listbox1,'String',str);
set(handles.listbox1,'Value',1);
