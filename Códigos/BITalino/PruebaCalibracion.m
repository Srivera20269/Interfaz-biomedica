%% Prueba de Calibración
%Creación de variable vacía
MAVs = []; 
for i = 1:100
    % lectura de bitalino
    data = read(Bit);
    pause(0.5);
    EMG_raw = data(:,6); %Selección de canal
    EMG = EMG_raw*(3.3/1024); %Conversión a voltaje

    data_f = filter(F_pb, EMG');                          %Aplicar filtro pasa bandas
    data_n = filter(F_notch, data_f); % aplicar filtro notch

    %Ciclo para captar el promedio del valor de la muestra obtenida
    if size(data_n,2) >= 200 && size(data_n,2) <= 300
        EMGp = data_n(1, 60:end);
        MAV = jMeanAbsoluteDeviation(EMGp);
        MAVs = [MAVs, MAV];

    end
    
    
end
app = max(MAVs);