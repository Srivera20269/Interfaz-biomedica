# Diseño e implementación de una interfaz biomédica y sensores inerciales para el control de actuadores en tiempo real.
La tecnología juega un papel esencial en la medicina moderna, brindando apoyo tanto al personal médico como a personas con discapacidades o enfermedades. Un campo destacado es el desarrollo de prótesis controladas mediante señales bioeléctricas, como las señales EMG y EEG, que permiten movimientos más precisos y naturales. Este enfoque ha permitido mejorar la comprensión del cuerpo humano y el funcionamiento de sus señales eléctricas, lo cual es clave en el diseño de prótesis avanzadas.

En la Universidad del Valle de Guatemala, se han llevado a cabo diversas fases de investigación para desarrollar e implementar interfaces biomédicas, con el objetivo de lograr una clasificación y control específico de sistemas robóticos. Una de las limitaciones en estas fases anteriores fue la falta de control en tiempo real.

Este repositorio presenta los avances logrados en esta línea de investigación. Incluye el método de recolección y análisis de señales bioeléctricas para controlar actuadores en tiempo real mediante el uso de aprendizaje automático. También se implementan clasificadores y sensores inerciales adicionales, destacando el uso de un sensor MPU6050.

## Objetivos del trabajo
### Objetivo General
* Mejorar las interfaces biomédicas para control de sistemas robóticos desarrollada en fases previas, incorporar sensores fuerza e inerciales, implementar un sistema de control en tiempo real y adaptar las interfaces para el control de actuadores.
### Objetivos específicos
* Mejorar las interfaces biomédicas desarrolladas anteriormente, integrando un módulo de detección, muestreo y procesamiento en tiempo real de señales EMG.
* Evaluar sensores de fuerza e inerciales y adaptarlos para su uso dentro de las interfaces.
* Aplicar algoritmos de extracción de características y aprendizaje automático a señales EMG, para el control de actuadores.
* Implementar el control de actuadores por medio de señales EMG y sensores de fuerza y dirección.
* Validar las interfaces desarrolladas reconociendo movimientos comunes y controlando prótesis de miembro superior desarrolladas anteriormente en la UVG.

## Carpetas de Trabajo
### Codigos
En esta carpeta estarán todos los códigos utilizados dentro del trabajo. Se encuentran divididos entre los diferentes sensores utilizados y el software en el que se programarón. Además se encuentran las interfaces creadas, dentro de la aplicación de App Designer de MATLAB.
### Documentos
En esta carpeta se encontrarán todos los manuales de usuario. Además de los trabajos escritos desarrollados durante el trabajo.


## Metodología
### Prótesis seleccionada
En el año 2021 se empezó el proyecto de la optimización del diseño y control de una mano animatrónica antropomórfica, dentro de la Universidad del Valle de Guatemala. Donde por el uso de motores "Dynamixel" tanto AX-12A como XL-320 logró recrear los movimientos establecidos y suaves aprovechando los motores al máximo. 
Dentro de la programación utilizada Gálvez utilizo tanto MATLAB como el microcontrolador OpemCM9.04 C para el control de los diferentes actuadores utilizados. Además de utilizar un sensor de captura "LeapMotion" para la obtención de los diferentes movimientos deseados a utilizar en la prótesis.
<div align="center">
    <img src="https://github.com/user-attachments/assets/e4e6558b-1341-4d50-8599-637e55e8a00e" alt="Mano" width="300"/>
</div>

Para el uso de la misma podemos encontrar los códigos de control del microcontrolador mencionado, dentro de la carpeta de códigos. Estos se encuentran bajo la sección de Mano Animatronica, junto con el código de prueba dentro de MATLAB.

### Equipo Utilizado
Para completar el trabajo, se hizo uso de diferentes softwares y sensores, estos son los siguientes.
#### Myoware 2.0
MyoWare 2.0 es un sensor creado por la empresa Advancer Technologies, con el objetivo de captar y visualizar señales electromiográficas por medio del uso de tres electrodos. El sensor tiene una variedad de accesorios para la mejora en la captación de señales, el sensor está diseñado para ser trabajado con un microcontrolador Arduino con la capacidad no solo de captar las señales, sino que amplificarlas y rectificarlas para facilitar el análisis y uso de las señales.
<div align="center">
<img src="https://github.com/user-attachments/assets/a8c441d7-6fb7-4c7d-b3c1-f3d2a361ace3" alt="Myoware" width="300"/>
</div>

Los códigos para el uso de la misma se encuentran dentro de la carpeta de códigos, bajo el apartado de Arduino. Estos códigos hacen uso de la librería de MyoWare realizada por sus creadores para su uso con dispositivos que usen la arquitectura de Arduino IDE para su programación.

#### BITalino
PLUX Biosignals es una empresa cuyo objetivo es obtener soluciones para el trato y estudio de bioseñales. Cumpliendo con su objetivo, PLUX Biosignals ha desarrollado diferentes herramientas y servicios con el objetivo de apoyar a desarrollo de tecnologías basadas en el uso de bioseñales. Dentro de las herramientas y kits desarrollados podemos encontrar el BITalino siendo una plataforma de bioseñales open source diseñado para captar y analizar señales bioeléctricas.

BITalino es compatible con el software OpenSignals y tiene bloques de hardware con sensores capaces de captar señales electrocardiográficas, electromiográficas, electroencefalográficas, actividad electrodermica, entre otros.

<div align="center">
<img src="https://github.com/user-attachments/assets/deb640e6-5581-47e4-8ecd-b721391b610b" alt="BITalino" width="300"/>
</div>

#### ESP32
El ESP32 es un microcontrolador de bajo costo y alta eficiencia desarrollado por Espressif Systems, ampliamente utilizado en proyectos de electrónica y automatización. Integra conectividad Wi-Fi y Bluetooth, lo que lo convierte en una excelente opción para aplicaciones de Internet de las Cosas (IoT). Su diseño incluye un procesador dual o de un solo núcleo, una amplia cantidad de pines GPIO (de entrada/salida), y soporte para diversos protocolos de comunicación, como UART, SPI e I2C. Además, es compatible con entornos de desarrollo populares como Arduino IDE y MicroPython, facilitando la programación y el desarrollo de proyectos conectados e inteligentes.

<div align="center">
<img src="https://github.com/user-attachments/assets/2bfcecf9-89e8-4ad4-acaa-d64f8aa06ad3" alt="BITalino" width="300"/>
</div>

#### MPU6050
El MPU6050 es un sensor inercial de bajo costo que combina un acelerómetro de tres ejes y un giroscopio de tres ejes en un solo chip. Esto le permite medir tanto la aceleración como la velocidad angular en los tres ejes espaciales (X, Y, Z), lo que lo hace ideal para aplicaciones en las que se requiere monitorear movimientos y orientaciones, como en robótica, drones, y sistemas de estabilización. Este sensor utiliza el protocolo de comunicación I2C para conectarse a microcontroladores y envía datos precisos a alta velocidad. Además, incluye un procesador de movimiento digital (DMP), que puede procesar y filtrar datos de movimiento en tiempo real, facilitando su uso en proyectos de control de movimiento y navegación.

<div align="center">
<img src="https://github.com/user-attachments/assets/ed20d60b-d075-493f-8601-ef81bffc7073" alt="BITalino" width="300"/>
</div>

Su implementación fue con un dispositivo ESP32, y su respectivo código se encuentra bajo la carpeta de códigos dentro del apartado Arduino.

### Clasificadores Utilizados
Dentro del trabajo y la carpeta de códigos se encontrarán diferentes códigos para el entrenamiento y uso de diferentes modelos de clasificadores. Estos fueron obtenidos gracias a la aplicación nativa de MATLAB con el nombre de Classification Learner. Se crearón haciendo uso de las bases de datos encontradas en la carpeta de documentos, principalmente los archivos ".mat".
Para realizar el entrenamiento de los clasificadores se utilizaron las características de "Zero Crossing" y "MAV", para las señales EMG recaudadas.
#### SVM
Se utilizaron dos SVM de tipo cúbica, realizadas dentro de la aplicación especificada. El archivo con nombre "SVMv2.m" es el archivo para el uso de un sensor BITalino, mientras que el archivo "SVM2s.m" es para su uso con dos sensores BITalino.
#### ANN
Se utilizaron dos modelos ANN, al igual que los modelos especificados anteriormente se realizaron dentro de la aplicación de Classification Learner. El documento "ANNv2.m" es específica para el uso con un sensor BITalino. El archivo "ANN2s.m" se utilizó con dos sensores BITalinos.
#### KNN
Se utilizaron dos modelos de KNN, siguiendo el mismo esquema que los modelos anteriores. El archivo "KNNv2.m" es para el uso con un BITalino, mientras que el archivo "KNN2s.m" se utilizó con dos BITalinos.

## Interfaces Realizadas
### Interfaces de Recolección de señales EMG
Para realizar las dos interfaces realizadas, se hizo uso del software de App Designer incluido dentro de MATLAB. Se realizarón diferentes interfaces gracias a la existencia de un toolbox de BITalino, el cual tiene dos versiones diferentes, una versión actualizada y una versión vieja. Dentro de la carpeta de códigos en la sección de Bitalino, se encuentra una carpeta llamada "Toolboxes", en  esta se encontrarán ambas versiones. El toolbox con el nombre de "Bitalino toolbox" es la versión que se denomina como vieja, mientras que el toolbox "MATLABsupportforBITalinoBiosignalDevices" es el toolbox denominado como actualizado.

Dentro de la experimentación del trabajo se encontró que el toolbox actualizado tiene problemas para trabajar con una recolección de señales en tiempo real, por lo que se decidió utilizar la interfaz con el toolbox viejo para continuar con el proyecto. Sin embargo, se realizó una versión de la interfaz que trabaja con ese toolbox.

Las interfaces tienen la opción de calcular 7 características diferentes de las señales capturadas, estas siendo:
* Zero Crossing
* MAV
* Kurtosis
* Amplitud de Willison
* Promedio de energía
* Varianza
* Media cuadrática

<div align="center">
<img src="https://github.com/user-attachments/assets/f313182f-ca3c-4e3a-80ed-9ba16d1952ad" alt="intEMG" width="500"/>
</div>

#### Interfaz de recolección de señales EMG con MATLAB Support for BITalino Biosignal Devices Toolbox
Como se mencionó esta interfaz no trabaja en tiempo real, por lo que es necesario una captura de datos con un tiempo en específico. La recolección se hace por un tiempo determinado por el usuario y por medio de un algoritmo de captura se reconoce la señal y se despliega. Al mismo tiempo se calculan las características indicadas y se guardan en un archivo .csv para su uso fuera de la aplicación.

Esta aplicación se encuentra en la carpeta de códigos, dentro del apartado de aplicaciones. El archivo se tiene el nombre de "RecoleccionDeDatosEMGv3".

<div align="center">
<img src="https://github.com/user-attachments/assets/fddec3e8-aafa-47bd-bc0a-8c6110ab5b0d" alt="EMGv3" width="500"/>
</div>

#### Interfaz de recolección de señales EMG con BITalino Toolbox

Esta interfaz fue utilizada para el uso definitivo dentro del trabajo. Trabaja por medio de una ventana móvil de tiempo la cual cada 500 ms toma datos del BITalino, al momento que detecta una señal, esta captura la misma y la divide en tres segmentos. Al estar divida esta calcula las características indicadas y las guarda dentro de un archivo .csv. Para determinar el momento en el que existe una señal la aplicación calcula el MAV de la señal recibida y la compara con un promedio determinado, al sobrepasar el promedio indica que hay una señal presente.

Para determinar el valor del promedio, es necesario realizar una calibración de antemano. Al conectar los sensores y empezar la lectura se presiona el botón de calibrar el cual al momento de empezar realiza capturas dentro de un rango de 5 segundos, donde determina el MAV de la señal y la guarda para su comparación dentro de la recolección de las señales.

Al igual que la interfaz anterior, esta se encuentra en la misma carpeta. El archivo tiene el nombre de "RecoleccionDeDatosEMGv2" junto con todas sus dependencias utilizadas para su uso.

<div align="center">
<img src="https://github.com/user-attachments/assets/af536456-3b56-4491-8f7d-3c770b754e82" alt="EMGv2" width="500"/>
</div>

### Interfaz de control de mano animatrónica
Esta interfaz de igual forma que la interfaz de recolección de señales EMG fue realizada dentro del apartado de App Designer de MATLAB. Principalmente trabaja con todos los elementos previamente mencionados, teniendo instrucciones especificas dentro de la aplicación. Además se puede encontrar más detalles dentro del apartado de documentos, dentro del apartado de manuales de usuario.

Esta interfaz trabaja con tres apartados diferentes, uno de intrucciones, otro de entrenamiento y el último de panel de control. La interfaz posee tres modos de uso diferentes, los cuales comparten la particularidad de mover la base de la mano con razón a los movimientos del MPU6050.

Los modos son los siguientes:
* Modo Binario
  * Este trabaja con el MyoWare, haciendo uso de su lectura "Envelope", la cual funciona como un medidor de intensidad. Este controla la mano siguiendo un movimiento cercano al de hacer un puño, por el cual mientras más fuerza se haga en el músculo la mano ira haciendo un puño. 
* Modo de 1 Sensor
  * Este modo trabaja tanto con un BITalino, como con un ESP32. Este utiliza el mismo algoritmo de captura que la interfaz de recolección de señales EMG con el BITalino toolbox. Al momento de que la aplicación detecte una señal este la compara dentro del modelo de clasificación seleccionado y determina un movimiento pre-establecido dentro de la mano haciendo el movimiento en tiempo real.
* Modo de 2 Sensores
  * Este modo trabaja igual al modo de 1 sensor con la única diferencia de que agrega un sensor BITalino, utilizando dos sensores BITalino y un ESP32.
 
Para hacer uso de tanto el modo de un sensor como el de dos sensores, es necesario realizar el entrenamiento del modelo de clasificación. Bajo el apartado de entrenamiento de la aplicación se debe ingresar la recopilación unida de las señales a clasificar y se debe seleccionar entre la selección de un modelo SVM, ANN o KNN. Si no se tiene preferencia, la aplicación selecciona el modelo con mejor porcentaje de clasificación. Al igual que la interfaz de recolección, si se hace uso de los modos mencionados es necesario realizar una calibración para el promedio de las señales.

Esta interfaz al igual que las anteriores se encuentra dentro del apartado de códigos, bajo la carpeta de aplicaciones con el nombre de "Interfaz_Control_Actuadores" junto con todas sus dependencias utilizadas en el trabajo.

<div align="center">
<img src="https://github.com/user-attachments/assets/2a545576-acf1-4451-b731-b071ba842b62" alt="ICF" width="500"/>
</div>


