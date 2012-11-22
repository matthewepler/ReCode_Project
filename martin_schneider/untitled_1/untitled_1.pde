
// This sketch is part of the ReCode Project - http://recodeproject.com

////////////////////////////////////////////////////////////////////////
//                                                                    //
//           "Orbits of Galois Fields" by Vladimir Bonačić            //
//                                                                    //
//                          ( untitled 1)                             //
//                                                                    //
////////////////////////////////////////////////////////////////////////

// (c) Martin Schneider 2012

// Creative Commons license CC BY-SA 3.0

// These patterns are displayed using 32 x 32 dots.
// They visualize objects from  abstract algebra, 
// namely orbits of galois fields.

// Source:
// "Research and Teaching in Art and Science" by Vladimir Bonačić
// Computer Graphics and Art Vol. 2, No. 3 pp. 4-8

// See also:
// "Kinetic Art: Application of Abstract Algebra to Objects with Computer-
// Controlled Flashing Lights and Sound Combinations" by Vladimir Bonačić
// Leonardo, Vol. 7, No. 3
// Note: This paper is quite mathematical at times.
// The implementation however is actually really simple.


/////////////////////////////// UNTITLED 1  ////////////////////////////

// This is a recreation of the four orbits shown in the right column

// Fig e) and f)  generator polynomial: x^10 + x^7 + x^2 + 1 
// Fig g) and h)  generator polynomial: x^10 + x^5 +x^4 +x^3 + x^2 + x^1 + 1

// NOTE:
// The images in the original publication are flipped in various ways.
// This may be due to different axis directions, indexing order, 
// an error in  reproduction, or a combination of all of the above.


////////////////////////////////////////////////////////////////////////

int n = 5;           // bits per dimension
int d = 1<<n;        // cells per dimension
int led = 10;        // size of the dot
int w = led * d + 1; // screen size

int[] preset = { 1087, 1087, 1157, 1157 };
int[] offset = { 2, 31, 9, 15 }; 
int pick;


void setup() {
 size(w, w);
 ellipseMode(CORNER); 
 stroke(255);
 fill(0); 
 smooth();
}


void draw() {
  
  int p = preset[pick];
  int i = offset[pick];
  
  // create empty field
  boolean[] field = new boolean[d*d];

  // find all cells in the orbit
  while(!field[i]) {
    field[i] = true;
    i *= 2; 
    if(i >= d*d )  i ^= p;
  } 
  
  // draw display
  background(255); 
  for(i = 0; i < d*d; i++) {
    if(field[i]) { 
      ellipse( led * (i % d), led * (i / d), led, led);
    }
  }
   
}


void keyPressed() {
  pick = (pick + 1) % preset.length;
}
