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

## Metodología
### Prótesis seleccionada
En el año 2021 se empezó el proyecto de la optimización del diseño y control de una mano animatrónica antropomórfica, dentro de la Universidad del Valle de Guatemala. Donde por el uso de motores "Dynamixel" tanto AX-12A como XL-320 logró recrear los movimientos establecidos y suaves aprovechando los motores al máximo. 
Dentro de la programación utilizada Gálvez utilizo tanto MATLAB como el microcontrolador OpemCM9.04 C para el control de los diferentes actuadores utilizados. Además de utilizar un sensor de captura "LeapMotion" para la obtención de los diferentes movimientos deseados a utilizar en la prótesis.

![Mano](https://github.com/user-attachments/assets/e4e6558b-1341-4d50-8599-637e55e8a00e)

### Equipo Utilizado
Para completar el trabajo, se hizo uso de diferentes softwares y sensores, estos son los siguientes.
#### Myoware 2.0
MyoWare 2.0 es un sensor creado por la empresa Advancer Technologies, con el objetivo de captar y visualizar señales electromiográficas por medio del uso de tres electrodos. El sensor tiene una variedad de accesorios para la mejora en la captación de señales, el sensor está diseñado para ser trabajado con un microcontrolador Arduino con la capacidad no solo de captar las señales, sino que amplificarlas y rectificarlas para facilitar el análisis y uso de las señales.

![Myoware](https://github.com/user-attachments/assets/a8c441d7-6fb7-4c7d-b3c1-f3d2a361ace3)


#### BITalino
PLUX Biosignals es una empresa cuyo objetivo es obtener soluciones para el trato y estudio de bioseñales. Cumpliendo con su objetivo, PLUX Biosignals ha desarrollado diferentes herramientas y servicios con el objetivo de apoyar a desarrollo de tecnologías basadas en el uso de bioseñales. Dentro de las herramientas y kits desarrollados podemos encontrar el BITalino siendo una plataforma de bioseñales open source diseñado para captar y analizar señales bioeléctricas.

BITalino es compatible con el software OpenSignals y tiene bloques de hardware con sensores capaces de captar señales electrocardiográficas, electromiográficas, electroencefalográficas, actividad electrodermica, entre otros.

![BITalino](https://github.com/user-attachments/assets/deb640e6-5581-47e4-8ecd-b721391b610b)

#### ESP32
El ESP32 es un microcontrolador de bajo costo y alta eficiencia desarrollado por Espressif Systems, ampliamente utilizado en proyectos de electrónica y automatización. Integra conectividad Wi-Fi y Bluetooth, lo que lo convierte en una excelente opción para aplicaciones de Internet de las Cosas (IoT). Su diseño incluye un procesador dual o de un solo núcleo, una amplia cantidad de pines GPIO (de entrada/salida), y soporte para diversos protocolos de comunicación, como UART, SPI e I2C. Además, es compatible con entornos de desarrollo populares como Arduino IDE y MicroPython, facilitando la programación y el desarrollo de proyectos conectados e inteligentes.

![esp32](https://github.com/user-attachments/assets/2bfcecf9-89e8-4ad4-acaa-d64f8aa06ad3)

#### MPU6050
El MPU6050 es un sensor inercial de bajo costo que combina un acelerómetro de tres ejes y un giroscopio de tres ejes en un solo chip. Esto le permite medir tanto la aceleración como la velocidad angular en los tres ejes espaciales (X, Y, Z), lo que lo hace ideal para aplicaciones en las que se requiere monitorear movimientos y orientaciones, como en robótica, drones, y sistemas de estabilización. Este sensor utiliza el protocolo de comunicación I2C para conectarse a microcontroladores y envía datos precisos a alta velocidad. Además, incluye un procesador de movimiento digital (DMP), que puede procesar y filtrar datos de movimiento en tiempo real, facilitando su uso en proyectos de control de movimiento y navegación.

![MPU6050](https://github.com/user-attachments/assets/ed20d60b-d075-493f-8601-ef81bffc7073)

### Clasificadores Utilizados
#### SVM
#### ANN
#### KNN

## Carpetas de Trabajo
### Codigos
En esta carpeta estarán todos los códigos utilizados dentro del trabajo. Se encuentran divididos entre los diferentes sensores utilizados y el software en el que se programarón. Además se encuentran las interfaces creadas, dentro de la aplicación de App Designer de MATLAB.
### Documentos
En esta carpeta se encontrarán todos los manuales de usuario. Además de los trabajos escritos desarrollados durante el trabajo.

