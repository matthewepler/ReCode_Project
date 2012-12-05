// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no2 pg 17
// Untitled 3 (from "Hieroglyphs Series")
// by Aaron Marcus
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0
static final int numLines = 21;
static final int numShapes = 7;
static final int lineHalfHeight = 16;
static final int borderPixelSize = 15;
static final int canvasSize = numLines*2*lineHalfHeight+borderPixelSize*2;
static final float aspectRatio = 670/700.;//taken from reproduction in PDF

void setup(){
  //the combination of P2D, 1.5 stroke, and no smoothing creates an attractive raw look
  size(floor(canvasSize*aspectRatio), canvasSize, P2D);
  noLoop();
}

void draw(){
  //smooth(8);
  background(0);
  stroke(255);
  noFill();
  strokeWeight(1.5);
  strokeJoin(SQUARE);
  strokeCap(SQUARE);
  pushMatrix();
  translate(borderPixelSize, borderPixelSize + lineHalfHeight);
  for(int i = 0; i < numLines; i++){
    drawLine();
    translate(0, lineHalfHeight*2);
  }
  popMatrix();
}

void drawLine(){
  pushMatrix();
  int pixelsRemaining = width-borderPixelSize*2;
  int pixelsPrevious = 0;
  line(0, 0, pixelsRemaining, 0);
  while(pixelsRemaining > 0){
    boolean rightSideUpFirst = random(1) < .5;
    int shapeIndex = floor(random(numShapes));
    //small items are more common, quick hack
    if(shapeIndex >= 2 && random(1) < .5){
      shapeIndex = floor(random(2));
    }
    //large arcs are less common, quick hack
    if (shapeIndex == 6 && random(1) < .5){
      shapeIndex = floor(random(numShapes-1));
    }
    int pixelsUsed = drawShape(shapeIndex, pixelsRemaining, pixelsPrevious, rightSideUpFirst);
    if (shapeIndex < 3){
      shapeIndex = floor(random(3));
      pixelsUsed = max(pixelsUsed, drawShape(shapeIndex, pixelsRemaining, pixelsPrevious, !rightSideUpFirst));
    }
    translate(pixelsUsed, 0);
    pixelsRemaining -= pixelsUsed;
    pixelsPrevious += pixelsUsed;
  }
  translate(pixelsRemaining, 0);
  drawShape(0, defaultStep, pixelsPrevious, true);
  popMatrix();
}

static final int defaultStep = floor(lineHalfHeight/3);
static final float longDiagWidth = tan(radians(30))*lineHalfHeight;
static final float shortDiagWidth = tan(radians(30))*(lineHalfHeight/2);


int drawShape(int i, int pixelsRemaining, int pixelsPrevious, boolean rightSideUp){
  pushMatrix();
  int toReturn = defaultStep;
  if (!rightSideUp){
    switch(i){
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        rotate(PI);
        break;
    }
  }
  boolean forward = random(1) < .5;
  switch(i){
    case 0://short vertical
      line(0, -lineHalfHeight/2., 0, 0);
      break;
    case 1://short diagonal
      if ((forward ? pixelsRemaining : pixelsPrevious) < ceil(shortDiagWidth)){
        toReturn = 0;
        break;
      }
      line(random(1) < .5 ? -shortDiagWidth : shortDiagWidth, -lineHalfHeight/2., 0, 0);
      break;
    case 2://blank
      break;
    case 3://long diagonal
      if (pixelsRemaining < ceil(longDiagWidth) || pixelsPrevious < ceil(longDiagWidth)){
        toReturn = 0;
        break;
      }
      line(forward ? longDiagWidth : -longDiagWidth, -lineHalfHeight, 
           forward ? -longDiagWidth : longDiagWidth, lineHalfHeight);
      break;
    case 4://long vertical
      line(0, -lineHalfHeight, 0, lineHalfHeight);
      break;
    case 5://small circle
      ellipse(0, -lineHalfHeight/2., lineHalfHeight/4., lineHalfHeight/4.);
      break;
    case 6://large arc
      if (pixelsRemaining < lineHalfHeight*2){
        toReturn = 0;
        break;
      }
      arc(lineHalfHeight, 0, lineHalfHeight*2, lineHalfHeight*2, 
          rightSideUp ? PI : 0, 
          rightSideUp ? TWO_PI : PI);
      toReturn = lineHalfHeight*2+defaultStep;
      break;
  }
  popMatrix();
  return toReturn;
}
