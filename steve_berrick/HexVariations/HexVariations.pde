// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no4 Back Cover
// by William Kolomyjec
// "Hex Variations"
// 
// Steve Berrick
// 2012
// Creative Commons license CC BY-SA 3.0

int _width = 600;
int _height = 900;
int _size = 20;     // hexagon radius

void setup() {
  
  size(_width, _height);
  noLoop();
  
  background(255);
  noFill();
  stroke(0);
  strokeWeight(2);

}

void draw() {

  // clear background
  background(255);
  
  // line length (hypotenuse)
  float h = sin(THIRD_PI) * _size;
  
  for (int i = 0; i <= _width / (_size * 3); i++) {
    for (int j = 0; j <= (_height / h) + 1; j++) {

      // reference points (centre of each hexagon)
      float x = i * _size * 3 + (_size / 2);
      float y = j * h;
      // offset each odd row
      if (j % 2 > 0) {
        x += _size * 1.5;
      }

      pushMatrix();
      
        translate(x, y);
        
        // random hexagon 'rotation' (0, 120, 240 degrees)
        rotate(int(random(0, 3)) * THIRD_PI);
    
        // draw line
        line(0, -h, 0, h);
  
        // draw arcs
        arc(-_size, 0, _size, _size, -THIRD_PI,     THIRD_PI);
        arc( _size, 0, _size, _size,  THIRD_PI * 2, THIRD_PI * 4); 
      
      popMatrix();

    }  
  }

}

void mousePressed() {
  
  redraw();

}  

