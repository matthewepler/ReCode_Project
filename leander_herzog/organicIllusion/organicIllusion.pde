// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol2 no3 pg 13
// "Organic Illusion"
// by William Kolomyjec
// 
// Leander Herzog
// 2012
// Creative Commons license CC BY-SA 3.0

william[] williams;
int rows=2, columns=6, unit=200;
void setup() {
  size(unit*columns, unit*rows);
  background(255);
  williams=new william[rows*columns];
  for (int i=0;i<columns;i++) {
    for (int j=0;j<rows;j++) {
      williams[i+j]=new william(new PVector(i*unit, j*unit));
    }
  }
}

class william extends PVector {
  PVector[] p;
  PVector shift=new PVector(random(-unit*0.2,unit*0.2),random(-unit*0.2,unit*0.2));
  int res=round(unit*0.1*2), m=round(unit*0.1);
  float radius=unit*0.25, angle=0, flex=180, offset=random(-flex, flex);
  public william(PVector pos) {
    this.set(pos);
    p=new PVector[res*2];
    PVector tmp=new PVector();
    PVector dir=new PVector(m, 0);
    for (int i=0;i<res; i++) {
      angle=radians(map(i, 0, res, 0, 360)+offset);
      p[i]=new PVector(this.x+unit*0.5+sin(angle)*radius+shift.x,this.y+unit*0.5+cos(angle)*radius+shift.y);
      p[i+res]=new PVector(this.x+tmp.x, this.y+tmp.y);
      tmp.add(dir);
      if (i+1==res/4) dir.set(0, m, 0);
      else if (i+1==res/2) dir.set(-m, 0, 0);
      else if (i+1==res/4*3) dir.set(0, -m, 0);
    }
    for (int i=0;i<res; i++)line(p[i].x, p[i].y,p[i+res].x,p[i+res].y);
  }
}

