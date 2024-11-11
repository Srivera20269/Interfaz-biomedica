# Carpeta de Códigos
En esta carpeta se encuentran todos los códigos principales realizados durante el trabajo. Se encuentran divididos en base a que software o que microcontrolador se utilizó con ese código.

## Aplicaciones
En esta carpeta se encuentran, las dos aplicaciones realizadas junto con sus dependencias para que las mismas funcionen completamente. 

Dentro de la carpeta "Control de Actuadores" se encuentra la aplicación principal siendo el archivo "Interfaz_Control_Actuadores.mlapp" el archivo que se debe de ejecutar.

Dentro de la carpeta "Recolección de Señales" se encuentran dos aplicaciones de recolección. Como se mencionó en la página principal el archivo "RecolecciónDeDatosEMGv3.mlapp", funciona por medio del toolbox "MATLAB Support for BITalino Biosignal Devices". Por el otro lado el archivo de "RecolecciónDeDatosEMGv2.mlapp" funciona con el toolbox "BITalino Toolbox".

## Arduino
Dentro de esta carpeta se encuentran los archivos utilizados para el control del ESP32, MPU6050 y el MyoWare.

En las carpetas "CentralFinal" y "Slave_MPUMyoware" se encuentran los códigos finales utilizados para el control del proyecto, combinando el uso del MyoWare como del MPU. Estos funcionan por medio de dos microcontroladores siendo el esclavo al cual se debe de utilizar con el código dentro de "Slave_MPUMyoWare", en el cual debe ir conectado tanto el MPU como el sensor EMG. La carpeta de "CentralFinal" contiene el código del segundo microcontrolador que esta conectado directamente con la PC.

Dentro de la carpeta MPU, se encuentra el código base utilizado para el control del MPU6050, junto con un microcontrolador ESP32.

## BITalino
Dentro de esta carpeta se encuentran todos los códigos e información recopilada para el uso del sensor BITalino.

Los archivos "PruebaRecoleccion_libreriaNueva.m" y "PruebaRecoleccion_libreriaVieja.m" son los archivos base utilizados para la creación de las interfaces finales y funcionan con su respectivo toolbox, siendo "MATLAB Support for BITalino Biosignal Devices" el toolbox de libreria nueva y "BITalino Toolbox" la librería vieja. Estas librerías se pueden encontrar dentro de la carpeta de Toolboxes.

De igual forma que el archivo "PruebaRecoleccion_libreriaVieja.m", el archivo "PruebaCalibración.m" trabaja con el mismo toolbox.

Dentro de las carpetas "Archivos 1 sensor" y "Archivos 2 sensores" se encuentran todos los archivos derivados de las interfaces obtenidas por medio del BITalino. Siendo estas archivos ".mat" y los modelos de clasificación obtenidos base al mismo archivo.

## Mano animatronica
En esta carpeta se encuentran todos los archivos base relacionados con la comunicación que se utilizó para el control de la mano animatronica por medio de MATLAB.

En la carpeta MATLAB se encuentra toda la documentación sobre la comunicación original entre MATLAB y la mano.

En la carpeta MPU6050 se encuentra la comunicación en forma de Array entre el ESP32 y MATLAB, además de la comunicación de control entre MATLAB y el microcontrolador OpenCM. Estos archivos se encuentran dentro de la carpeta de comunicación.
