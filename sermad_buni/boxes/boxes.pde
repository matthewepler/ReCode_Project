  // This sketch is part of the ReCode Project - http://recodeproject.com
  // From Computer Graphics and Art vol2 no3 pg 10
  // by William Kolomyjec
  // "Boxes"
  // 
  // Sermad Buni
  // 2012
  // Creative Commons license CC BY-SA 3.0

void setup() {
    
    int canvaswidth = 17;
    int canvasheight = 10;
    
    int square_size = 40;
    
    float randomness = 0.03;
    
    float iw, jh;
    
    smooth(8);
   
    // set the size of the canvas
    size( (canvaswidth+2)*square_size, (canvasheight+2)*square_size, P2D );
    
    // set the background of the canvas
    
    background(#ffffff);
    
    // draw the squares
    
    // by default squares are drawn with a filled colour
    // so we need to turn this off 
    
    noFill();
    
    // we need to make a loop in a loop 
    
    for(int i=0; i < canvaswidth; i++) {
    
    for(int j=0; j < canvasheight; j++) {
    
        pushMatrix();
    
        // move the origin to the pivot point        
        translate((square_size*i), (square_size*j));
    
    // simple algo to increase rotation towards
    // the middle of the grid
    // check for odd or even canvas size to slightly alter the algo
    
    if(canvasheight % 2 == 0) {
      iw = canvaswidth/2 - Math.abs(i - canvaswidth/2);
    } else {
      iw = canvaswidth/2 - 0.5 - Math.abs(i - canvaswidth/2 - 0.5);
    }
   
    if(canvasheight % 2 == 0) {
      jh = canvasheight/2 - 0.5 - Math.abs(j - canvasheight/2 + 0.5);
    } else {
      jh = canvasheight/2 - Math.abs(j - canvasheight/2);
    }
      
    // check if we are not drawing the outer edges
    if( jh != 0 || iw != 0) {
    
      // rotate the square
      rotate( radians(iw * iw * jh * jh * random(-randomness,randomness)) );
    
    }
    
    // draw the square at the origin
    rect(square_size, square_size, square_size, square_size);
    
    popMatrix();
    
    }
 
  }
    
}
