/* 
 * Arduino pin    |   MPU6050
 * 5V             |   Vcc
 * GND            |   GND
 * A4             |   SDA
 * A5             |   SCL
 */

#include <Wire.h>

const int MPU = 0x68; // Dirección I2C del MPU6050
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;
float Ax, Ay, Az, Gx_x, Gy_y, Gz_z,Gx, Gy, Gz;
float Ax_hat, Ay_hat, Az_hat;
float roll_a, pitch_a;

float GyroXOff = -28.8803, GyroYOff = -1.25728, GyroZOff = -0.3675;

float Ts = 0.002; // Periodo de muestreo (10ms)
float roll_g = 0, pitch_g = 0;
float omega_x, omega_y;
float last_roll = 0.0, last_pitch = 0.0;
float last_gx = 0.0, last_gy = 0.0;
unsigned long myTime;
unsigned long prev;





void setup() {
  Wire.begin();
  Serial.begin(115200);

  // Inicia la MPU6050
  Wire.beginTransmission(MPU);
  Wire.write(0x6B); // Registro de energía
  Wire.write(0);    // Despierta el MPU6050
  Wire.endTransmission(true);

  // Configurar acelerómetro en ±2g
  Wire.beginTransmission(MPU);
  Wire.write(0x1C); // Registro de acelerómetro
  Wire.write(0x00); // Establecer sensibilidad a ±2g
  Wire.endTransmission(true);


  // Configura el giroscopio para el rango de ±1000 dps
  Wire.beginTransmission(MPU);
  Wire.write(0x1B); // Registro de configuración del giroscopio
  Wire.write(0x10); // Establecer el rango a ±1000 dps (divisor 32.8)
  Wire.endTransmission(true);
}

void loop() {
  Wire.beginTransmission(MPU);
  Wire.write(0x43); // Registro inicial del giroscopio
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true); // Leer 6 bytes (X, Y, Z)

  // Leer giroscopio
  GyX = Wire.read() << 8 | Wire.read(); // Eje X
  GyY = Wire.read() << 8 | Wire.read(); // Eje Y
  GyZ = Wire.read() << 8 | Wire.read(); // Eje Z

  // Leer los valores de la MPU6050
  Wire.beginTransmission(MPU);
  Wire.write(0x3B); // Registro inicial del acelerómetro
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true); // Leer 6 bytes (X, Y, Z)
 

  // Leer acelerómetro
  AcX = Wire.read() << 8 | Wire.read(); // Eje X
  AcY = Wire.read() << 8 | Wire.read(); // Eje Y
  AcZ = Wire.read() << 8 | Wire.read(); // Eje Z

  //Acciones de acelerometro
  Ax = AcX / 16384.0;
  Ay = AcY / 16384.0;
  Az = AcZ / 16384.0;
  Ax_hat = (2*Ax) - (1.03 -0.96);
  Ax_hat = Ax_hat/ (1.03 + 0.96);

  Ay_hat = (2*Ay) - (1 - 1);
  Ay_hat = Ay_hat/ (1 + 1);

  Az_hat = (2*Az) - (1 -1.04);
  Az_hat = Az_hat/ (1 + 1.04);

  roll_a = -(180.0 / 3.141592) * atan2(Ay_hat, Az_hat);  // Roll (ϕ_a)
  pitch_a = (180.0 / 3.141592) * atan2(Ax_hat, sqrt(Ay_hat * Ay_hat + Az_hat * Az_hat));  // Pitch (θ_a)

 

  //Acciones Giroscopio
  Gx_x = GyX / 131.0;
  Gy_y = GyY / 131.0;
  Gz_z = GyZ / 131.0;

  Gx = Gx_x + 0.27299;
  Gy = Gy_y - 0.166453;
  Gz = Gz_z + 0.3675;

  myTime = millis()-prev;
    // Calcular la integración numérica para obtener roll y pitch desde las velocidades angulares
  roll_g = last_roll + (myTime/2000.0) * (Gx + last_gx);  // Integración de ω_x
  pitch_g = last_pitch + (myTime/2000.0) *(Gy + last_gy);  // Integración de ω_y

  last_roll = roll_g;
  last_pitch = pitch_g;
  last_gx = Gx;
  last_gy = Gy;

  prev = millis();

  // Enviar los datos a través de UART (Serial) para ser leídos en MATLAB, Python, o Serial Plotter
  Serial.print(-roll_a);
  Serial.print(",");
  Serial.print(-pitch_a);
  Serial.print(",");
  Serial.print(pitch_g);
  Serial.print(",");
  Serial.println(roll_g);

  
  // Espera para mantener el periodo de muestreo
}

