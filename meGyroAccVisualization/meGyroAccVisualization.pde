import processing.serial.*;

Serial port;
String stream;
int[][] intValues;
int minValue = -32768;
int maxValue = 32767;
int scale = 200;
int gridStep = 20;
int dif;
float ratio;

void setup() {
  size(1000, 600);
  stroke(10);
  
  //String portName = Serial.list()[1];
  
  String portName = "COM5";
  port = new Serial(this, portName, 115200);
  
  intValues = new int[100][3];
  dif = maxValue - minValue;
  ratio = dif / scale;
}

void draw() {
  background(255);
  grid(scale, gridStep);
  
  if ( port.available() > 0) {
    stream = port.readStringUntil('\n');
    if (stream != null) {
      intValues = updateData(stream);
    } 
  } 
  drawData(intValues);
}

void grid(int scale, int step) {
  float[] dashes = { 5, 3};
  
  for (int i = 1; i < (3*scale)/step; i++) {
    dashline(0,step*i,width,step*i,dashes);
  }
  
  for (int i = 1; i < width/step; i++) {
    dashline(step*i,0,step*i,height,dashes);
  }
  
  strokeWeight(2);
  for (int i = 1; i < intValues[0].length; i++) {
    line(0,scale*i,width,scale*i);
  }
  strokeWeight(1);
}

int[][] updateData(String stream) {
  //println(stream);
  
  String[] values = stream.split(","); 
  //println(values);
  
  int[][] iValues = intValues;
    
  for (int i = iValues.length - 2; i >= 0; i--) {
    for (int j = 0; j < values.length; j++) {
      iValues[i+1][j] = iValues[i][j];
    }  
  }
    
  for (int k = 0; k < values.length; k++) {
    String trimedValue = trim(values[k]);
    iValues[0][k] = int(trimedValue);
  }  
  
  //for (int i = 0; i < iValues.length; i++) {
  //  println(iValues[i]);
  //}
  
  return iValues;
}

void drawData (int[][] iValues) {
  stroke(255, 0, 0);
  int step = width / intValues.length;
  
  for (int i = 0; i < iValues.length-1; i++) {
    for (int j = 0; j < iValues[0].length; j++) {
      float y1 = ((j+1)*scale)-(scale/2)+(iValues[i][j]/ratio);     
      float x1 = i*step;
      float y2 = ((j+1)*scale)-(scale/2)+(iValues[i+1][j]/ratio);
      float x2 = (i+1)*step;
      
      //println("i: " + i + " j: " + j);
      //println("x1: " + x1 + " y1: " + y1 + " x2: " + x2 + " y2: " + y2);
      
      line(x1,y1,x2,y2);
    }  
  }
  stroke(10);
}

void dashline(float x0, float y0, float x1, float y1, float[ ] spacing) { 
  float distance = dist(x0, y0, x1, y1); 
  float [ ] xSpacing = new float[spacing.length]; 
  float [ ] ySpacing = new float[spacing.length]; 
  float drawn = 0.0;
 
  if (distance > 0) { 
    int i; 
    boolean drawLine = true; 
 
    for (i = 0; i < spacing.length; i++) { 
      xSpacing[i] = lerp(0, (x1 - x0), spacing[i] / distance); 
      ySpacing[i] = lerp(0, (y1 - y0), spacing[i] / distance); 
    } 
 
    i = 0; 
    while (drawn < distance) { 
      if (drawLine) { 
        line(x0, y0, x0 + xSpacing[i], y0 + ySpacing[i]); 
      } 
      x0 += xSpacing[i]; 
      y0 += ySpacing[i]; 
      drawn = drawn + mag(xSpacing[i], ySpacing[i]); 
      i = (i + 1) % spacing.length;
      drawLine = !drawLine;
    } 
  } 
} 
