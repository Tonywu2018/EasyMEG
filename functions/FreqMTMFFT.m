function varargout = FreqMTMFFT(varargin)
% FREQMTMFFT MATLAB code for FreqMTMFFT.fig
%      FREQMTMFFT, by itself, creates a new FREQMTMFFT or raises the existing
%      singleton*.
%
%      H = FREQMTMFFT returns the handle to a new FREQMTMFFT or the handle to
%      the existing singleton*.
%
%      FREQMTMFFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREQMTMFFT.M with the given input arguments.
%
%      FREQMTMFFT('Property','Value',...) creates a new FREQMTMFFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FreqMTMFFT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FreqMTMFFT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FreqMTMFFT

% Last Modified by GUIDE v2.5 11-Dec-2016 15:33:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FreqMTMFFT_OpeningFcn, ...
                   'gui_OutputFcn',  @FreqMTMFFT_OutputFcn, ...
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


% --- Executes just before FreqMTMFFT is made visible.
function FreqMTMFFT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FreqMTMFFT (see VARARGIN)

% Choose default command line output for FreqMTMFFT
handles.output = hObject;
handles.cfg = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FreqMTMFFT wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FreqMTMFFT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.cfg;

delete(handles.figure1);



% --- Executes on button press in rbtnFoiBand.
function rbtnFoiBand_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnFoiBand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnFoiBand
if get(hObject,'Value')
    set(handles.rbtnFoi,'Value',0);
    set(handles.editFoi,'Enable','Off');
    set(handles.editFoiBand,'Enable','On');
else
    set(handles.rbtnFoi,'Value',1);
    set(handles.editFoi,'Enable','On');
    set(handles.editFoiBand,'Enable','Off');
end


% --- Executes on button press in rbtnFoi.
function rbtnFoi_Callback(hObject, eventdata, handles)
% hObject    handle to rbtnFoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbtnFoi
if get(hObject,'Value')
    set(handles.rbtnFoiBand,'Value',0);
    set(handles.editFoi,'Enable','On');
    set(handles.editFoiBand,'Enable','Off');
else
    set(handles.rbtnFoiBand,'Value',1);
    set(handles.editFoi,'Enable','Off');
    set(handles.editFoiBand,'Enable','On');
end


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1);

% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfg = [];
outout          = {'pow','powandcsd','fourier'};
cfg.output      = outout{get(handles.popOutput,'Value')};
cfg.channel     = eval(get(handles.editChannel,'String'));

cfg.trials      = eval(get(handles.editTrials,'String'));
keeptrials      = {'no','yes'};
cfg.keeptrials  = keeptrials{get(handles.popKeepTrials,'Value')};
keeptapers      = {'no','yes'};
cfg.keeptapers  = keeptapers{get(handles.popKeepTapers,'Value')};
cfg.pad         = eval(get(handles.editPad,'String'));
padtype         = {'zero','mean','localmean','edge','mirror','nan','remove'};
cfg.padtype     = padtype{get(handles.popPadType,'Value')};
cfg.polyremoval = eval(get(handles.editPolyremoval,'String'));

if ~isempty(get(handles.editTapSmoFrq,'String'))
    cfg.tapsmofrq   = eval(get(handles.editTapSmoFrq,'String'));
end

if ~isempty(get(handles.editTaper,'String'))
    cfg.taper       = eval(get(handles.editTaper,'String'));
end

if get(handles.rbtnFoiBand,'Value')
    cfg.foilim = eval(get(handles.editFoiBand,'String'));
else
    cfg.foi = eval(get(handles.editFoi,'String'));
end

handles.cfg = cfg;

guidata(hObject, handles);
uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
% The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
% The GUI is no longer waiting, just close it
    delete(hObject);
end
