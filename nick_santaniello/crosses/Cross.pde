class Cross {

  int baseW = 40;
  int baseH = 120;
  int sizeDifference = 8;
  int x;
  int y;
  int offset = 2;

  Cross(int xVal, int yVal) {
    x = xVal;
    y = yVal;
  };

  void display() {
    
    //I draw each cross as two intersecting rectangles.
    //By drawing two rectangles and a small white square in the middle, I can leverage rectMode(CENTER) as opposed to maintaining 12 seperate line segments per cross. This is my justification for this hack.
   
    rect(x, y, baseW, baseH);
    rect(x, y, baseH, baseW);
    //draw the white box
    stroke(255);
    rect(x, y, baseW, baseW);
    stroke(0);
    
    //draw 4 crosses inside each cross.
    for (int i = 1; i<=4; i++) {
      int w = baseW - i*sizeDifference;
      int h = baseH - i*sizeDifference;
      rect(x, y+offset*i, w, h);
      rect(x, y+offset*i, h, w);
      stroke(255);
      rect(x, y+offset*i, w, w);
      stroke(0);
    }
  }
}

