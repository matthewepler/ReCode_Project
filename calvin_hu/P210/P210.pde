int screenHeight = 960;
int screenWidth = 960;
int offset = 30;
int interval = 300;
int cubeSide = 100;

void draw_cube(int slength, boolean[] permutation, int strokeCube, int strokeOutline) {
  int side = slength/2;
  int start_point = -side;
  int dHeight = 2;
  int dWidth = 125;
  if (permutation[0]) {
    strokeWeight(strokeOutline);
    line(start_point, start_point + dHeight, start_point - dWidth, start_point, start_point + dHeight, side + dWidth);
    line(start_point, start_point - dHeight, start_point - dWidth, start_point, start_point - dHeight, side + dWidth);

    line(side, start_point + dHeight, start_point - dWidth, side, start_point + dHeight, side + dWidth);
    line(side, start_point - dHeight, start_point - dWidth, side, start_point - dHeight, side + dWidth);

    line(side, side + dHeight, start_point - dWidth, side, side + dHeight, side + dWidth);
    line(side, side - dHeight, start_point - dWidth, side, side - dHeight, side + dWidth);

    line(start_point, side + dHeight, start_point - dWidth, start_point, side + dHeight, side + dWidth);
    line(start_point, side - dHeight, start_point - dWidth, start_point, side - dHeight, side + dWidth);

    strokeWeight(strokeCube);
    line(side, side, start_point, side, side, side);
    line(side, start_point, start_point, side, start_point, side);
    line(start_point, start_point, start_point, start_point, start_point, side);
    line(start_point, side, start_point, start_point, side, side);
  }
  if (permutation[1]) {
    strokeWeight(strokeOutline);
    line(start_point + dHeight, start_point - dWidth, start_point, start_point + dHeight, side + dWidth, start_point);
    line(start_point - dHeight, start_point - dWidth, start_point, start_point - dHeight, side + dWidth, start_point);

    line(start_point + dHeight, start_point - dWidth, side, start_point + dHeight, side + dWidth, side);
    line(start_point - dHeight, start_point - dWidth, side, start_point - dHeight, side + dWidth, side);

    line(side + dHeight, start_point - dWidth, start_point, side + dHeight, side + dWidth, start_point);
    line(side - dHeight, start_point - dWidth, start_point, side - dHeight, side + dWidth, start_point);

    line(side + dHeight, start_point - dWidth, side, side + dHeight, side + dWidth, side);
    line(side - dHeight, start_point - dWidth, side, side - dHeight, side + dWidth, side);
    strokeWeight(strokeCube);
    line(start_point, start_point, start_point, start_point, side, start_point);
    line(start_point, start_point, side, start_point, side, side);
    line(side, start_point, start_point, side, side, start_point);
    line(side, start_point, side, side, side, side);
  }
  if (permutation[2]) {
    strokeWeight(strokeOutline);
    line(start_point - dWidth, start_point + dHeight, start_point, side + dWidth, start_point + dHeight, start_point);
    line(start_point - dWidth, start_point - dHeight, start_point, side + dWidth, start_point - dHeight, start_point);

    line(start_point - dWidth, start_point + dHeight, side, side + dWidth, start_point + dHeight, side);
    line(start_point - dWidth, start_point - dHeight, side, side + dWidth, start_point - dHeight, side);

    line(start_point - dWidth, side + dHeight, start_point, side + dWidth, side + dHeight, start_point);
    line(start_point - dWidth, side - dHeight, start_point, side + dWidth, side - dHeight, start_point);

    line(start_point - dWidth, side + dHeight, side, side + dWidth, side + dHeight, side);
    line(start_point - dWidth, side - dHeight, side, side + dWidth, side - dHeight, side);
    strokeWeight(strokeCube);
    line(start_point, start_point, start_point, side, start_point, start_point);
    line(start_point, start_point, side, side, start_point, side);
    line(start_point, side, start_point, side, side, start_point);
    line(start_point, side, side, side, side, side);
  }
}

void setup() {
  size(screenWidth, screenHeight, P3D);
  background(255);
  //fill(255);
  rectMode(CORNERS);
  ortho();
  noLoop();
}

void draw() {
  pushMatrix();
  translate(offset-interval/2, offset-interval/2);

  boolean[] sides;
  for (int i = 0; i < 3; i++) {
    translate(interval, 0);
    pushMatrix();
    for (int j = 1; j <= 3; j++) {
      boolean[] refreshSides = {
        false, false, false
      };
      sides = refreshSides;
      translate(0, interval);
      if (j != 1) {
        for (int k = 1; k < j + 1; k++) {
          sides[(i + k) % 3] = true;
        }
      }
      else {
        sides[i] = true;
      }
      pushMatrix();
      rotateX(PI * 3/16);
      rotateY(PI * 3/10);
      rotateZ(PI/12);
      draw_cube(cubeSide, sides, 3, 1);
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
  
  hint(DISABLE_DEPTH_TEST);
  noStroke();
  fill(255);
  for (int i = 0; i < 4; i++) {
    rect(0, i * interval, screenWidth, i * interval + offset*2);
    rect(i * interval, 0, i * interval + offset * 2, screenHeight);
  }

  strokeWeight(1);
  stroke(0);
  for (int i = 1; i <= 2; i++) {
    line(offset, offset + i*interval, screenWidth - offset, offset + i*interval);
    line(offset + i*interval, offset, offset + i*interval, screenHeight - offset);
  }
  save("P210 A Part 1.png");
}

