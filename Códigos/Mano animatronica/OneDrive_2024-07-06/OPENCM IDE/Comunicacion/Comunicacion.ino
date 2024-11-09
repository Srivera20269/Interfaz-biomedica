#include<math.h>

#define XL_320_ID_NUM1 1
#define XL_320_ID_NUM2 2
#define XL_320_ID_NUM3 3

/* Control table defines */
#define P_GOAL_POSITION    30
#define P_GOAL_SPEED    32

#define DXL_BUS_SERIAL1 1  //Serial1(USART1)  <-OpenCM9.04
Dynamixel Dxl(DXL_BUS_SERIAL1);

void setup(){
  
  Dxl.begin(3);
  
  Dxl.setPacketType(DXL_PACKET_TYPE2);
  Dxl.jointMode(2);
  Dxl.writeWord( BROADCAST_ID, P_GOAL_POSITION, 0 );
  Dxl.writeWord( BROADCAST_ID, P_GOAL_SPEED, 0 );
  
  SerialUSB.attachInterrupt(usbInterrupt);
  pinMode(BOARD_LED_PIN, OUTPUT);  //toggleLED_Pin_Out
}

//USB max packet data is maximum 64byte, so nCount can not exceeds 64 bytes
void usbInterrupt(byte* buffer, byte nCount){
  
  if (buffer[0] == 255){
      if(buffer[1]-127 == -10){
         digitalWrite(BOARD_LED_PIN, HIGH); // set to as HIGH LED is turn-off
      }
      
      if(buffer[1]-127 == 10){
         digitalWrite(BOARD_LED_PIN, LOW); // set to as HIGH LED is turn-off
      }
      
      // (max_data/max_angulo)*(angulo centrado en 127 - 127)+(medio_data)
      // (1023/300)*(buffer -127)+ (512)
      // 3.41* buffer - 78.93
      int uno = 3.41*(buffer[1])+79;
      int dos = 3.41*(buffer[2])+79;
      int tres =3.41*(buffer[3])+79;
      
      word SyncPage1[9]=
      { 
        XL_320_ID_NUM1,round(uno),200,  // 3 Dynamixels are move to position 0
        XL_320_ID_NUM2,round(dos),200, // with velocity 100
        XL_320_ID_NUM3,round(tres),200}; 
        
  
        
     Dxl.syncWrite(30,2,SyncPage1,9);
     delay(1000);
      
      
  }
  
}

void loop(){

}

