// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol3 no2 pg 16
// Untitled 1
// by Aaron Marcus
// 
// Quin Kennedy
// 2012
// Creative Commons license CC BY-SA 3.0
char[] carat = Character.toChars(unhex("0302"));//carat
char[] filledSquare = Character.toChars(unhex("25FC"));//Black medium square
char[] emptySquare = Character.toChars(unhex("25FB"));//White medium square
                    //Character.toChars(unhex("25A2"));//White square with rouded corners
char[] medBar = Character.toChars(unhex("2759"));//medium vertical bar
char[] umlaut = Character.toChars(unhex("0308"));//umlaut
char[] bar = {'|'};//Character.toChars(unhex("2223"));//Character.toChars(unhex("2758"));//
char[] circle = {'O'};//{'o'};// Character.toChars(unhex("25CB"));//25EF"));//
char[] period = {'.'};
char[] space = {' '};
Symbol[] symbolSet = {new Symbol(carat, 0, 2./48., true),
                      new Symbol(umlaut, 2./39., 2./39., true),
                      new Symbol(circle, 1./39., -1./48., false),
                      new Symbol(emptySquare, 2./39., -1./39., false),
                      new Symbol(period, 2./39., -1./39., true),
                      new Symbol(space, 20./39., 19./48., false),
                      new Symbol(bar, 20./39., 19./48., false),
                      new Symbol(medBar, 0, 4./48., false),
                      new Symbol(filledSquare, 1./200., 9./48., false)};
Symbol lastSymbol = null;
//number selection inspired by version in PDF, not screenshot on website.
static final int numLines = 32;
static final int maxLinePixelWidth = 250;
static final int minLinePixelWidth = 100;
static final float aspectRatio = 2./3.; 
static final int vertBorder = 50;
static final int hBorder = 80;
static final int lineHeight = 15;
PFont f;
boolean wasModifier = false;

void setup(){
  size(maxLinePixelWidth+hBorder*2, numLines*lineHeight+vertBorder*2);
  noLoop();
  f = loadFont("STIXVariants-Bold-15.vlw");//"OriyaSangamMN-15.vlw");//"Raanana-15.vlw");//"LithosPro-Regular-15.vlw");//"OriyaMN-15.vlw");//"KhmerMN-15.vlw""LiHeiPro-15.vlw" "TeluguMN-15.vlw""TeluguMN-Bold-15.vlw""PTSans-Caption-15.vlw""STIXGeneral-Regular-15.vlw"
  textFont(f, 15);
  normalizeSymbols();
}

void normalizeSymbols(){
  float endPSum = 0, startPSum = 0;
  for(Symbol s : symbolSet){
    endPSum += s.endP;//max(0, s.endP);
    startPSum += s.startP;//max(0, s.startP);
  }
  for(Symbol s : symbolSet){
    s.endP /= endPSum;
    s.startP /= startPSum;
  }
}

void draw(){
  smooth(8);
  background(0);
  stroke(255);//240);//
  fill(255);//240);//
  strokeWeight(1);
  strokeJoin(SQUARE);
  strokeCap(SQUARE);
  pushMatrix();
  textAlign(CENTER, TOP);
  translate(width/2., vertBorder);
  int offset = 0;
  for(int i = 0; i < numLines; i++){
    drawLine(((float)i)/numLines);
    translate(0, lineHeight);
  }
  popMatrix();
}

void drawLine(float progress){
  int linePixelWidth = floor(random(minLinePixelWidth, maxLinePixelWidth+1));
  String currLine = "";
  String nextChar = "";
  boolean bSuccess = false;
  boolean isModifier = false;
  while(textWidth(trim(currLine+nextChar)) <= linePixelWidth){
    currLine += nextChar;
    nextChar = getNext(progress);
  }
  text(trim(currLine), 0, 0);
}

String getNext(float progress){
  Symbol currSymbol;
  boolean bSuccess;
  do{
    float r = random(1);
    int i = -1;
    while(r >= 0 && i < symbolSet.length - 1){
      i++;
      r -= max(0, symbolSet[i].getCurrP(progress));
    }
    currSymbol = symbolSet[i];
    bSuccess = lastSymbol == null || !(lastSymbol.modifier && currSymbol.modifier);
  }while(!bSuccess);
  lastSymbol = currSymbol;
  return new String(currSymbol.unicode);
}

class Symbol{
  char[] unicode;
  float startP;
  float endP;
  float currP;
  boolean modifier;
  
  public Symbol(char[] _unicode, float _startP, float _endP, boolean _modifier){
    unicode = _unicode;
    startP = _startP;
    endP = _endP;
    currP = _startP;
    modifier = _modifier;
  }
  
  float getCurrP(float p){
    progress(p);
    return currP;
  }
  
  void progress(float p){
    currP = startP * (1-p) + endP * p;
  }
}
