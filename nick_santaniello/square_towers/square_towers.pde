// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol1 no4 pg 28
// Untitled 1 (Computer graphics at the University of Munich - West Germany)
// by Various (Reiner Schneeberger and unnamed students)
// 
// Nick Santaniello
// 2012
// Creative Commons license CC BY-SA 3.0

int cols = 11;
int rows = 10;
float offsetX;
float offsetY;
int sqSize= 100;
int sizeDifference = 17;

void setup() {
  size(1000, 1000);
  offsetX = random(-6, 6);
  offsetY = random(-6, 6);
  rectMode(CENTER);
  strokeWeight(2);
  fill(240);

  //for every row...
  for (int r = 0; r<rows; r++) {
    //for every column...
    for (int c = 0; c<cols; c++) {
      //choose a new offset
      offsetX = random(-7, 7);
      offsetY = random(-7, 7);
      rect(c*sqSize, r*sqSize, sqSize, sqSize);
      for (int i=1; i<6; i++) {
        rect((c*sqSize)+(i*offsetX), (r*sqSize)+(i*offsetY), sqSize - (i*sizeDifference), sqSize - (i*sizeDifference));
      }
    }
  }
}

void draw() {
}

