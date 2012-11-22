// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol1 no3 pg 25
// by Roger Coqart
// "Structured Square Series -- Inwards", drawing 28 x 28 cm.
// Other works in the series are "Horizontal Rows", "Outwards", as
// well as the "Permutation" works.
// 
// Kyle McDonald
// 2012
// Creative Commons license CC BY-SA 3.0

int side = 24;
int lines = 8;
int n = lines * 2 + 1;
int margin = side / 2;
int offset = side + margin;
int canvas = (n + 1) * offset;
boolean[] enabled = new boolean[lines];

void setup() {
  size(canvas, canvas);
  noLoop();
}

void draw() {
  background(255);
  translate(side, side);
  for (int y = 0; y < n; y++) {
    for (int x = 0; x < n; x++) {
      // enable some lines
      int total = max(abs(y - lines), abs(x - lines));
      for (int i = 0; i < lines; i++) {
        enabled[i] = i < total;
      }

      // shuffle the enabled lines
      for (int i = 0; i < lines; i++) {
        boolean swap = enabled[i];
        int j = (int) random(lines);
        enabled[i] = enabled[j];
        enabled[j] = swap;
      }

      // draw all enabled lines
      pushMatrix();
      translate(x * offset, y * offset);
      rect(0, 0, side, side);
      if (enabled[0]) line(0, side / 2, side, side / 2);
      if (enabled[1]) line(side / 2, 0, side / 2, side);
      if (enabled[2]) line(0, 0, side, side);
      if (enabled[3]) line(0, side, side, 0);
      if (enabled[4]) line(0, side / 2, side / 2, 0);
      if (enabled[5]) line(side / 2, 0, side, side / 2);
      if (enabled[6]) line(side, side / 2, side / 2, side);
      if (enabled[7]) line(side / 2, side, 0, side / 2);
      popMatrix();
    }
  }
}

