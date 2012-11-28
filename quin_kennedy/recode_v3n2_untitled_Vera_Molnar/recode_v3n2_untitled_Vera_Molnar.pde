// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no2 pg 31
// Untitled (from the "196 Trapeziums Series")
// by Vera Molnar
// 
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0

static final int numTiles = 14;
static final float gutterRelativeSize = 0;
static final int windowSize = 400;
//we need space for each tile, 
//space for each gutter to the left of each tile, 
//and space for the final gutter (to the right of the final tile)
static final int tileSize = floor(windowSize/(numTiles*(1+gutterRelativeSize)+gutterRelativeSize));
static final int gutterSize = floor(tileSize*gutterRelativeSize);

void setup(){
  int actualWinSize = (tileSize+gutterSize)*numTiles+gutterSize;
  size(actualWinSize, actualWinSize);
  noLoop();
}

void draw(){
  background(255);
  stroke(0);
  //strokeWeight(2);
  strokeJoin(ROUND);
  noFill();
  //for each grid cell...
  for(int i = 0, gi = gutterSize; i < numTiles; i++, gi += gutterSize+tileSize){
    for(int j = 0, gj = gutterSize; j < numTiles; j++, gj += gutterSize+tileSize){
      drawTrapezium(random(tileSize, width-tileSize-tileSize), random(tileSize/2., height-tileSize));
    }
  }
}

void drawTrapezium(float xCenter, float yCenter){
  float topScale = random(-2, 2);
  float bottomScale = random(-2, 2);
  float halfTile = tileSize/2.;
  quad(xCenter - tileSize/2 + random(-tileSize, tileSize), yCenter - halfTile,
        xCenter + tileSize/2 + random(-tileSize, tileSize), yCenter - halfTile,
        xCenter + tileSize/2 + random(-tileSize, tileSize), yCenter + halfTile,
        xCenter - tileSize/2 + random(-tileSize, tileSize), yCenter + halfTile);
}
