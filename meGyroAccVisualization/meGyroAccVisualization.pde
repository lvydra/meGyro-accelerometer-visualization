import processing.serial.*;

Serial port;
String stream;
String[] values;
int[][] intValues;

void setup() {
  String portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);
  intValues = new int[10][3];
}

void draw() {
  if ( port.available() > 0) {
    updateData(port);
  } 
  
  /** TODO
  * Visualize three data sets
  */
  
}

void updateData (Serial port) {
  stream = port.readStringUntil('\n');             
  values = stream.split(","); 
    
  for (int i = 8;i>=0;i--) {
    intValues[i+1][0] = intValues[i][0];
    intValues[i+1][1] = intValues[i][1];
    intValues[i+1][2] = intValues[i][2];
  }
    
  intValues[0][0] = int(values[0]);
  intValues[0][1] = int(values[1]);
  intValues[0][2] = int(values[2]);
}