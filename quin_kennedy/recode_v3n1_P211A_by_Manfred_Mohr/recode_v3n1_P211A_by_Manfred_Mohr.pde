// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no1 pg 7
// P-211A
// by Manfred Mohr
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0
static final int boxSize = 100;
static final int cellSize = 200;
static final int gutter = 10;
static final int canvasWidth = cellSize*3+gutter*4;
static final int canvasHeight = cellSize+gutter*2;
int[] edgePairs = {0, 1,
                     2, 3,
                     1, 3,
                     0, 2,
                     
                     4, 5,
                     6, 7,
                     5, 7,
                     4, 6,
                     
                     0, 4,
                     1, 5,
                     2, 6,
                     3, 7};
PVector[] endpoints = new PVector[edgePairs.length];

void setup(){
  size(canvasWidth, canvasHeight, P3D);
  noLoop();
}

void draw(){
  smooth(2);
  ortho(0, width, 0, height, Float.MIN_VALUE, Float.MAX_VALUE);
  strokeJoin(ROUND);
  pushMatrix();
  translate(gutter+cellSize/2., height/2, 0);
  float rX = random(TWO_PI);
  float rY = random(TWO_PI);
  float rZ = random(TWO_PI);
  //calculate extended points
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);
  scale(boxSize);
  
  PVector[] points = getVertices();
  background(255);
  noFill();
  stroke(0, 0, 0, 50);
  strokeWeight(2);
  box(1);
  popMatrix();
  stroke(0);
  strokeWeight(2);
                 
  //draw the first one 
  for(int i = 0; i < edgePairs.length; i += 2){
    calcExtendEdge(i, i+1, points, gutter, gutter, cellSize+gutter, height-gutter);
    extendEdge(i, i+1, points);
  }
  stroke(200);
  rect(gutter, gutter, cellSize, cellSize);
  
  //draw the second one
  pushMatrix();
  translate(width/2, height/2, 0);
  rX += random(-QUARTER_PI/2, QUARTER_PI/2);
  rY += random(-QUARTER_PI/2, QUARTER_PI/2);
  rZ += random(-QUARTER_PI/2, QUARTER_PI/2);
  //calculate extended points
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);
  scale(boxSize);
  //background(255);
  noFill();
  stroke(0, 0, 0, 50);
  strokeWeight(2);
  box(1);
  points = getVertices();
  popMatrix();
  stroke(0);
  strokeWeight(2);
  for(int i = 0; i < edgePairs.length; i++){
    endpoints[i].x += (width-gutter*4)/3. + gutter;
  }
  for(int i = 0; i < edgePairs.length; i += 2){
    //calcExtendEdge(edgePairs[i], edgePairs[i+1], points);
    extendEdge(i, i+1, points);
  }
  stroke(200);
  rect(gutter*2+cellSize, gutter, cellSize, cellSize);
  
  //draw the last one
  pushMatrix();
  translate(gutter*3+cellSize*2+cellSize/2., height/2, 0);
  //calculate extended points
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);
  scale(boxSize);
  //background(255);
  noFill();
  stroke(0, 0, 0, 50);
  strokeWeight(2);
  box(1);
  points = getVertices();
  popMatrix();
  stroke(0);
  strokeWeight(2);
  for(int i = 0; i < edgePairs.length; i += 2){
    calcExtendEdge(i, i+1, points, gutter*3+cellSize*2, gutter, width-gutter, height-gutter);
    extendEdge(i, i+1, points);
  }
  stroke(200);
  rect(gutter*3+cellSize*2, gutter, cellSize, cellSize);
}

PVector[] getVertices(){
  PVector[] points = new PVector[8];
  int c = 0;
  for(float i = -.5; i <=.5; i+= 1){
    for(float j = -.5; j <= .5; j+=1){
      for(float k = -.5; k <= .5; k+=1, c++){
        points[c] = new PVector(modelX(i,j,k), modelY(i,j,k), modelZ(i,j,k));
      }
    }
  }
  return points;
}

void calcExtendEdge(int i1, int i2, PVector[] points, float minX, float minY, float maxX, float maxY){
  PVector p1 = points[edgePairs[i1]];
  PVector p2 = points[edgePairs[i2]];
  PVector pV = PVector.sub(p2, p1);
  float nX = (minX-p1.x)/pV.x;//p1.x+n*pV.x = 0
  float nY = (minY-p1.y)/pV.y;
  float nX2 = (maxX - p1.x)/pV.x;
  float nY2 = (maxY -p1.y)/pV.y;
  float n = Integer.MAX_VALUE;
  float n2 = Integer.MIN_VALUE;
  float[] all = {nX, nY, nX2, nY2};
  for(int j = 0; j < all.length; j++){
    if (all[j] > 0 && all[j] < n){
      n = all[j];
    } else if (all[j] < 0 && all[j] > n2){
      n2 = all[j];
    }
  }
  PVector pF = PVector.add(p1, PVector.mult(pV, n));
  PVector pF2 = PVector.add(p1, PVector.mult(pV, n2));
  endpoints[i1] = pF2;
  endpoints[i2] = pF;
  /*
  println(i1+","+i2);
  println(p1.x+","+p1.y+","+p1.z);
  println(p2.x+","+p2.y+","+p2.z);
  println(" -> "+pV.x+","+pV.y+","+pV.z);
  println(" - "+nX);
  println(" - " + nY);
  println(" - " + nX2);
  println(" - " + nY2);
  println(" :: " + n);
  println(" --> " + pF.x+","+pF.y+","+pF.z);*/
}

void extendEdge(int i1, int i2, PVector[] points){
  PVector p1 = points[edgePairs[i1]];
  PVector p2 = points[edgePairs[i2]];
  PVector pF = endpoints[i2];
  PVector pF2 = endpoints[i1];
  line(p2.x, p2.y, p2.z, pF.x, pF.y, pF.z);
  line(p1.x, p1.y, p2.z, pF2.x, pF2.y, pF2.z);
  /*
  println(i1+","+i2);
  println(p1.x+","+p1.y+","+p1.z);
  println(p2.x+","+p2.y+","+p2.z);
  println(" --> " + pF.x+","+pF.y+","+pF.z);
  println(" --> " + pF2.x+","+pF2.y+","+pF2.z);*/
}
