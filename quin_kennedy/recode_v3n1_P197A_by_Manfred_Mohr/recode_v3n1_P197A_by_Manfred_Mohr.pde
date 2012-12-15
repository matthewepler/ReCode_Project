// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no1 pg 6
// P-197A
// by Manfred Mohr
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0
static final int idealCanvasSize = 600;
static final int numCellsWide = 8;
static final int boxSize = 300/(numCellsWide+2)/2*2;//we want it to be even
static final float gutterRatio = 1;
static final int cellWidth = ((int)(idealCanvasSize/(numCellsWide+gutterRatio*2)))/2*2;//we want an even number
static final int gutterWidth = (int)(cellWidth*gutterRatio);
static final int actualCanvasSize = cellWidth*numCellsWide+gutterWidth*2;
static final float gutterBleed = .5;

void setup(){
  size(actualCanvasSize, actualCanvasSize, P3D);
  noLoop();
}

void draw(){
  drawV1();
}

void drawV1(){
  background(255);
  PGraphics topLight = createGraphics(cellWidth, cellWidth, P3D);
  PGraphics bottomLight = createGraphics(cellWidth, cellWidth, P3D);
  PGraphics topHeavy = createGraphics(cellWidth, cellWidth, P3D);
  PGraphics bottomHeavy = createGraphics(cellWidth, cellWidth, P3D);
  
  int halfCellWidth = cellWidth/2;
  int currOffsetX = gutterWidth;
  int currOffsetY;
  for(int i = 0; i < numCellsWide; i++, currOffsetX += cellWidth){
    currOffsetY = gutterWidth;
    for(int j = 0; j < numCellsWide; j++, currOffsetY += cellWidth){
      //render the source material
      float rX = random(TWO_PI);
      float rY = random(TWO_PI);
      float rZ = random(TWO_PI);
      drawBox(topLight, rX, rY, rZ, .8, 255);
      drawBox(topHeavy, rX, rY, rZ, 2, 255);//252);
      rX = random(TWO_PI);
      rY = random(TWO_PI);
      rZ = random(TWO_PI);
      drawBox(bottomLight, rX, rY, rZ, .8, 255);
      drawBox(bottomHeavy, rX, rY, rZ, 2, 255);//252);
     
      //draw as appropriate, 
      //this would be better to do with viewports and scissor oporations, 
      //but I can't figure out how to do that in Processing
      copy(topLight, 0, 0, halfCellWidth, cellWidth, currOffsetX, currOffsetY, halfCellWidth, cellWidth);
      copy(bottomLight, halfCellWidth, 0, halfCellWidth, cellWidth, currOffsetX + halfCellWidth, currOffsetY, halfCellWidth, cellWidth);
      int pX = (cellWidth-boxSize)/2;
      int pY = (cellWidth-boxSize)/2;
      int cW = boxSize/2;
      int cH = boxSize;
      copy(topHeavy, pX, pY, cW, cH, currOffsetX+pX, currOffsetY+pY, cW, cH);
      pX += boxSize/2;
      copy(bottomHeavy, pX, pY, cW, cH, currOffsetX+pX, currOffsetY+pY, cW, cH);
    }
  }
}

void drawBox(PGraphics g, float rotX, float rotY, float rotZ, float weight, int backgroundColor){
  g.beginDraw();
  g.ortho();
  g.background(backgroundColor);
  
  //draw horizontal line
  g.stroke(0);
  g.strokeWeight(1);
  g.line(0, g.height/2, -boxSize*3, g.width, g.height/2, -boxSize*3);
  
  //cover the horizontal line
  g.pushMatrix();
  g.translate(g.width/2, g.height/2, -boxSize*2);
  g.rotateX(rotX);
  g.rotateY(rotY);
  g.rotateZ(rotZ);
  g.noStroke();
  g.fill(backgroundColor);
  g.box(boxSize);
  g.popMatrix();
  
  //now draw the cube outline
  g.pushMatrix();
  g.translate(g.width/2, g.height/2, 0);
  g.rotateX(rotX);
  g.rotateY(rotY);
  g.rotateZ(rotZ);
  g.stroke(0);
  g.strokeWeight(weight);
  g.noFill();
  g.box(boxSize);
  g.popMatrix();
  
  //draw vertical line
  g.strokeWeight(1);
  g.line(g.width/2, 0, boxSize, g.width/2, g.height, boxSize);
  g.endDraw();
}

void drawGrid(boolean bHorizontal){
  int currOffset = gutterWidth+cellWidth/2;
  int visualGutter = gutterWidth-((int)(gutterWidth*gutterBleed));
  for(int i = 0; i < numCellsWide; i++, currOffset += cellWidth){
    if (bHorizontal){
      line(visualGutter, currOffset, -boxSize*3, width-visualGutter, currOffset, -boxSize*3);
    } else {
      line(currOffset, visualGutter, boxSize, currOffset, height-visualGutter, boxSize);
    }
  }
}
