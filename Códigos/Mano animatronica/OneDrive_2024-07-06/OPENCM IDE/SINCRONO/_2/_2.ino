

#define P_GOAL_POSITION    30
#define P_GOAL_SPEED    32
#define DXL_BUS_SERIAL1 1  //Serial1(USART1)  <-OpenCM9.04


#define ID_NUM 1
#define XL_320_ID_NUM1 1
#define XL_320_ID_NUM2 2
#define XL_320_ID_NUM3 3

Dynamixel Dxl(DXL_BUS_SERIAL1);



void setup() {
  // Dynamixel 2.0 Protocol -> 0: 9600, 
  //1: 57600, 2: 115200, 3: 1Mbps 
  Dxl.begin(3);
  
  Dxl.setPacketType(DXL_PACKET_TYPE2);
  Dxl.jointMode(2);
  
  Dxl.writeWord( BROADCAST_ID, P_GOAL_POSITION, 0 );
  Dxl.writeWord( BROADCAST_ID, P_GOAL_SPEED, 0 );
}

void loop() {
  // put your main code here, to run repeatedly: 
//  Dxl.setPacketType(DXL_PACKET_TYPE1);
//  Dxl.goalPosition(ID_NUM, 1);
//  delay(1000);
//  Dxl.goalPosition(ID_NUM, 1023);
//  delay(1000);

  word SyncPage1[9]=
  { 
    XL_320_ID_NUM1,0,200,  // 3 Dynamixels are move to position 0
    XL_320_ID_NUM2,0,200, // with velocity 100
    XL_320_ID_NUM3,0,200}; 
    
  word SyncPage2[9]=
  { 
    XL_320_ID_NUM1,512,200, // 3 Dynamixels are move to position 512
    XL_320_ID_NUM2,512,200, // with velocity 500
    XL_320_ID_NUM3,512,200};
    
     Dxl.syncWrite(30,2,SyncPage1,9);
     delay(2000);
     Dxl.syncWrite(30,2,SyncPage2,9);
     delay(2000);
        
  
//  Dxl.setPacketType(DXL_PACKET_TYPE2);
//  Dxl.goalPosition(XL_320_ID_NUM1, 1);
//  Dxl.goalPosition(XL_320_ID_NUM2, 1);
//  Dxl.goalPosition(XL_320_ID_NUM3, 1);
//  delay(2000);
//  Dxl.goalPosition(XL_320_ID_NUM1, 1023);
//  Dxl.goalPosition(XL_320_ID_NUM2, 1023);
//  Dxl.goalPosition(XL_320_ID_NUM3, 1023);
//  delay(2000);
}



