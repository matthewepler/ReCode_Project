// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol2 no3 pg 28
// Segrid
// by John Roy
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0

//Since there are 
//8 sets of images plus a center empty image plus a 1/2 width of black border
//this gives a canvas size of 8*2+1+.5*2 = 9*2 = 18 cells
//each cell is 20 pixels wide (see comment in drawTile(...))
static final float pixelSize = 1.5;
static final int linesPerQuadrant = 5;
//the tile size is the 
//(lines per quadrant + spaces per quadrant) * 2 quadrants per side * pixelSize
static final int tileSize = linesPerQuadrant*2*2;
static final float visualTileSize = tileSize*pixelSize;
//subtract 1 because the center is not doubled
//subtract another 1 because we only see half of the last tiles
static final int numTiles = linesPerQuadrant*4-1-1;
static final int windowSize = numTiles*tileSize;
static final float visualWinSize = numTiles*visualTileSize;

void setup(){
  size(ceil(visualWinSize), ceil(visualWinSize), P2D);
  noLoop();
}

void draw(){
  background(255);
  stroke(0);
  fill(0);
  strokeWeight(1);
  strokeCap(SQUARE);
  pushMatrix();
  scale(pixelSize);
  //translate(-tileSize/2., -tileSize/2.);
  //pick a random grid cell to be the focal point
  //for now we will restrict it to have at most one row/column of empty squares
  int focusX = numTiles/2;
  int focusY = numTiles/2;
  //for each grid cell...
  for(int i = 0, gi = 0; i <= numTiles; i++, gi += tileSize){
    for(int j = 0, gj = 0; j <= numTiles; j++, gj += tileSize){
      pushMatrix();
      translate(gi,gj);
      int num = min(max(abs(focusX-i), abs(focusY-j)), linesPerQuadrant*2);
      drawTile(num);
      popMatrix();
    }
  }
  popMatrix();
}

void drawTile(int iteration){
  //there are two versions of the tile, the first where 5 lines (with 5 spaces)
  //grow in,
  //and the second where each consecutive space gets filled in.
  if (iteration == 0){
    return;
  }
  pushMatrix();
  for(int i = 0; i < 4; i++){
    pushMatrix();
    translate(-linesPerQuadrant*2, -linesPerQuadrant*2);
    drawQuadrant(iteration);
    popMatrix();
    rotate(HALF_PI);
  }
  popMatrix();
}

void drawQuadrant(int iteration){
  if (iteration < linesPerQuadrant){
    pushMatrix();
    for(int i = 0; i < linesPerQuadrant; i++){
      line(0, .5, iteration*linesPerQuadrant*2./(linesPerQuadrant-1.), .5);
      translate(0, 2);
    }
    popMatrix();
  } else {
    drawQuadrant(linesPerQuadrant - 1);
    int lines = iteration - linesPerQuadrant;
    pushMatrix();
    translate(0, linesPerQuadrant*2-1);
    for(int i = 0; i <= lines; i++){
      line(0, .5, linesPerQuadrant*2, .5);
      translate(0, -2);
    }
    popMatrix();
  }
}
