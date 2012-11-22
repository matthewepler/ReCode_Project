// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol1 no3 pg 25
// by Roger Coqart
// "Structured Square Series -- Inwards", drawing 28 x 28 cm.
// Other works in the series are "Horizontal Rows", "Outwards", as
// well as the "Permutation" works.
// 
// Greg Borenstein
// 2012
// Creative Commons license CC BY-SA 3.0

int rowSize = 15;
int marginSize = 6;
int boxSize = 14;

ArrayList<Integer> strokes;

void setup() {
  size(350, 350);
  noFill();
  stroke(0);
  noLoop();

  strokes = new ArrayList<Integer>();
  for (int i =0; i < 8; i++) {
    strokes.add(i);
  }
}

void draw() {
  background(255);

  translate(boxSize*2, boxSize*2);

  for (int row =0; row < rowSize; row++) {
    for (int col =0; col < rowSize; col++) {
      int x = boxSize*col + marginSize*col;
      int y = boxSize*row + marginSize*row;

      pushMatrix();
      translate(x, y);
      rect(0, 0, boxSize, boxSize);

      // this is the one clever bit:
      // measure the distance of the square from the 
      // center in concentric rings to find out how many segments to draw
      int middle = 7;
      int distFromMiddle = max(abs(row - middle), abs(col-middle));

      // do the strokes in a random different order each time
      Collections.shuffle(strokes);
      for (int i = 0; i < distFromMiddle; i++) {
        drawSegment( strokes.get(i), boxSize, boxSize);
      }

      popMatrix();
    }
  }
}

void drawSegment(int i, int w, int h) {
  switch(i) {
  case 0:
    line(0, 0, w, h);
    break;

  case 1:
    line(w, 0, 0, h);
    break;

  case 2:
    line(0, h/2, w, h/2);
    break;

  case 3:
    line(0, h/2, w/2, 0);
    break;

  case 4:
    line(w/2, 0, w, h/2);
    break;

  case 5:
    line(w, h/2, w/2, h);
    break;

  case 6:
    line(w/2, 0, w/2, h);
    break;

  case 7:
    line(w/2, h, 0, h/2);
    break;
  }
}

