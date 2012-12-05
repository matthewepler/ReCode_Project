// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no1 pg 9
// P-196A
// by Manfred Mohr
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0
static final int boxSize = 300;
static final int canvasSize = 600;

void setup(){
  size(canvasSize, canvasSize, P2D);
  noLoop();
}

void draw(){
translate(width/2, height/2, 0);
PGraphics topLight = createGraphics(width, height, P3D);
PGraphics bottomLight = createGraphics(width, height, P3D);
PGraphics topHeavy = createGraphics(width, height, P3D);
PGraphics bottomHeavy = createGraphics(width, height, P3D);
float rX = random(TWO_PI);
float rY = random(TWO_PI);
float rZ = random(TWO_PI);
drawBox(topLight, rX, rY, rZ, 1, 255);
drawBox(topHeavy, rX, rY, rZ, 4, 252);
rX = random(TWO_PI);
rY = random(TWO_PI);
rZ = random(TWO_PI);
drawBox(bottomLight, rX, rY, rZ, 1, 255);
drawBox(bottomHeavy, rX, rY, rZ, 4, 252);

copy(topLight, 0, 0, width, height/2, 0, 0, width, height/2);
copy(bottomLight, 0, height/2, width, height/2, 0, height/2, width, height/2);
int pX = (width-boxSize)/2;
int pY = (height-boxSize)/2;
int cW = boxSize;
int cH = boxSize/2;
copy(topHeavy, pX, pY, cW, cH, pX, pY, cW, cH);
pY += boxSize/2;
copy(bottomHeavy, pX, pY, cW, cH, pX, pY, cW, cH);
line(0, height/2, width, height/2);
}

void drawBox(PGraphics g, float rotX, float rotY, float rotZ, float weight, int backgroundColor){
  g.beginDraw();
  g.ortho();
  g.translate(width/2, height/2, 0);
  g.rotateX(rotX);
  g.rotateY(rotY);
  g.rotateZ(rotZ);
  g.background(backgroundColor);
  g.stroke(0);
  g.strokeWeight(weight);
  g.noFill();
  g.box(boxSize);
  g.endDraw();
}
