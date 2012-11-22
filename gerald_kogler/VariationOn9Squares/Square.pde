class Square {
  int x,y;       //position in grid
  boolean hor;   //orientation of squares
  
  Square(int x, int y, boolean hor){
    this.x = x;
    this.y = y;
    this.hor = hor;
  }
  
  void draw() {
    float step = 0;
    for (float angle=0; angle<=HALF_PI; angle+=step) {
      if (mode == 'e') step = (HALF_PI+0.1-angle)*ease;
      else step = HALF_PI/(ease*10);
      
      float cx = margin + x*(2*r-overlap);
      float cy = margin + y*(2*r-overlap);
      float sx,sy;      
      if (hor) {
        sx = r +r * cos(angle);
        sy = r+ r * sin(angle);
      }
      else {
        sx = r + r * sin(angle);
        sy = r + r * cos(angle);
      }
      float sw = (r - sx) * 2;
      float sh = (r - sy) * 2;
      rect(cx+sx, cy+sy, sw, sh);
    }
  }
}
