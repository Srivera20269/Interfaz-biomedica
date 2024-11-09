
#define DXL_BUS_SERIAL1 1  //Dynamixel on Serial1(USART1)  <-OpenCM9.04

#define NEW_ID 2

Dynamixel Dxl(DXL_BUS_SERIAL1); 

void setup() {
  // Initialize the dynamixel bus:
  // Dynamixel 2.0 Baudrate -> 0: 9600, 1: 57600, 2: 115200, 3: 1Mbps  
  Dxl.begin(3);  


  Dxl.setID(BROADCAST_ID, NEW_ID);  //Dynamixel_Id_Change 1 to 2
  Dxl.jointMode(1); //jointMode() is to use position mode  
}

void loop() {
   int pos;
    // Wait for 20 milliseconds
 
     pos = Dxl.readWord(XL_320_ID_NUM2, 4); // Read present position
     SerialUSB.print("Que: ");
     SerialUSB.println(pos);
  delay(1000);              
}

