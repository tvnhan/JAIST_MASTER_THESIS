function varargout = ChooseLocationGroundFootGUI(varargin)
% CHOOSELOCATIONGROUNDFOOTGUI MATLAB code for ChooseLocationGroundFootGUI.fig
%      CHOOSELOCATIONGROUNDFOOTGUI, by itself, creates a new CHOOSELOCATIONGROUNDFOOTGUI or raises the existing
%      singleton*.
%
%      H = CHOOSELOCATIONGROUNDFOOTGUI returns the handle to a new CHOOSELOCATIONGROUNDFOOTGUI or the handle to
%      the existing singleton*.
%
%      CHOOSELOCATIONGROUNDFOOTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHOOSELOCATIONGROUNDFOOTGUI.M with the given input arguments.
%
%      CHOOSELOCATIONGROUNDFOOTGUI('Property','Value',...) creates a new CHOOSELOCATIONGROUNDFOOTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ChooseLocationGroundFootGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ChooseLocationGroundFootGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ChooseLocationGroundFootGUI

% Last Modified by GUIDE v2.5 20-Dec-2013 02:26:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ChooseLocationGroundFootGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ChooseLocationGroundFootGUI_OutputFcn, ...
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


% --- Executes just before ChooseLocationGroundFootGUI is made visible.
function ChooseLocationGroundFootGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ChooseLocationGroundFootGUI (see VARARGIN)

% Choose default command line output for ChooseLocationGroundFootGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ChooseLocationGroundFootGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ChooseLocationGroundFootGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function etNumerPlate_Callback(hObject, eventdata, handles)
% hObject    handle to etNumerPlate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etNumerPlate as text
%        str2double(get(hObject,'String')) returns contents of etNumerPlate as a double


% --- Executes during object creation, after setting all properties.
function etNumerPlate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etNumerPlate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FOLDER;
global FOLDER_RENAME;
global filename;
global countRun; 
filepath = strcat(FOLDER,'\',filename{countRun});
chec = 0;
if (strfind(filename{countRun},'.JPG')>0)
    chec = 1;
end
if (strfind(filename{countRun},'.jpg')>0)
    chec = 1;
end
if (strfind(filename{countRun},'.bmp')>0)
    chec = 1;
end
if (chec==1)
    
    [pathstr, name, ext] = fileparts(filepath);
    figure(1); imshow(filepath);
    title(strcat(num2str(countRun),'/',num2str(size(filename,2))));
    [x,y] = ginput(2);
    x1 = int64(x(1));
    y1 = int64(y(1));
    x2 = int64(x(2));
    y2 = int64(y(2));
    area = (x2-x1)*(y2-y1);
    %             parseresult = strcat('[(%d)(%d)(%d)]');
    %             fprintf(fidTotal, '\n%s[(%d)(%d)(%d)]',name,x1,y1,area);
    strconcat = strcat('(',num2str(x1),')', ...
        '(',num2str(y1),')', ...
        '(',num2str(x2-x1),')' , ...
        '(',num2str(y2-y1),')');
    nameRe = strcat('7_[',get(handles.etNumerPlate,'string'),']');
    movefile(filepath,strcat(FOLDER_RENAME,'\',nameRe, ...
        '[',strconcat,']',ext));
end
countRun = countRun +1;
if (countRun <= size(filename,2))
    filepath = strcat(FOLDER,'\',filename{countRun});
    set(handles.etNumerPlate,'String', '');
    axes(handles.viewImage);
    imshow(filepath);
end

% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FOLDER;
global FOLDER_RENAME;
global filename;
global countRun;
FOLDER = 'D:\Do_an_Luan_van\Data Filter Use Test\Data collection\Q1-10-11h';
FOLDER_RENAME = strcat(FOLDER,'_Ren_wh_format');
if exist(FOLDER_RENAME,'dir') ==0
    mkdir(FOLDER_RENAME);
end
allFiles = dir(FOLDER);
filename = { allFiles.name };
countRun = 3;
filepath = strcat(FOLDER,'\',filename{countRun});
axes(handles.viewImage);
imshow(filepath);



function etLinkToFolder_Callback(hObject, eventdata, handles)
% hObject    handle to etLinkToFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etLinkToFolder as text
%        str2double(get(hObject,'String')) returns contents of etLinkToFolder as a double


% --- Executes during object creation, after setting all properties.
function etLinkToFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etLinkToFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.etLinkToFolder,'String', uigetdir('C:\', 'Choose folder contain data'));
