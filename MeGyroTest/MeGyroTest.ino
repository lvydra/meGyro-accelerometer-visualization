#include "MeShield.h"
#include <Wire.h>

MeGyro gyro;

void setup(){
  Serial.begin(115200);
  gyro.begin();
}

void loop(){
  gyro.update();
  Serial.read();

  Serial.print(gyro.getAccX());
  Serial.print(",");
  Serial.print(gyro.getAccY());
  Serial.print(",");
  Serial.println(gyro.getAccZ());

  Serial.setTimeout(50);
  delay(40);
}

int magnitude (int x, int y, int z){
  double magnitude = 0;
  magnitude = sqrt(sq(x) + sq(y) + sq(z)); 
  
  return (int) magnitude;
}

