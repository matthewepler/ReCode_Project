// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol1 no3 pg 25
// by Roger Coqart
// 
// Nick Santaniello
// 2012
// Creative Commons license CC BY-SA 3.0

int margin = 8;
int boxSize = 30;
int cols = 15;
int rows = 15;
int frameCounter = 0;
int targetCol = 1;
int targetRow = 1;
int moveRate = 10;
int dir = 1;

ArrayList<Integer> theLines;

void setup() {
  size(564, 564);
  background(255);
  stroke(0);
  strokeWeight(2);

  theLines = new ArrayList<Integer>();
  for (int i =0; i < 8; i++) {
    theLines.add(i);
  }

  drawAgain();
}

void drawAgain() {

  //for every row...
  for (int r =0; r < rows; r++) {
    //for every column...
    for (int c =0; c < cols; c++) {
      int x = boxSize*c + margin*c;
      int y = boxSize*r + margin*r;

      pushMatrix();
      translate(x, y);
      rect(0, 0, boxSize, boxSize);

      int targetDistance = max(abs(r - targetRow), abs(c-targetCol));

      // Default to max segments if box is far away
      if (targetDistance > 7) {
        targetDistance = 7;
      };

      // randomize possible lines
      Collections.shuffle(theLines);
      for (int i = 0; i < targetDistance; i++) {
        drawLine( theLines.get(i), boxSize, boxSize);
      }

      popMatrix();
    }
  }
}
void draw() {

  frameCounter++;

  if (frameCounter > moveRate) {
    switch (dir) {
    case 1:
      targetCol++;
      if (targetCol >= cols-3) {
        dir++;
      }
      break;
    case 2:
      targetRow++;
      if (targetRow >= rows-3) {
        dir++;
      }
      break;
    case 3:
      targetCol--;
      if (targetCol <= 2) {
        dir++;
        //saveFrame("structured_square.jpg");
      }
      break;
    case 4:
      targetRow--;
      if (targetRow <= 3) {
        dir = 1;
      }
      break;
    }
    drawAgain();
    frameCounter = 0;
  }
}


void drawLine(int whichLine, int w, int h) {
  switch(whichLine) {
  case 0:
    line(w, 0, 0, h);
    break;
  case 1:
    line(0, 0, w, h);
    break;
  case 2:
    line(0, h/2, w, h/2);
    break;
  case 3:
    line(0, h/2, w/2, 0);
    break;
  case 4:
    line(w/2, h, 0, h/2);
    break;
  case 5:
    line(w/2, 0, w/2, h);
    break;
  case 6:
    line(w/2, 0, w, h/2);
    break;
  case 7:
    line(w, h/2, w/2, h);
    break;
  }
}

