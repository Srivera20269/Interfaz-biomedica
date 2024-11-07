#include <ArduinoBLE.h>
#include <MyoWare.h>
#include <vector>

// debug parameters
const bool debugLogging = false; // set to true for verbose logging to serial

std::vector<BLEDevice> vecMyoWareShields;
int valorRecibido;
int valMapeado;
int sensor;
int Modo;


// MyoWare class object
MyoWare myoware;

void setup()
{
  Serial.begin(115200);
  while (!Serial);

  pinMode(myoware.getStatusLEDPin(), OUTPUT); // initialize the built-in LED pin to indicate 
                                              // when a central is connected

  // begin initialization
  if (!BLE.begin())
  {
    Serial.println("Starting BLE failed!");

    while (1);
  }

  BLE.scanForUuid("180A", true);

  // scan for Wireless Shields for 10sec
  const long startMillis = millis();
  while (millis() - startMillis < 10000) 
  {
    myoware.blinkStatusLED();

    BLEDevice peripheral = BLE.available();
    if (peripheral && std::find(vecMyoWareShields.begin(), vecMyoWareShields.end(), peripheral) == vecMyoWareShields.end())
    {
      if (debugLogging)
      {
        Serial.print("Connecting to ");
        PrintPeripheralInfo(peripheral);
      }

      // connect to the peripheral
      BLE.stopScan();
      if (peripheral.connect())
      {
        if (!peripheral.discoverAttributes())
        {
          Serial.println("Discovering Attributes... Failed!");
          Serial.print("Disconnecting... ");
          PrintPeripheralInfo(peripheral);
          peripheral.disconnect();
          continue;
        }
        vecMyoWareShields.push_back(peripheral);
      }
      else
      {
        Serial.print("Failed to connect: ");        
        PrintPeripheralInfo(peripheral);
      }
      BLE.scanForUuid("180A", true);
    }
  }
  BLE.stopScan();

  if (vecMyoWareShields.empty())
  {
    Serial.println("No MyoWare Wireless Shields found!");
    while (1);
  }  
    
  digitalWrite(myoware.getStatusLEDPin(), HIGH); // turn on the LED to indicate a connection

  for (auto shield : vecMyoWareShields)
  {
    auto ritr = vecMyoWareShields.rbegin();
    if (ritr != vecMyoWareShields.rend() && shield != (*ritr))
    {
      Serial.print(shield.localName());
      Serial.print("\t");
    }
    else
    {
      Serial.println(shield.localName());
    }
  }
}

void loop()
{  
  for (auto shield : vecMyoWareShields)
  {
    if (!shield)
    {
      Serial.print("Invalid MyoWare Wireless Shields pointer! MAC Address: ");
      Serial.println(shield);
      auto itr = std::find(vecMyoWareShields.begin(), vecMyoWareShields.end(), shield);
      if (itr != vecMyoWareShields.end())
        vecMyoWareShields.erase(itr);
      continue;
    }

    if (debugLogging)
    {
      Serial.print("Updating ");
      PrintPeripheralInfo(shield);
    }

    if (!shield.connected())
    {
      Serial.print("0.0"); 
      Serial.print("\t"); 
      continue;
    }

    BLEService myoWareService = shield.service("180A");
    if (!myoWareService)
    {
      Serial.println("Failed finding MyoWare BLE Service!");
      shield.disconnect();
      continue;
    }
    
    // get sensor data
    BLECharacteristic sensorCharacteristic = myoWareService.characteristic("2A58");

    // Reading the array from BLE and printing it
    int myArray[2];  // assuming the array has 2 integers
    ReadBLEArray(sensorCharacteristic, myArray, 2);  // Read array of size 2
  

    sensor = myArray[0];
    valMapeado = map(sensor, 0, 550, 190, 127);
    myArray[0] = valMapeado;
    
    for (int i = 0; i < 2; i++) {
      Serial.print(myArray[i]);
      if (i < 1) Serial.print(", ");
    }
  }
  Serial.println("");
}

// Read the array data from the BLE characteristic
void ReadBLEArray(BLECharacteristic& dataCharacteristic, int* array, int size)
{
  if (dataCharacteristic)
  {
    if (dataCharacteristic.canRead())
    {
      uint8_t byteArray[20];  // Max BLE packet size is 20 bytes
      int length = dataCharacteristic.readValue(byteArray, sizeof(byteArray));

      if (length >= 2 * size)  // Each integer is 2 bytes
      {
        for (int i = 0; i < size; i++)
        {
          // Reconstruct each integer from two bytes (big-endian)
          array[i] = (int16_t)((byteArray[2 * i] << 8) | byteArray[2 * i + 1]);
        }
      }
    }
    else
    {
      if (debugLogging)
      {
        Serial.print("Unable to read characteristic: ");
        Serial.println(dataCharacteristic.uuid());
      }
    }
  }
  else
  {
    if (debugLogging)
      Serial.println("Characteristic not found!");
  }
}

void PrintPeripheralInfo(BLEDevice peripheral)
{
  Serial.print(peripheral.address());
  Serial.print(" '");
  Serial.print(peripheral.localName());
  Serial.print("' ");
  Serial.println(peripheral.advertisedServiceUuid());
}

