%Filtro rechaza banda (60Hz) diseñado con Filter Designer de la Signal Processing Toolbox
%Requiere como parámetros la frecuencia de muestreo (Fs).

function Hd = filtro_rechaza_banda(Fs)
    %FN Returns a discrete-time filter object.
    
    % MATLAB Code
    % Generated by MATLAB(R) 9.2 and the Signal Processing Toolbox 7.4.
    % Butterworth Bandstop filter designed using FDESIGN.BANDSTOP.
    
    % All frequency values are in Hz.
    Fs = Fs;  % Sampling Frequency
    
    N   = 20;  % Order
    Fc1 = 58;  % First Cutoff Frequency
    Fc2 = 62;  % Second Cutoff Frequency
    
    % Construct an FDESIGN object and call its BUTTER method.
    h  = fdesign.bandstop('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
    Hd = design(h, 'butter');