import processing.serial.*;

Serial port;
String stream;
int[][] intValues;
int minValue = 0;
int maxValue = 100;
int scale = 10;
int dif;
float ratio;

void setup() {
  String portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);
  intValues = new int[10][3];
  dif = maxValue - minValue;
  ratio = scale / dif;
}

void draw() {
  if ( port.available() > 0) {
    intValues = updateData(port);
  } 
  
  drawData(intValues);
}

int[][] updateData(Serial port) {
  stream = port.readStringUntil('\n');             
  String[] values = stream.split(","); 
  
  int[][] iValues = new int[10][values.length];
    
  for (int i = 8; i >= 0; i--) {
    for (int j = 0; j < values.length; j++) {
      iValues[i+1][j] = iValues[i][j];
    }  
  }
    
  for (int k = 0; k < values.length; k++) {
    iValues[0][k] = int(values[k]);
  }  
  
  return iValues;
}

void drawData (int[][] iValues) {
  for (int i = 0; i < iValues.length-1; i--) {
    for (int j = 0; j < iValues[i].length; j++) {
      line(j*scale+(iValues[i][j]*ratio),i*scale,j*scale+(iValues[i+1][j]*ratio),(i+1)*scale);
    }  
  }
}