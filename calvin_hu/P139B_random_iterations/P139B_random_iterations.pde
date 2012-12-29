int OFFSETX = 150;
int OFFSETY = 150;
int INTERVAL = 200;
int CUBESIZE = 100;
int SCREENWIDTH = 900;
int SCREENHEIGHT = 300;

int[] missingSides = {11, 7, 2, 2};
int[] missingSides2 = {4, 1, 5, 5};
boolean[] permutation = {true, true, false, true, true, true, true, false, true, true, true, false};  
boolean[] permutation2 = {true, false, true, true, false, false, true, true, true, true, true, true};

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
  frameRate(30);
  draw();
}

void draw(){
  missingSides[0] = (int)random(12);
  while(missingSides[1] == missingSides[0]){
    missingSides[1] = (int)random(12); 
  }
  while(missingSides[2] == missingSides[0]
    || missingSides[2] == missingSides[1]){
     missingSides[2] = (int)random(12); 
  }
  missingSides2[0] = (int)random(12);
  while(missingSides2[1] == missingSides2[0]){
    missingSides2[1] = (int)random(12); 
  }
  while(missingSides2[2] == missingSides2[0]
    || missingSides2[2] == missingSides2[1]){
     missingSides2[2] = (int)random(12); 
  }
  for(int i = 0; i < 3; i++){
   permutation[missingSides[i]] = false;
   permutation2[missingSides2[i]] = false; 
  }
  
  background(255);
  translate(OFFSETX, OFFSETY);
  stroke(0);
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

void mousePressed(){
 loop();
}

void mouseReleased(){
 noLoop(); 
}

