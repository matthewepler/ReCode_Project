// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no2 pg 30
// by Roger Coqart
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0

LineData[] tileData;
//number selection inspired by version in PDF, not screenshot on website.
static final int numTiles = 13;
static final float gutterRelativeSize = .5;
static final int windowSize = 600;
//we need space for each tile, 
//space for each gutter to the left of each tile, 
//and space for the final gutter (to the right of the final tile)
static final int tileSize = floor(windowSize/(numTiles*(1+gutterRelativeSize)+gutterRelativeSize));
static final int gutterSize = floor(tileSize*gutterRelativeSize);

void setup(){
  int actualWinSize = (tileSize+gutterSize)*numTiles+gutterSize;
  size(actualWinSize, actualWinSize);
  createTiles();
  noLoop();
}

void draw(){
  background(255);
  stroke(0);
  strokeWeight(2);
  strokeJoin(ROUND);
  noFill();
  //pick a random grid cell to be the focal point
  //for now we will restrict it to have at most one row/column of empty squares
  int focusX = floor(random(numTiles-9, 9));
  int focusY = floor(random(numTiles-9, 9));
  //for each grid cell...
  for(int i = 0, gi = gutterSize; i < numTiles; i++, gi += gutterSize+tileSize){
    for(int j = 0, gj = gutterSize; j < numTiles; j++, gj += gutterSize+tileSize){
      pushMatrix();
      translate(gi,gj);
      rect(0, 0, tileSize, tileSize);
      shuffleTiles();
      int num = max((tileData.length - max(abs(focusX-i), abs(focusY-j))), 0);
      for(int k = 0; k < num; k++){
        LineData td = tileData[k];
        line(td.sx, td.sy, td.ex, td.ey);
      }
      popMatrix();
    }
  }
}

void shuffleTiles(){
  for(int i = 0; i < tileData.length-1; i++){
    int swapWith = floor(random(i, tileData.length));
    
    LineData temp = tileData[i];
    tileData[i] = tileData[swapWith];
    tileData[swapWith] = temp;
  }
}

void createTiles(){
  //the two lines of the + 
  //and the four lines of the square 
  //and the two lines of the x
  int numTileTypes = 2+4+2;
  int i = 0;
  tileData = new LineData[numTileTypes];
  //two lines of the +
  tileData[i++] = new LineData(tileSize/2, 0, tileSize/2, tileSize);
  tileData[i++] = new LineData(0, tileSize/2, tileSize, tileSize/2);
  //four lines of the square
  tileData[i++] = new LineData(tileSize/2, 0, 0, tileSize/2);
  tileData[i++] = new LineData(0, tileSize/2, tileSize/2, tileSize);
  tileData[i++] = new LineData(tileSize/2, tileSize, tileSize, tileSize/2);
  tileData[i++] = new LineData(tileSize, tileSize/2, tileSize/2, 0);
  //two lines of the x
  tileData[i++] = new LineData(0, 0, tileSize, tileSize);
  tileData[i++] = new LineData(tileSize, 0, 0, tileSize);
}

class LineData{
  public float sx,sy,ex,ey;
  public LineData(float _sx, float _sy, float _ex, float _ey){
    sx = _sx;
    sy = _sy;
    ex = _ex;
    ey = _ey;
  }
}
