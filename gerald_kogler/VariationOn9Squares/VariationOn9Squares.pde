/* 
 * This sketch is part of the ReCode Project - http://recodeproject.com
 * from Computer Graphics and Art Magazine, Vol. 1, No. 2, May 1976, page 17
 * "Variation on 9 Squares"
 * by Roger Vilder
 * from the SDL Collection
 *
 * Gerald Kogler
 * Nov. 14 2012
 * Creative Commons license CC BY-SA 3.0
 */

int s = 480;        //size of sketch
int num = 3;        //num of lines and columns in grid
float margin = 30;  //margin around rectangles areas
float overlap = 40; //overlap of reactangle areas
float ease = 0.3;   //easing/division factor for non/linear distribution
char mode = 'e';    //mode 'l'==linear, 'e'==exponential distribution
color bg = 0; 
float r;
Square[] squares = new Square[num*num];

void setup() {
  size(480,480);
  noFill();
  stroke(255);
  r = ((width-2*margin)/num)/2+overlap/num;

  //make instances of squares
  for (int y=0; y<num; y++) {
    for (int x=0; x<num; x++) {
      squares[x+y*num] = new Square(x,y,((x+y*num)%2==0));
    }
  }
}

void draw() {
  background(bg);
  for (int i=0; i<num*num; i++) {
    squares[i].draw();
  }
}

void keyPressed() {
  if (key == 's') {
    save("RogerVilder-"+mode+ease+".png");
  }
  else if (key == 'b') {
    if (bg == 0) {
      bg = 255;
      stroke(0);
    }
    else {
      bg = 0;
      stroke(255);
    }
  }
  else if (key == 'm') {
    if (mode == 'l') mode = 'e';
    else mode = 'l';
  }
  else if (key == '+') {
    if (ease > 0.15) ease-=0.1;
  }
  else if (key == '-') {
    if (ease < 1.0) ease+=0.1;
  }
}

