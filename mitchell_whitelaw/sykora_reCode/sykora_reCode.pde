
// This sketch is part of the ReCode Project - http://recodeproject.com
// 
// From Computer Graphics and Art vol1 no2 pg 17
// by Zdenek Sykora
// "Structure"

// Mitchell Whitelaw
// 2012
// Creative Commons license CC BY-SA 3.0

int moduledim = 40;
int gridwidth = 11;
int gridheight = 22;

void setup(){
  size(440,880);
   smooth();
   noLoop();
   ellipseMode(CENTER);
}


void draw(){
  noStroke();
  translate(moduledim/2,moduledim/2);
  for (int i=0; i< gridwidth; i++){
    for (int j=0; j< gridheight; j++){
      sykoraModule(int(random(2)),int(random(3)),int(random(4)),i,j);
    }
  }
}


void sykoraModule( int polarity, int composition, int orientation, int gridx, int gridy) {
  pushMatrix();
    translate(gridx*moduledim,gridy*moduledim);
    rotate(orientation*TWO_PI/4.0); 
    translate(-moduledim/2, -moduledim/2);
    
    fill(polarity*255); // bg fill
    rect(0,0, moduledim, moduledim); // bg square
    
    fill(abs(polarity-1)*255); // reverse the fill
    
    arc(moduledim/2, 0, moduledim, moduledim, 0, PI); // composition == 0; first arc
    
    if (composition == 1){ // more arcs
      arc(moduledim/2, moduledim/2, moduledim, moduledim, 0, PI); // second arc (aligned)
    } else if (composition == 2){ 
      arc(moduledim/2, moduledim, moduledim, moduledim, PI, TWO_PI); // second arc (mirrored);
    }
   popMatrix();
}



void mousePressed(){
  redraw();
}  


