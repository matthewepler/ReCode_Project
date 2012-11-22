
// This sketch is part of the ReCode Project - http://recodeproject.com

////////////////////////////////////////////////////////////////////////
//                                                                    //
//   "Dynamic Object GF.E (16, 4) 69/71" by Vladimir Bonačić          //
//                                                                    //
//                     (interactive version)                          //
//                                                                    //
////////////////////////////////////////////////////////////////////////

// (c) Martin Schneider 2012

// Creative Commons license CC BY-SA 3.0

// The dynamic object is a 32 x 32 display.
// It visualizes objects from  abstract algebra, 
// which are known as Galois groups.

// Source:
// "Research and Teaching in Art and Science" by Vladimir Bonačić
// Computer Graphics and Art Vol. 2, No. 3 pp. 4-8

// See also:
// "Kinetic Art: Application of Abstract Algebra to Objects with Computer-
// Controlled Flashing Lights and Sound Combinations" by Vladimir Bonačić
// Leonardo, Vol. 7, No. 3
// Note: This paper is quite mathematical at times.
// The implementation however is actually really simple.


///////////////////////// INTERACTIVE VERSION ///////////////////////////

// This is the dynamic interactive version with pattern cycling and 
// mouse interaction ( the original had 32 keys to control the pattern )

// - press space to switch through presets
// - press 'a' to animate 
// - use the mouse to modify the pattern


////////////////////////////////////////////////////////////////////////

int d = 1<<5;            // cells per dimension
int led = 10;            // size of the light bulb
int w = led * d + 1;     // display size
int pick = 1;            // picked preset

// we need the long datatype, because we have 32 bit positive integers
long[] preset= { 4294967295l, 100675584l, 2146959392l, 4293918847l };

// there are 2^32 different patterns controlled by the 32 bits of p
long p = preset[pick];

// the generator is used to create a more interesting pattern sequence
long generator = 4299161607l; 

int frames = 30;
boolean animate = false;
boolean debug = true;


void setup() {
 size(w, w);
 info();
}


void draw() {
  
  // draw the pattern
  background(0);
  for(int y = 0; y < d; y++) {
    for(int x = 0; x < d; x++) {
      
      // this is where the magic happens
      if( (1l<<(x ^ y) & p ) > 0) {   
        rect(led * x, led * y, led, led);
      }
      
    }
  }
  
  if(animate) {

    // jump to a different pattern
    if( frameCount % frames == 0) {
       p *= 2;
       if(p >= 1l<<d) p ^= generator;
       info();
    }
    
  } else {
    
    // change the pattern using the mouse
    if(mousePressed) {
      int x = (mouseX/led) & d-1;
      int y = (mouseY/led) & d-1;
      long bit = 1l<<(x ^ y);
      p = mouseButton == LEFT ? p | bit : p & ~bit;
      info();
    }
    
  }

}


void keyPressed() {
  
  switch(key) {
    // animation on/off
    case 'a': animate = ! animate;  return;
    // switch between presets
    case ' ': p = preset[pick = (pick + 1) % preset.length]; animate = false; break;
    // next pattern
    case '+': p++; break;
    // previous pattern
    case '-': p--; break;
    // toggle debugging
    case 'd': debug = !debug;
    default: return;
  }
  
  // constrain to 32 bits
  p &= ((1l<<d) - 1) ;
  info();
}


// show pattern input
void info() {
  if(debug) println("p = [" + binary((int) + p, d)+  "] = " + p ); 
}


