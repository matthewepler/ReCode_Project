// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no2 pg 16
// by Aaron Marcus
// "Untitled photoprint", 15" x 19"
// Other works in the Hieroglyphs series are "Noise Barrier", and various "Untitled" works.
// 
// Genevieve Hoffman
// 2012
// Creative Commons license CC BY-SA 3.0

void setup() {
  size(800,800);
  background(0);
  
  int gridSize = width/10;
  
  for (int x = gridSize; x <= width; x += gridSize) {
    for (int y = gridSize; y <= height; y += gridSize) {
      
      //make grid
      stroke(255);
      smooth();
      line(x, 0, x, height);
      line(x-gridSize, y, width, y);
      
      //generate random seed values for location and size
      float randLoc = random(-gridSize/2,gridSize/2);
      float randLoc2 = random(-gridSize/2,gridSize/2);
      float randLoc3 = random(-gridSize/2,gridSize/2);
      float randLoc4 = random(-gridSize/2,gridSize/2);
      float randLoc5 = random(-gridSize/2,gridSize/2);
      float randLoc6 = random(-gridSize/2,gridSize/2);
      float randLoc7 = random(-gridSize/2,gridSize/2);
      float randLoc8 = random(-gridSize/2,gridSize/2);
      float circSize = random(0, gridSize-10);
      float sqSize = random(0, (gridSize-10)/2);
      
      //draw circles
      noFill();
      ellipse(x+randLoc, y+ randLoc2, circSize, circSize);
      
      //draw squares
      pushMatrix();
      translate(x+randLoc3, y+randLoc4);
      rotate(random(TWO_PI));
      rect(0, 0, sqSize, sqSize);
      popMatrix();
      
      //draw lines
      pushMatrix();
      translate(x+randLoc5, y+randLoc6);
      rotate(random(TWO_PI));
      line(0,0,randLoc7, randLoc8);
      popMatrix();
    }
  }
}

void draw() {
  
}

void keyPressed() {
  //saveFrame("Aaron_Marcus_Untitled2_###.jpg");
}
