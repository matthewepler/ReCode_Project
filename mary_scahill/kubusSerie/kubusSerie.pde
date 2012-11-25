// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol1 no2 pg 27, 1976
// by Klaus Basset
// "Kubus-Serie"
// 
// Mary Scahill
// 2012
// Creative Commons license CC BY-SA 3.0     


// these values refer to the overal height of each row and column of the grid
int rowHeight = 9;
int colWidth = 7;
//these arrays store the necessary translation values for each cube
int[] transX = {14,17,-17, 17, -26, 17, -17, 17};
int[] transY = {13, 0, 17, 0, -26, 0, 17, 0}; 

void setup(){
size(387, 479);
background(255);
stroke(0);
strokeWeight(1);
}

void draw() {
fill(255);

//calls upon function for drawing a rectangle of ellipses
ellipseRect(7,9,width-14,height-18);

for(int i = 0; i < 8; i++) {
translate(transX[i]*colWidth,transY[i]*rowHeight);
fill(255);
noStroke();
rect(-2,-4,91,117);//this is just here so that the cross texture will be opaque
stroke(0);
crossRect(0,0,91,117);//draws crosses(or plus signs) on top of white rectangles
parallelDashEllipse(91,0,49,126);//draws dashes within ellipses in parallelogram
parallelCrossEllipse(7,117,84,63);//draws crosses within ellipses in parallelogram
  }
}

//funstion for drawing cross
void drawCross(int xPos, int yPos, int lineLength) {
   int lineAx = xPos - int(lineLength/2);
   int lineAx2 = xPos + int(lineLength/2);   
   int lineBy = yPos - int(lineLength/2);
   int lineBy2 = yPos + int(lineLength/2);   
   line(lineAx, yPos, lineAx2, yPos);
   line(xPos, lineBy, xPos, lineBy2);
}

//function for drawing dash
void drawDash(int xPos, int yPos, int lineLength) {
   int lineAx = xPos - int(lineLength/2);
   int lineAx2 = xPos + int(lineLength/2);   
   line(lineAx, yPos, lineAx2, yPos);
}

//function for drawing a rectangle filled with crosses
void crossRect(int xPos, int yPos, int rectWidth, int rectHeight) {
  for (int i = xPos; i < xPos + rectWidth; i+=7) {
    for (int j = yPos; j < yPos + rectHeight; j+=9) {
      drawCross(i,j,4);
    }
  }
}

//function for drawing rectangle filled with dashes
void dashRect(int xPos, int yPos, int rectWidth, int rectHeight) {
  for (int i = xPos; i < xPos + rectWidth; i+=7) {
    for (int j = yPos; j < yPos + rectHeight; j+=9) {
      drawDash(i,j,4);
    }
  }
}

//function for drawing rectangle filled with ellipses
void ellipseRect(int xPos, int yPos, int rectWidth, int rectHeight) {
  fill(255);
  for (int i = xPos; i < xPos + rectWidth; i+=7) {
    for (int j = yPos; j < yPos + rectHeight; j+=9) {
      ellipse(i,j,7, 7);
    }
  }
}

//function for drawing parallelogram filled with ellipses   
void parallelEllipse(int xPos, int yPos, int paraWidth, int sideHeight) {
  fill(255);
  int h = 0;
  for(int i = 0; i < paraWidth; i+=7) { 
      for(int j = h; j < sideHeight + h; j+=9) { 
    ellipse(xPos + i, yPos + j, 7, 7);       
      }  
    h+=9;
  }
}

//function for drawing parallelogram filled with crosses
void parallelCross(int xPos, int yPos, int paraWidth, int sideHeight) {
  fill(255);
  int h = 0;
  for(int i = 0; i < paraWidth; i+=7) { 
      for(int j = h; j < sideHeight + h; j+=9) { 
   drawCross(xPos + i, yPos + j, 4);       
      }  
    h+=9;
  }
}

//function for drawing parallelogram filled with dashes
void parallelDash(int xPos, int yPos, int paraWidth, int sideHeight) {
  int h = 0;
  for(int i = 0; i < paraWidth; i+=7) { 
      for(int j = h; j < sideHeight + h; j+=9) { 
   drawDash(xPos + i, yPos + j, 4);       
      }  
    h+=9;
  }
}

//function for drawing parallelogram filled with crosses and ellipses
void parallelCrossEllipse(int xPos, int yPos, int paraWidth, int sideHeight) {
  fill(255);
  int h = 0;
  int m = 0;
      for(int i = h; i < sideHeight; i+=9) { 
          for(int j = 0; j < paraWidth ; j+=7) { 
    ellipse(xPos+h+j, yPos + i, 7, 7); 
       drawCross(xPos +h+j, yPos + i, 4);   
      }
          h+=7;  
  }

}

//function for drawing parallelogram filled with dashed and ellipses
void parallelDashEllipse(int xPos, int yPos, int paraWidth, int sideHeight) {
  fill(255);
  int h = 0;
  for(int i = 0; i < paraWidth; i+=7) { 
      for(int j = h; j < sideHeight + h; j+=9) { 
    ellipse(xPos + i, yPos + j, 7, 7);      
       drawDash(xPos + i, yPos + j, 4);    
      }  
    h+=9;
  }
}
