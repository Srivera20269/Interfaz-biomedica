
MUNE_EXT = 0;
MATRIZ_DATA = [255,127+MUNE_EXT,127+MUNE_EXT,127+MUNE_EXT];

 
OpenCM = serialport('COM3');
fopen(OpenCM);
fprintf(s,MATRIZ_DATA);


%SE DESCONECTA DEL OBJETO
fclose(s);
%BORRA TODOS LOS OBJETOS
delete(s);
clear s