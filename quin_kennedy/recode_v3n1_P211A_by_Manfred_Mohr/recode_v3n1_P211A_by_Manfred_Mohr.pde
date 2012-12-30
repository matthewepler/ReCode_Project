// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no1 pg 7
// P-211A
// by Manfred Mohr
//
//extra inspiration from: http://www.emohr.com/mohr_cube1_211.html
// - screenshot included in repo
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0
static final int boxSize = 80;
static final int cellSize = 190;
static final int numCells = 7;
static final int gutter = 10;
static final int canvasWidth = cellSize*numCells+gutter*(numCells+1);
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
  background(255);
  
  boolean calcExtended = true;
  PVector rot = new PVector(
                      random(TWO_PI),
                      random(TWO_PI),
                      random(TWO_PI));
  PVector rotV = new PVector(
                      random(-QUARTER_PI/4, QUARTER_PI/4),
                      random(-QUARTER_PI/4, QUARTER_PI/4),
                      random(-QUARTER_PI/4, QUARTER_PI/4));
  for(int k = 0, minX = gutter, minY = gutter, maxX = gutter+cellSize, maxY = gutter+cellSize; 
      k < numCells; 
      k++, minX += gutter+cellSize, maxX += gutter+cellSize){
    if (!calcExtended){
      rot.add(rotV);
      for(int i = 0; i < edgePairs.length; i++){
        endpoints[i].x += cellSize + gutter;
      }
    }
    //draw square
    drawSquare(minX, minY, maxX, maxY, calcExtended, rot);
    calcExtended = !calcExtended;
  }
}

void drawSquare(int minX, int minY, int maxX, int maxY, boolean calcExtended, PVector rot){
  pushMatrix();
  translate((minX+maxX)/2., (minY+maxY)/2., 0);
  //calculate extended points
  rotateX(rot.x);
  rotateY(rot.y);
  rotateZ(rot.z);
  scale(boxSize);
  //background(255);
  noFill();
  stroke(0, 0, 0, 50);
  strokeWeight(2);
  box(1);
  PVector[] points = getVertices();
  popMatrix();
  stroke(0);
  strokeWeight(2);
  for(int i = 0; i < edgePairs.length; i += 2){
    if (calcExtended){
      calcExtendEdge(i, i+1, points, minX, minY, maxX, maxY);
    }
    extendEdge(i, i+1, points);
  }
  stroke(200);
  strokeWeight(1);
  rect(minX, minY, cellSize, cellSize);
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
