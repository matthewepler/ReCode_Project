static final int LINE_WIDTH = 1; 

void setup() {
  size(512,512); 
}

// Draws a single cross.
void drawCross(int left, int top, int dim, int thickness) {
  int offset_1 = dim/2 - thickness/2;
  int offset_2 = offset_1 + thickness;
  int offset_3 = dim;
  beginShape();
  vertex(left + offset_1, top);
  vertex(left + offset_2, top);
  vertex(left + offset_2, top + offset_1);
  vertex(left + offset_3, top + offset_1);
  vertex(left + offset_3, top + offset_2);
  vertex(left + offset_2, top + offset_2);
  vertex(left + offset_2, top + offset_3);
  vertex(left + offset_1, top + offset_3);
  vertex(left + offset_1, top + offset_2);
  vertex(left,            top + offset_2);
  vertex(left,            top + offset_1);
  vertex(left + offset_1, top + offset_1);
  vertex(left + offset_1, top);
  endShape(CLOSE);
}

// Draw a stack of crosses.
void drawCrossWithDecay(int left, int top, int base_dim, int num_decay,
                        PVector dpos, int ddim, double dthickness) {
  double thickness = base_dim/3;
  int dim = base_dim;
  int curleft = left;
  int curtop = top;
  for (int i = 0; i < num_decay; i++) {
    drawCross(curleft, curtop, dim, (int)thickness);
    curleft += dpos.x + ddim/2;
    curtop += dpos.y + ddim/2;
    dim -= ddim;
    thickness -= dthickness;
  }
}

void drawCrossMatrix(int dim, int left, int top, int rows, int cols) {
  int thickness = dim/3;
  PVector dp1 = new PVector(0,-1);
  PVector dp2 = new PVector(1,0);
  PVector dp;
  for (int i = 0; i < rows; i++) {
    int rleft = left + i * thickness;
    int rtop = top + i * 2 * thickness;
    for (int j = 0; j < cols; j++) {
      dp = i%2==0?dp1:dp2;
      dp.mult(-1);
      drawCrossWithDecay(rleft + thickness * 2 *j, rtop - thickness * j, dim, 5, dp, 4, 4.5);
    } 
  }
}

void draw() {
  background(0xffffff);
  drawCrossMatrix(69, 50, 150, 6, 6);
}
