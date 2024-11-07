#include <ArduinoBLE.h>
#include <MyoWare.h>
#include <Wire.h>

MyoWare::OutputType outputType = MyoWare::ENVELOPE;

MyoWare myoware;

const int MPU = 0x68; // Dirección I2C del MPU6050
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;
float Ax, Ay, Az, Gx_x, Gy_y, Gz_z,Gx, Gy, Gz, GyroXOff, GyroYOff, GyroZOff;
float Ax_hat, Ay_hat, Az_hat;
float probemos, output;
int16_t sensorValue, valMapeado;

#define I2C_SDA 33
#define I2C_SCL 32

float mapRange(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}


BLEService arrayService("180A");  // Create a BLE service
BLECharacteristic arrayCharacteristic("2A58", BLERead | BLENotify, 20);  // Create a characteristic to send data (up to 20 bytes)

int16_t myArray[] = {0,0};  // The array to send
int arraySize = sizeof(myArray) / sizeof(myArray[0]);  // Calculate the size of the array

void setup() {
  Wire.begin(I2C_SDA, I2C_SCL);
  Serial.begin(115200);

  // Inicia la MPU6050
  Wire.beginTransmission(MPU);
  Wire.write(0x6B); // Registro de energía
  Wire.write(0);    // Despierta el MPU6050
  Wire.endTransmission(true);

  myoware.setConvertOutput(false);    // Set to true to convert ADC output to the amplitude of
                                      // of the muscle activity as it appears at the electrodes
                                      // in millivolts
  myoware.setGainPotentiometer(50.);  // Gain potentiometer resistance in kOhms.
                                      // adjust the potentiometer setting such that the
                                      // max muscle reading is below 3.3V then update this
                                      // parameter to the measured value of the potentiometer
  myoware.setENVPin(A3); 
  myoware.setRAWPin(A4);              // Arduino pin connected to RAW (defult is A4 for Wireless Shield)
  myoware.setREFPin(A5);              // Arduino pin connected to REF (defult is A5 for Wireless Shield)
  

  

  pinMode(myoware.getStatusLEDPin(), OUTPUT);  // initialize the built-in LED pin to indicate 
                                               // when a central is connected
  digitalWrite(myoware.getStatusLEDPin(), HIGH);
  
  // Initialize the BLE module
  if (!BLE.begin()) {
    Serial.println("Starting BLE failed!");
    while (1);
  }

  // Set up the BLE device
  BLE.setLocalName("Arduino Array Sender");  // Set the BLE device name
  BLE.setAdvertisedService(arrayService);    // Advertise the service

  // Add the characteristic to the service
  arrayService.addCharacteristic(arrayCharacteristic);
  
  // Add the service to the BLE device
  BLE.addService(arrayService);
  
  // Start advertising
  BLE.advertise();

  Serial.println("BLE device active, waiting for connections...");

  digitalWrite(myoware.getStatusLEDPin(), LOW);
}

void loop() {
  BLEDevice central = BLE.central();  // Wait for a central device to connect

  if (central) {
    Serial.print("Connected to central: ");
    Serial.println(central.address());
    digitalWrite(myoware.getStatusLEDPin(), HIGH);

    while (central.connected()) {
      // Prepare the array data to be sent in bytes
      uint8_t byteArray[20];  // Max BLE packet size is 20 bytes
      int byteArrayLength = 0;

      const double sensorValue = myoware.readSensorOutput(MyoWare::ENVELOPE);
      valMapeado = map(sensorValue, 0, 550, 190, 127);
  
      Wire.beginTransmission(MPU);
      Wire.write(0x3B); // Comienza a leer desde el registro 0x3B (acelerómetro)
      Wire.endTransmission(false);
      Wire.requestFrom(MPU, 14, true); // Solicita los siguientes 14 registros

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

      //Ay_hat = (2*Ay) - (1 - 1);
      //Ay_hat = Ay_hat/ (1 + 1);

      //Az_hat = (2*Az) - (1 -1.04);
      //Az_hat = Az_hat/ (1 + 1.04);

      // Leer giroscopio
      GyX = Wire.read() << 8 | Wire.read(); // Eje X
      GyY = Wire.read() << 8 | Wire.read(); // Eje Y
      GyZ = Wire.read() << 8 | Wire.read(); // Eje Z

      if (Ax_hat < 0) {
        // Mapear de -1 a 0 en el rango de -43 a 0
        output = mapRange(Ax_hat, -1.0, 0.0, -43,0);
      } else {
        // Mapear de 0 a 1 en el rango de 0 a 63
        output = mapRange(Ax_hat, 0.0, 1.0, 0, 63);
      }

      myArray[0] = sensorValue;
      myArray[1] = output;
      
      for (int i = 0; i < arraySize; i++) {
        // Convert each integer element to bytes and add to the byte array
        byteArray[byteArrayLength++] = (myArray[i] >> 8) & 0xFF;  // High byte
        byteArray[byteArrayLength++] = myArray[i] & 0xFF;         // Low byte
      }

      // Send the byte array over BLE
      arrayCharacteristic.writeValue(byteArray, byteArrayLength);

      Serial.println("Array sent over BLE!");
      delay(250);  // Wait before sending again
    }

    Serial.print("Disconnected from central: ");
    Serial.println(central.address());
  }
}

