

%% DESIGNACIONES
%ANTE       = ANTEBRAZO             => PRONACION - SUPINACION
%MUNE_DES   = MUN~ECA DESVIACIONES  => DESVIACION RADIAL - CUBITAL  
%MUNE_EXT   = MUN~ECA EXTENSIONES   => EXTENSI�N - FLEXI�N       
%INDI       = DEDO INDICE           => EXTENSI�N - FLEXI�N
%MEDI       = DEDO MEDIO            => EXTENSI�N - FLEXI�N         
%ANUL       = DEDO ANULAR           => EXTENSI�N - FLEXI�N
%MENI       = DEDO MEN~IQUE         => EXTENSI�N - FLEXI�N
%PULG       = DEDO PULGAR           => EXTENSI�N - FLEXI�N         
%PULG_META  = DEDO PULGAR METACARPO => EXTENSI�N - FLEXI�N     

%% VARIABLES

%DEFINICI�N DE MAXIMOS Y MINIMOS
MAX_ANTE = 50;          MIN_ANTE = -50;
MAX_MUNE_DES = 30;      MIN_MUNE_DES = -30;
MAX_MUNE_EXT = 30;      MIN_MUNE_EXT = -30;
MAX_INDI = 90;          MIN_INDI = 0;
MAX_MEDI = 90;          MIN_MEDI = 0;
MAX_ANUL = 90;          MIN_ANUL = 0;
MAX_MENI = 90;          MIN_MENI = 0;
MAX_PULG = 90;          MIN_PULG = 0;
MAX_PULG_META = 70;     MIN_PULG_META = 0;        

%% INICIO

%SE CONECTA CON EL OBJETO
OpenCM = serial('COM3');
fopen(OpenCM);

for i = 1:1000
    pause(0.05);
    f=matleap_frame; %%LECTURA DE FRAME
    %pause(1.0);
        
    NUM_MANOS = size(f.hands,2); %NUMERO DE MANOS
    
    if (NUM_MANOS == 1)
         fprintf('UNA MANO\n')
         
         DERECHA = f.hands.type;
         if (DERECHA == 1)
             fprintf('DERECHA\n')
             
            %PRONACI�N SUPINACI�N
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

            %%EXTENSI�N_FLEXION Y DESVIACI�N RADIA_CUBITAL
            VEC_DIR= f.hands.palm.direction;
            ANG_PALMA_X = 90-acosd(VEC_DIR(2));
            ANG_PALMA_Y = -(90+atan2d(VEC_DIR(3),VEC_DIR(1)));

            ANG_MUNE_EXT = ANG_ANTEBRAZO_TRANS-ANG_PALMA_X;         %UTIL
            ANG_MUNE_DES = ANG_ANTEBRAZO_DIRECCION - ANG_PALMA_Y;   %UTIL
             
            
            %%EXTENSI�N_FLEXION DEDOS
            VEC_NORMAL = f.hands.palm.normal;
            
            %%INDICE
            INDI_P = f.hands.digits(2).bones(2).prev_joint;
            INDI_N = f.hands.digits(2).bones(2).next_joint;
            INDI_VEC = INDI_N - INDI_P;
            
            ANG_INDI = 2*ang_ProdPun(VEC_NORMAL,INDI_VEC)-90;            %UTIL
            if (ANG_INDI > 100)
                ANG_INDI = 100;
            elseif (ANG_INDI < 0)
                ANG_INDI = 0;
            end
            ANG_INDI = 100-ANG_INDI;
            
            %%MEDIO
            MEDI_P = f.hands.digits(3).bones(2).prev_joint;
            MEDI_N = f.hands.digits(3).bones(2).next_joint;
            MEDI_VEC = MEDI_N - MEDI_P;
            
            ANG_MEDI= 2*ang_ProdPun(VEC_NORMAL,MEDI_VEC)-80;            %UTIL
            if (ANG_MEDI> 100)
                ANG_MEDI = 100;
            elseif (ANG_MEDI < 0)
                ANG_MEDI = 0;
            end
            ANG_MEDI= 100-ANG_MEDI;
            
            
            %%ANULAR
            ANUL_P = f.hands.digits(4).bones(2).prev_joint;
            ANUL_N = f.hands.digits(4).bones(2).next_joint;
            ANUL_VEC = ANUL_N - ANUL_P;
            
            ANG_ANUL = 2*ang_ProdPun(VEC_NORMAL,ANUL_VEC)-80;            %UTIL
            if (ANG_ANUL > 100)
                ANG_ANUL = 100;
            elseif (ANG_ANUL < 0)
                ANG_ANUL = 0;
            end
            ANG_ANUL= 100-ANG_ANUL;
            
            
            %%MENIQUE
            MENI_P = f.hands.digits(5).bones(2).prev_joint;
            MENI_N = f.hands.digits(5).bones(2).next_joint;
            MENI_VEC = MENI_N - MENI_P;
            
            ANG_MENI= 2*ang_ProdPun(VEC_NORMAL,MENI_VEC)-80;            %UTIL
            if (ANG_MENI > 100)
                ANG_MENI = 100;
            elseif (ANG_MENI < 0)
                ANG_MENI = 0;
            end
            ANG_MENI= 100-ANG_MENI;
            
            %%PULGAR METACARPIAL
            PULG_META_P = f.hands.digits(1).bones(2).prev_joint;
            PULG_META_N = f.hands.digits(1).bones(2).next_joint;
            PULG_META_VEC = PULG_META_N - PULG_META_P;
            
            ANG_PULG_META= 2*ang_ProdPun(VEC_NORMAL,PULG_META_VEC)-80;  %UTIL 
            if (ANG_PULG_META > 100)
                ANG_PULG_META = 100;
            elseif (ANG_PULG_META < 0)
                ANG_PULG_META = 0;
            end
            ANG_PULG_META= 100-ANG_PULG_META;
            
            
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
            
            
            %ENVIO DE DATOS
            MATRIZ_DATA = [255, ANTE, MUNE_DES, MUNE_EXT, PULG, PULG_META, INDI, MEDI, ANUL, MENI];
            fprintf(OpenCM,MATRIZ_DATA);
            fprintf('ENVIADO\n')
            % FIN ENVIO DATOS
             
            
         else
             fprintf('IZQUIERDA\n')
         end

    elseif (NUM_MANOS == 2)
        fprintf('DOS MANOS\n')
    
    else
        fprintf('SIN LECTURA DE MANOS\n')
    end

end

%ENVIO DE DATOS
MATRIZ_DATA = [255, 127, 127, 127, 127, 127, 127, 127, 127, 127];
fprintf(OpenCM,MATRIZ_DATA);
fprintf('ENVIADO\n')

%SE DESCONECTA DEL OBJETO
fclose(OpenCM);
%BORRA TODOS LOS OBJETOS
delete(OpenCM);
clear OpenCM
