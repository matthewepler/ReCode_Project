int OFFSETX = 150;
int OFFSETY = 150;
int INTERVAL = 200;
int CUBESIZE = 100;
int SCREENWIDTH = 900;
int SCREENHEIGHT = 300;

void draw_cube(int slength, boolean[] permutation) {
  int side = slength/2;
  int start_point = -side;
  if (permutation[0])
    line(start_point, start_point, start_point, start_point, start_point, side);
  if (permutation[1])
    line(start_point, start_point, start_point, start_point, side, start_point);
  if (permutation[2])
    line(start_point, start_point, start_point, side, start_point, start_point);
  if (permutation[3])
    line(start_point, start_point, side, start_point, side, side);
  if (permutation[4])
    line(start_point, start_point, side, side, start_point, side);
  if (permutation[5])
    line(start_point, side, start_point, side, side, start_point);
  if (permutation[6])
    line(start_point, side, start_point, start_point, side, side);
  if (permutation[7])
    line(side, start_point, start_point, side, side, start_point);
  if (permutation[8])
    line(side, start_point, start_point, side, start_point, side);
  if (permutation[9])  
    line(side, side, start_point, side, side, side);
  if (permutation[10])
    line(side, start_point, side, side, side, side);
  if (permutation[11])
    line(start_point, side, side, side, side, side);
}

void setup() {
  size(SCREENWIDTH, SCREENHEIGHT, P3D);
  background(255);
  noLoop();
  ortho();
  strokeWeight(2);
}

void draw() {
  boolean[] permutation = {true, true, false, true, true, true, true, false, true, true, true, false};
  int[] missingSides = {11, 7, 2, 2};
  translate(OFFSETX, OFFSETY);
  pushMatrix();
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    rotateX(PI * -4/3 + PI * 1/54);
    rotateY(PI * -4/3 + PI * 1/54);
    rotateZ(PI * -4/3 + PI * 1/54);
    draw_cube(CUBESIZE, permutation);
    popMatrix();
    translate(INTERVAL, 0);
    permutation[missingSides[i]] = true;
  }
  popMatrix();

  stroke(0, 0, 0, 80);
  boolean[] permutation2 = {true, false, true, true, false, false, true, true, true, true, true, true};
  int[] missingSides2 = {4, 1, 5, 5};
  pushMatrix();
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    rotateX(PI/6 + PI/72);
    rotateY(-PI/9 - PI/72);
    rotateZ(PI/18);
    draw_cube(CUBESIZE, permutation2);
    popMatrix();
    translate(INTERVAL, 0);
    permutation2[missingSides2[i]] = true;
  }
  popMatrix();
}
