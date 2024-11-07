%% Prueba de reconocimiento de señales libreria nueva
Bit = bitalino('201806130189');  %Conexión con BITalino
%%
F_pb = filtro_pasa_banda(1000,20,450);    %Diseñar filtro pasa banda
F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda

%Inicialización de variables
data = [];
EMG_raw = [];
EMG = [];
EMG_ventana = [];
EMGp = [];
data_f = [];
data_n = [];

Valor_bueno = [];
MAV = 0;
t = 0;

a = true;
%% Recolección

for i = 1:10
    %Captura de datos BITalino
    data = read(Bit,"NumSamples",1000);
    pause(1)
    EMG_raw = data.A1; %Selección de canal de señales EMG 
    EMG = EMG_raw*(3.3/1024); %Conversión a voltaje

    data_f = filter(F_pb, EMG');                          %Aplicar filtro pasa bandas
    data_n = filter(F_notch, data_f); %Aplicar filtro
    x = linspace(0, size(data_n,2),size(data_n,2));
    MAV = jMeanAbsoluteDeviation(data_n);

    % Graficar señal obtenida
    figure(1);
    plot(data_n);
    ylim([-3.3,3.3])
    t = 0;
end
