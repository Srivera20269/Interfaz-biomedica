function varargout = HMI(varargin)
% HMI MATLAB code for HMI.fig
%      HMI, by itself, creates a new HMI or raises the existing
%      singleton*.
%
%      H = HMI returns the handle to a new HMI or the handle to
%      the existing singleton*.
%
%      HMI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HMI.M with the given input arguments.
%
%      HMI('Property','Value',...) creates a new HMI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HMI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HMI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HMI_OpeningFcn, ...
                   'gui_OutputFcn',  @HMI_OutputFcn, ...
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


% --- Executes just before HMI is made visible.
function HMI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HMI (see VARARGIN)

% Choose default command line output for HMI
handles.output = hObject;



%% DESIGNACIONES
%ANTE       = ANTEBRAZO             => PRONACION - SUPINACION
%MUNE_DES   = MUN~ECA DESVIACIONES  => DESVIACION RADIAL - CUBITAL  
%MUNE_EXT   = MUN~ECA EXTENSIONES   => EXTENSIÓN - FLEXIÓN       
%INDI       = DEDO INDICE           => EXTENSIÓN - FLEXIÓN
%MEDI       = DEDO MEDIO            => EXTENSIÓN - FLEXIÓN         
%ANUL       = DEDO ANULAR           => EXTENSIÓN - FLEXIÓN
%MENI       = DEDO MEN~IQUE         => EXTENSIÓN - FLEXIÓN
%PULG       = DEDO PULGAR           => EXTENSIÓN - FLEXIÓN         
%PULG_META  = DEDO PULGAR METACARPO => EXTENSIÓN - FLEXIÓN     

%% VARIABLES

%DEFINICIÓN DE MAXIMOS Y MINIMOS
MAX_ANTE = 50;          MIN_ANTE = -50;
MAX_MUNE_DES = 30;      MIN_MUNE_DES = -30;
MAX_MUNE_EXT = 30;      MIN_MUNE_EXT = -30;
MAX_INDI = 90;          MIN_INDI = 0;
MAX_MEDI = 90;          MIN_MEDI = 0;
MAX_ANUL = 90;          MIN_ANUL = 0;
MAX_MENI = 90;          MIN_MENI = 0;
MAX_PULG = 90;          MIN_PULG = 0;
MAX_PULG_META = 90;     MIN_PULG_META = 0;        

%% INICIO

%SE CONECTA CON EL OBJETO
OpenCM = serial('COM3');
fopen(OpenCM);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HMI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HMI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in STRTCK.
function STRTCK_Callback(hObject, eventdata, handles)
% hObject    handle to STRTCK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject, 'Value')    
    set(handles.STRTCK,'BackgroundColor',[0.9,0,0]);    
    set(handles.STRTCK,'String','Running');
    set(handles.GRO,'String','pushed GO');        
    while 1
        
        pause(0.05);
    f=matleap_frame; %%LECTURA DE FRAME
    %pause(1.0);
        
    NUM_MANOS = size(f.hands,2); %NUMERO DE MANOS
    
    if (NUM_MANOS == 1)
         fprintf('UNA MANO\n')
         
         DERECHA = f.hands.type;
         if (DERECHA == 1)
             fprintf('DERECHA\n')
             
            %PRONACIÓN SUPINACIÓN
            ANTEBRAZO = f.hands.arm.rotation;
            ORIENTACION_ANTEBRAZO = quat2eul(ANTEBRAZO,'XYZ');
            ORIENTACION_ANTEBRAZO = rad2deg(ORIENTACION_ANTEBRAZO);

            ANG_ANTEBRAZO = ORIENTACION_ANTEBRAZO(1);               %UTIL
            
            ANG_ANTEBRAZO_DIRECCION = ORIENTACION_ANTEBRAZO(2);
            if (sign(ORIENTACION_ANTEBRAZO(3)) == 1)
                ANG_ANTEBRAZO_TRANS = 180-(ORIENTACION_ANTEBRAZO(3));
            else
                ANG_ANTEBRAZO_TRANS = -(180+ORIENTACION_ANTEBRAZO(3));
            end

            %%EXTENSIÓN_FLEXION Y DESVIACIÓN RADIA_CUBITAL
            VEC_DIR= f.hands.palm.direction;
            ANG_PALMA_X = 90-acosd(VEC_DIR(2));
            ANG_PALMA_Y = -(90+atan2d(VEC_DIR(3),VEC_DIR(1)));

            ANG_MUNE_EXT = ANG_ANTEBRAZO_TRANS-ANG_PALMA_X;         %UTIL
            ANG_MUNE_DES = ANG_ANTEBRAZO_DIRECCION - ANG_PALMA_Y;   %UTIL
             
            
            %%EXTENSIÓN_FLEXION DEDOS
            VEC_NORMAL = f.hands.palm.normal;
            
            %%INDICE
            INDI_P = f.hands.digits(2).bones(2).prev_joint;
            INDI_N = f.hands.digits(2).bones(2).next_joint;
            INDI_VEC = INDI_N - INDI_P;
            
            ANG_INDI = ang_ProdPun(VEC_NORMAL,INDI_VEC);            %UTIL
            
            %%MEDIO
            MEDI_P = f.hands.digits(3).bones(2).prev_joint;
            MEDI_N = f.hands.digits(3).bones(2).next_joint;
            MEDI_VEC = MEDI_N - MEDI_P;
            
            ANG_MEDI= ang_ProdPun(VEC_NORMAL,MEDI_VEC);            %UTIL
            
            %%ANULAR
            ANUL_P = f.hands.digits(4).bones(2).prev_joint;
            ANUL_N = f.hands.digits(4).bones(2).next_joint;
            ANUL_VEC = ANUL_N - ANUL_P;
            
            ANG_ANUL = ang_ProdPun(VEC_NORMAL,ANUL_VEC);            %UTIL
            
            %%MENIQUE
            MENI_P = f.hands.digits(5).bones(2).prev_joint;
            MENI_N = f.hands.digits(5).bones(2).next_joint;
            MENI_VEC = MENI_N - MENI_P;
            
            ANG_MENI= ang_ProdPun(VEC_NORMAL,MENI_VEC);            %UTIL
            
            %%PULGAR METACARPIAL
            PULG_META_P = f.hands.digits(1).bones(2).prev_joint;
            PULG_META_N = f.hands.digits(1).bones(2).next_joint;
            PULG_META_VEC = PULG_META_N - PULG_META_P;
            
            ANG_PULG_META= ang_ProdPun(VEC_NORMAL,PULG_META_VEC);  %UTIL 
            
            %%PULGAR DISTAL
            PULM_PROX_P = f.hands.digits(1).bones(3).prev_joint;
            PULM_PROX_N = f.hands.digits(1).bones(3).next_joint;
            PULM_PROX_VEC = PULM_PROX_N - PULM_PROX_P;
            
            PULM_DIST_P = f.hands.digits(1).bones(4).prev_joint;
            PULM_DIST_N = f.hands.digits(1).bones(4).next_joint;
            PULM_DIST_VEC = PULM_DIST_N - PULM_DIST_P;
            
            ANG_PULG = ang_ProdPun(PULM_PROX_VEC, PULM_DIST_VEC);  %UTIL 
                       
            %ARREGLO DE DATOS (ORDEN DE SERVOS)         
            ANTE        = COTA(ANG_ANTEBRAZO, MAX_ANTE, MIN_ANTE);
            MUNE_DES    = COTA(ANG_MUNE_DES, MAX_MUNE_DES, MIN_MUNE_DES);
            MUNE_EXT    = COTA(ANG_MUNE_EXT, MAX_MUNE_EXT, MIN_MUNE_EXT);  
            PULG        = COTA(ANG_PULG, MAX_PULG, MIN_PULG);  
            PULG_META   = COTA(ANG_PULG_META, MAX_PULG_META, MIN_PULG_META);  
            INDI        = COTA(ANG_INDI, MAX_INDI, MIN_INDI);  
            MEDI        = COTA(ANG_MEDI, MAX_MEDI, MIN_MEDI);
            ANUL        = COTA(ANG_ANUL, MAX_ANUL, MIN_ANUL);
            MENI        = COTA(ANG_MENI, MAX_MENI, MIN_MENI);
        
        if ~get(hObject, 'Value')
            break
        end       
    end
else
    set(handles.STRTCK,'BackgroundColor',[0,0.9,0]);
    set(handles.STRTCK,'String','OFF');
    set(handles.STRTCK,'String','Press to Run');    
end


% --- Executes on button press in STRTCK.
function SNDATA_Callback(hObject, eventdata, handles)
% hObject    handle to STRTCK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject, 'Value')    
    set(handles.STRTCK,'BackgroundColor',[0.9,0,0]);    
    set(handles.STRTCK,'String','Running');
    set(handles.GRO,'String','pushed GO');        
    while 1
        
        pause(0.05);
    f=matleap_frame; %%LECTURA DE FRAME
    %pause(1.0);
        
    NUM_MANOS = size(f.hands,2); %NUMERO DE MANOS
    
    if (NUM_MANOS == 1)
         fprintf('UNA MANO\n')
         
         DERECHA = f.hands.type;
         if (DERECHA == 1)
             fprintf('DERECHA\n')
             
            %PRONACIÓN SUPINACIÓN
            ANTEBRAZO = f.hands.arm.rotation;
            ORIENTACION_ANTEBRAZO = quat2eul(ANTEBRAZO,'XYZ');
            ORIENTACION_ANTEBRAZO = rad2deg(ORIENTACION_ANTEBRAZO);

            ANG_ANTEBRAZO = ORIENTACION_ANTEBRAZO(1);               %UTIL
            
            ANG_ANTEBRAZO_DIRECCION = ORIENTACION_ANTEBRAZO(2);
            if (sign(ORIENTACION_ANTEBRAZO(3)) == 1)
                ANG_ANTEBRAZO_TRANS = 180-(ORIENTACION_ANTEBRAZO(3));
            else
                ANG_ANTEBRAZO_TRANS = -(180+ORIENTACION_ANTEBRAZO(3));
            end

            %%EXTENSIÓN_FLEXION Y DESVIACIÓN RADIA_CUBITAL
            VEC_DIR= f.hands.palm.direction;
            ANG_PALMA_X = 90-acosd(VEC_DIR(2));
            ANG_PALMA_Y = -(90+atan2d(VEC_DIR(3),VEC_DIR(1)));

            ANG_MUNE_EXT = ANG_ANTEBRAZO_TRANS-ANG_PALMA_X;         %UTIL
            ANG_MUNE_DES = ANG_ANTEBRAZO_DIRECCION - ANG_PALMA_Y;   %UTIL
             
            
            %%EXTENSIÓN_FLEXION DEDOS
            VEC_NORMAL = f.hands.palm.normal;
            
            %%INDICE
            INDI_P = f.hands.digits(2).bones(2).prev_joint;
            INDI_N = f.hands.digits(2).bones(2).next_joint;
            INDI_VEC = INDI_N - INDI_P;
            
            ANG_INDI = ang_ProdPun(VEC_NORMAL,INDI_VEC);            %UTIL
            
            %%MEDIO
            MEDI_P = f.hands.digits(3).bones(2).prev_joint;
            MEDI_N = f.hands.digits(3).bones(2).next_joint;
            MEDI_VEC = MEDI_N - MEDI_P;
            
            ANG_MEDI= ang_ProdPun(VEC_NORMAL,MEDI_VEC);            %UTIL
            
            %%ANULAR
            ANUL_P = f.hands.digits(4).bones(2).prev_joint;
            ANUL_N = f.hands.digits(4).bones(2).next_joint;
            ANUL_VEC = ANUL_N - ANUL_P;
            
            ANG_ANUL = ang_ProdPun(VEC_NORMAL,ANUL_VEC);            %UTIL
            
            %%MENIQUE
            MENI_P = f.hands.digits(5).bones(2).prev_joint;
            MENI_N = f.hands.digits(5).bones(2).next_joint;
            MENI_VEC = MENI_N - MENI_P;
            
            ANG_MENI= ang_ProdPun(VEC_NORMAL,MENI_VEC);            %UTIL
            
            %%PULGAR METACARPIAL
            PULG_META_P = f.hands.digits(1).bones(2).prev_joint;
            PULG_META_N = f.hands.digits(1).bones(2).next_joint;
            PULG_META_VEC = PULG_META_N - PULG_META_P;
            
            ANG_PULG_META= ang_ProdPun(VEC_NORMAL,PULG_META_VEC);  %UTIL 
            
            %%PULGAR DISTAL
            PULM_PROX_P = f.hands.digits(1).bones(3).prev_joint;
            PULM_PROX_N = f.hands.digits(1).bones(3).next_joint;
            PULM_PROX_VEC = PULM_PROX_N - PULM_PROX_P;
            
            PULM_DIST_P = f.hands.digits(1).bones(4).prev_joint;
            PULM_DIST_N = f.hands.digits(1).bones(4).next_joint;
            PULM_DIST_VEC = PULM_DIST_N - PULM_DIST_P;
            
            ANG_PULG = ang_ProdPun(PULM_PROX_VEC, PULM_DIST_VEC);  %UTIL 
                       
            %ARREGLO DE DATOS (ORDEN DE SERVOS)         
            ANTE        = COTA(ANG_ANTEBRAZO, MAX_ANTE, MIN_ANTE);
            MUNE_DES    = COTA(ANG_MUNE_DES, MAX_MUNE_DES, MIN_MUNE_DES);
            MUNE_EXT    = COTA(ANG_MUNE_EXT, MAX_MUNE_EXT, MIN_MUNE_EXT);  
            PULG        = COTA(ANG_PULG, MAX_PULG, MIN_PULG);  
            PULG_META   = COTA(ANG_PULG_META, MAX_PULG_META, MIN_PULG_META);  
            INDI        = COTA(ANG_INDI, MAX_INDI, MIN_INDI);  
            MEDI        = COTA(ANG_MEDI, MAX_MEDI, MIN_MEDI);
            ANUL        = COTA(ANG_ANUL, MAX_ANUL, MIN_ANUL);
            MENI        = COTA(ANG_MENI, MAX_MENI, MIN_MENI);
        
        if ~get(hObject, 'Value')
            break
        end       
    end
else
    set(handles.STRTCK,'BackgroundColor',[0,0.9,0]);
    set(handles.STRTCK,'String','OFF');
    set(handles.STRTCK,'String','Press to Run');    
end
