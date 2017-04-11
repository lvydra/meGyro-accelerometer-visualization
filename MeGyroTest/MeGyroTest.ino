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
  Serial.print(gyro.getAccZ());
  Serial.print(",");
  Serial.println(magnitude(gyro.getAccX(), gyro.getAccY(), gyro.getAccZ()));

  Serial.setTimeout(50);
  delay(40);
}

long magnitude (int x, int y, int z){
  long magnitude = 0;
  magnitude = sqrt(sq(x) + sq(y) + sq(z)); 
  
  return magnitude;
}

