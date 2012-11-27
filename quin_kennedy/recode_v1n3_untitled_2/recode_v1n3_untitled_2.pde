PImage[] tiles = new PImage[2];
static final int windowSize = 400;
static final int tileSize = windowSize/5;

void setup(){
  size(windowSize,windowSize, P2D);
  createTiles();
  noLoop();
}

void draw(){
  background(255);
  imageMode(CENTER);
  for(int i = 0; i < width; i+=tileSize){
    for(int j = 0; j < height; j+=tileSize){
      int tile = floor(random(tiles.length));
      //boolean bw = (random(2) >= 1);
      int rotation = floor(random(4));
      pushMatrix();
      translate(i,j);
      translate(tileSize/2, tileSize/2);
      rotate(PI*rotation/2);
      image(tiles[tile], 0, 0);
      popMatrix();
    }
  }
}

void createTiles(){
  int i = 0;
  PGraphics pg = createGraphics(tileSize, tileSize);
  pg.beginDraw();
  pg.background(0);
  pg.noStroke();
  pg.fill(255);
  pg.ellipse(0, 0, tileSize*2, tileSize*2);
  pg.endDraw();
  tiles[i++] = pg;
  
  PGraphics pg1 = createGraphics(tileSize, tileSize);
  pg1.beginDraw();
  pg1.background(255);
  pg1.noStroke();
  pg1.fill(0);
  pg1.ellipse(0, 0, tileSize*2, tileSize*2);
  pg1.endDraw();
  tiles[i++] = pg1;
}
