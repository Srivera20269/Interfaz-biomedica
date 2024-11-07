%% Prueba de reconocimiento de señales libreria vieja
%Inicialización de Bitalino, además de empezar la recolección de señales
Bit = Bitalino('btspp://201806130189');
startBackground(Bit);
%% Creación de variables vacías
F_pb = filtro_pasa_banda(1000,50,250);    %Diseñar filtro pasa banda
F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda

data = [];
buffer = zeros(1,2000);
buffer1 = zeros(1,2000); %Creación de buffers, de ventana móvil
EMG_raw = [];
EMG = [];
EMG_ventana = [];
EMGp = [];
data_f = [];
data_n = [];
pp = [];
pasado = 1;
presente = 1;
l = 1;
menor = 0;
mayor = 0;

Valor_bueno = [];
MAV = 0;
t = 1;

a = true;
%%
for i = 1:100
    % Lee los datos de un dispositivo Bitalino
    data = read(Bit);   
    pause(0.500);  % Pausa de 500 ms entre lecturas
    
    % Selecciona la columna 6 de datos (supuestamente señal EMG sin procesar)
    EMG_raw = data(:,6);
    
    % Escala los valores de EMG de acuerdo con un factor de conversión (3.3V y resolución de 1024)
    EMG = EMG_raw * (3.3 / 1024);

    % Aplica un filtro pasa bandas (F_pb) para eliminar frecuencias no deseadas
    data_f = filter(F_pb, EMG');  
    % Aplica un filtro de muesca (notch) para eliminar una frecuencia específica (por ejemplo, 60 Hz)
    data_n = filter(F_notch, data_f);
    
    % Crea un vector de tiempo para el tamaño de los datos filtrados
    x = linspace(0, size(data_n,2), size(data_n,2));
    
    % Si el tamaño de los datos filtrados está entre 500 y 600 muestras
    if size(data_n,2) >= 500 && size(data_n,2) <= 600
        % Toma una ventana de los datos filtrados, omitiendo los primeros 60 puntos
        EMGp = data_n(1, 60:end);
        
        % Calcula la longitud de los datos actuales sumando los datos anteriores
        presente = size(EMGp,2);
        l = presente + pasado;

        % Si la longitud total excede el tamaño del buffer
        if l > length(buffer)
            % Reinicia el índice del buffer
            l = 1;
            t = 1;
            % Llena el buffer desde el inicio con los datos actuales
            buffer(1, 1:size(EMGp,2)) = EMGp;
            % Calcula el valor absoluto medio de EMGp
            MAV = jMeanAbsoluteDeviation(EMGp);
        else
            % Llena el buffer desde el último punto "pasado" hasta "l - 1"
            buffer(1, pasado:l-1) = EMGp;
            % Calcula nuevamente el MAV
            MAV = jMeanAbsoluteDeviation(EMGp);

            % Si el MAV es mayor que 0.05 (umbral para detectar actividad)
            if MAV > 0.05
                % Asegura que la ventana de datos no exceda el tamaño del buffer
                if pasado - 300 < 0
                    menor = pasado - 300;
                    menor = 2000 - menor;
                    EMG_ventana = [buffer(1, menor:2000), buffer(1, 1:size(EMGp,2) + 300)];
                elseif l + 300 > 2000
                    mayor = l + 300;
                    mayor = mayor - 2000;
                    EMG_ventana = [buffer(1, (size(EMGp,2) + 300):2000), buffer(1, 1:mayor)];
                else
                    EMG_ventana = buffer(1, pasado - 300: l + 300);
                end
            end
        end
        
        % Grafica el buffer completo en la Figura 1, con límites de -3.3 a 3.3 V
        figure(1);
        plot(buffer);
        ylim([-3.3, 3.3]);
    end

    % Grafica la ventana de datos en la Figura 2, con límites de -3.3 a 3.3 V
    figure(2);
    plot(EMG_ventana);
    ylim([-3.3, 3.3]);

    % Actualiza el valor de "pasado" para la siguiente iteración
    pasado = l;
end
