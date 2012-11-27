PVector[] points = {new PVector(0, 0), new PVector(1./3., 1./3.), new PVector(2./3., 2./3.),
            new PVector(4./3., 4./3.), new PVector(5./3., 5./3.), new PVector(2, 2)};
static final int windowSize = 400;
static final int tileSize = windowSize/6;

void setup(){
  size(windowSize,windowSize, P2D);
  noLoop();
}

void draw(){
  background(255);
  imageMode(CENTER);
  for(int i = 0; i < width; i+=tileSize){
    for(int j = 0; j < height; j+=tileSize){
      PGraphics pg = createGraphics(tileSize, tileSize, P2D);
      pg.beginDraw();
      pg.background(255);
      pg.noStroke();
      pg.fill(0);
      pg.scale(tileSize);
      boolean black = (random(2.) >= 1.);
      for(int k = 1; k < points.length; k++){
        black = (random(1.) > .75 ? black : !black);
        if (!black){
          continue;
        }
        pg.quad(points[k-1].x, 0, points[k].x, 0, 0, points[k].y, 0, points[k-1].y);
      }
      pg.endDraw();
      pushMatrix();
      translate(i,j);
      translate(tileSize/2, tileSize/2);
      rotate(PI/2);
      image(pg, 0, 0);
      popMatrix();
    }
  }
}
