int windowSize = 400;
int pixelSize = 2;
boolean showWarp[] = new boolean[windowSize/pixelSize+1];

void setup(){
  size(windowSize, windowSize, P2D);
  setupWeft();
  noLoop();
}

void draw(){
  background(255);
  //int changeCounterReset = 5;
  //int changeCounter = changeCounterReset;
  float c = .5;
  float cInc = (1./(windowSize/pixelSize))*(3*10+1)/(7*10+1);//4/9;
  noStroke();
  for(int i = 0; i < width; i += pixelSize){
    for(int j = 0, k = 0; j < height; j += pixelSize, k++){
      fill(255*c);
      if (showWarp[k]){
        rect(i, j, pixelSize, pixelSize);
      }
      c += cInc;
      if(c > 1.0){
        c = 1.0;
        cInc = -cInc;
      } if (c < 0.0){
        c = 0.0;
        cInc = -cInc;
      }
    }
  }
}

void setupWeft(){
  for(int i = 0; i < showWarp.length; i++){
    showWarp[i] = random(1.) >= .5;
  }
}
