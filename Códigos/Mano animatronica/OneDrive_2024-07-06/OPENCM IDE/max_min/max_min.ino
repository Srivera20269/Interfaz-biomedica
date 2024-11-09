
/* Serial device defines for dxl bus */
#define DXL_BUS_SERIAL1 1  //Dynamixel on Serial1(USART1)  <-OpenCM9.04


#define ID_NUM 1

Dynamixel Dxl(DXL_BUS_SERIAL1);

void setup() {
  // Dynamixel 2.0 Protocol -> 0: 9600, 1: 57600, 2: 115200, 3: 1Mbps 
  Dxl.begin(3);
  
  Dxl.setPacketType(DXL_PACKET_TYPE1);
  Dxl.cwAngleLimit(ID_NUM, 375);   //CW Angle Limit -> minimum 300
  Dxl.ccwAngleLimit(ID_NUM, 648);  //CCW Angle Limit -> minimum 700   

}

void loop() {

  Dxl.setPacketType(DXL_PACKET_TYPE1);

  
//  Dxl.writeWord(ID_NUM, 8, 639);
//  Dxl.writeWord(ID_NUM, 24, 1);
  
  Dxl.goalPosition(ID_NUM, 512);
  delay(3000);
  Dxl.goalPosition(ID_NUM, 900);
  delay(3000);
  Dxl.goalPosition(ID_NUM, 200);
  delay(3000);
  

}
