  // This sketch is part of the ReCode Project - http://recodeproject.com
  // From Computer Graphics and Art vol1 no3 pg 25
  // by Roger Coqart
  // "Traveling through the square series"
  // 
  // Sermad Buni
  // 2012
  // Creative Commons license CC BY-SA 3.0
  
  // globals
  int square_size = 40;
  int canvaswidth = 16;
  int canvasheight = 9;
  
  Square[][] squares = new Square[canvaswidth][canvasheight];

void setup() {
    
    strokeWeight(1);
    
    smooth(8);
    
    // set the size of the canvas
    size( (canvaswidth + 2) * square_size, (canvasheight + 2) * square_size, P2D );
    
    // set the background of the canvas
    background(#ffffff);
    
    // by default squares are drawn with a filled colour
    // so we need to turn this off 
    noFill();
    
    // we need to make a loop in a loop 
    
    for(int i=0; i < canvaswidth; i++) {
    
      for(int j=0; j < canvasheight; j++) {
      
        squares[i][j] = new Square(i, j);
        
        squares[i][j].display();
    
      }
 
    }
    
 // finished!
// save("traveling_through_square_series.jpg");
    
}
