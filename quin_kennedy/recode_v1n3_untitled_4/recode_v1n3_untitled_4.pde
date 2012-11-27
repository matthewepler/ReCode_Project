PImage[] tiles = new PImage[7];
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
  
  PGraphics pg2 = createGraphics(tileSize, tileSize);
  pg2.beginDraw();
  pg2.background(0);
  pg2.noStroke();
  pg2.fill(255);
  pg2.rect(0, 0, tileSize, tileSize/2);
  pg2.endDraw();
  tiles[i++] = pg2;
  
  PGraphics pg3 = createGraphics(tileSize, tileSize);
  pg3.beginDraw();
  pg3.background(255);
  pg3.noStroke();
  pg3.fill(0);
  pg3.rect(0, 0, tileSize, tileSize/2);
  pg3.endDraw();
  tiles[i++] = pg3;
  
  PGraphics pg4 = createGraphics(tileSize, tileSize);
  pg4.beginDraw();
  pg4.background(0);
  pg4.noStroke();
  pg4.fill(255);
  pg4.triangle(0, 0, tileSize, 0, 0, tileSize);
  pg4.endDraw();
  tiles[i++] = pg4;
  
  PGraphics pg5 = createGraphics(tileSize, tileSize);
  pg5.beginDraw();
  pg5.background(255);
  pg5.noStroke();
  pg5.fill(0);
  pg5.triangle(0, 0, tileSize, 0, 0, tileSize);
  pg5.endDraw();
  tiles[i++] = pg5;
  
  //might happen less often than others...
  PGraphics pg6 = createGraphics(tileSize, tileSize);
  pg6.beginDraw();
  pg6.background(0);
  pg6.endDraw();
  tiles[i++] = pg6;
  //PGraphics pg2 = createGraphics(width/15, width/15, P2D);
}
