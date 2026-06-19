import processing.serial.*; 
import java.awt.event.KeyEvent; 
import java.io.IOException;

Serial myPort; 
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont orcFont;

void setup() {
  size (1200, 700); // Screen resolution
  smooth();
  // CHANGE "COM3" to your actual Arduino COM port!
  myPort = new Serial(this, "COM3", 9600); 
  myPort.bufferUntil('.'); 
}

void draw() {
  fill(98, 245, 31);
  noStroke();
  fill(0, 4); 
  rect(0, 0, width, height-height*0.065); 
  
  fill(98, 245, 31); // Green color
  // Draw the radar elements
  drawRadar(); 
  drawLine(); 
  drawObject();
  drawText();
}

void serialEvent (Serial myPort) { 
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length()-1);
  
  index1 = data.indexOf(","); 
  angle= data.substring(0, index1); 
  distance= data.substring(index1+1, data.length()); 
  
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(width/2, height-height*0.074); 
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  
  // Draw the concentric arcs
  arc(0, 0, (width-width*0.0625), (width-width*0.0625), PI, TWO_PI);
  arc(0, 0, (width-width*0.27), (width-width*0.27), PI, TWO_PI);
  arc(0, 0, (width-width*0.479), (width-width*0.479), PI, TWO_PI);
  arc(0, 0, (width-width*0.687), (width-width*0.687), PI, TWO_PI);
  
  // Draw the angle lines
  for (int i = 30; i <= 150; i += 30) {
    line(0, 0, (-width/2)*cos(radians(i)), (-width/2)*sin(radians(i)));
  }
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2, height-height*0.074); 
  strokeWeight(9);
  stroke(255, 10, 10); // Red color for objects
  pixsDistance = iDistance * ((height-height*0.1666)*0.025); 
  
  // Limiting the range to 40 cm
  if(iDistance < 40){
    line(pixsDistance*cos(radians(iAngle)), -pixsDistance*sin(radians(iAngle)), (width/2)*cos(radians(iAngle)), -(width/2)*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  translate(width/2, height-height*0.074);
  strokeWeight(9);
  stroke(30, 250, 60); // Sweeping green line
  line(0, 0, (height-height*0.12)*cos(radians(iAngle)), -(height-height*0.12)*sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
  fill(0, 0, 0);
  noStroke();
  rect(0, height-height*0.064, width, height);
  fill(98, 245, 31);
  textSize(25);
  
  text("10cm", width-width*0.385, height-height*0.083);
  text("20cm", width-width*0.281, height-height*0.083);
  text("30cm", width-width*0.177, height-height*0.083);
  text("40cm", width-width*0.0729, height-height*0.083);
  
  textSize(40);
  text("Angle: " + iAngle + " °", width-width*0.48, height-height*0.027);
  text("Dist: ", width-width*0.26, height-height*0.027);
  if(iDistance < 40) {
    text("        " + iDistance + " cm", width-width*0.22, height-height*0.027);
  }
  popMatrix();
}
