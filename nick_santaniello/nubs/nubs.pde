/*
Part of the ReCode Project 
http://recodeproject.com
Untitled 1 (Computer graphics at the University of Munich - West Germany)
by Various (Reiner Schneeberger and unnamed students)

See also Vol. 2 No. 3 (image 10, pages 14-15) for more, including code. Input to computer on punch cards

Nick Santaniello
2012
*/

int cols = 11;
int rows = 10;
int frmRate =60;
int updateCounter =0 ;
int sqSize= 100;
int sizeDifference = 17;
Nub[] nubs;

void setup() {
  size(1000, 950);

  rectMode(CENTER);
  strokeWeight(2);
  fill(240);
  nubs = new Nub[110];
  for (int i=0; i<110; i++) {
    Nub newNub = new Nub();
    nubs[i] = newNub;
  }

  //for every row...
  for (int r = 0; r<rows; r++) {
    //for every column...
    for (int c = 0; c<cols; c++) {
      // set the beginning position of each Nub.
      nubs[r*c].update();
    }
  }
}

void draw() {
  for (int r = 0; r<rows; r++) {
    //for every column...
    for (int c = 0; c<cols; c++) {
      //move each Nub to their target offset.
      int currentNub = 10*r + 1*c;
      int row = r;
      int col = c;

      // Ugh, what a hack. Must go back and fix this later.
      if (r == 0) {
        row = 5;
      }
      if (c == 0) {
        col = 3;
      }

      nubs[row*col].run(r, c);
    }
  }

  //increase the frame count 
  updateCounter ++;

  //every X frames, update the Nubs' target offsets.
  if (updateCounter > frmRate) {
    update();
    //reset the update counter
    updateCounter = 0;
  }
}

void update() {
  //saveFrame("nubs.jpg");
  for (int i=0; i<110; i++) {
    nubs[i].update();
  }
}

class Nub {

  int cols = 11;
  int rows = 10;
  float offsetX;
  float offsetY;
  float targetX;
  float targetY;
  int sqSize = 100;
  int sizeDifference = 17;

  Nub() {
     
    //define a starting offset for the Nub.
    offsetX = random(-7, 7);
    offsetY  = random(-7, 7); 
};

  void run(int r, int c) {
    
    //A very primitive check. If the Nub has not reached its target, move it towards its target by 0.1 pixels per frame.
    if (offsetX != targetX) {
      if (offsetX < targetX) {
        offsetX = offsetX + 0.1;
      }
      if (offsetX > targetX) {
        offsetX = offsetX - 0.1;
      }
    }
    if (offsetY != targetY) {
      if (offsetY < targetY) {
        offsetY = offsetY + 0.1;
      }
      if (offsetY > targetY) {
        offsetY = offsetY - 0.1;
      }
    }
    
    //Draw the rectangle and 5 interior rectangles with the appropriate offset.
    rect(c*sqSize, r*sqSize, sqSize, sqSize);
    for (int i=1; i<6; i++) {
      rect((c*sqSize)+(i*offsetX), (r*sqSize)+(i*offsetY), sqSize - (i*sizeDifference), sqSize - (i*sizeDifference));
    }
  }
  void update() {
    //choose a new target offset for the Nub.
    targetX = random(-7, 7);
    targetY  = random(-7, 7);
  }
}

