/* 
Part of the ReCode Project (http://recodeproject.com)
Based on "Universal Declaration of Human Rights" by Kenneth Knowlton
Originally published in "Computer Graphics and Art" vol1 no2, 1976
Copyright (c) 2012 Quin Kennedy - OSI/MIT license (http://recodeproject/license).
*/

//image from: http://www.metro.co.uk/news/841183-photos-around-the-world-in-80-days-competition-winners

void setup(){
  //size(629, 821, P2D);//aspect ratio of piece in PDF
  
  if (use == 0){
    size(686, 820, P2D);//pretty close with Krungthep-10
  } else if (use == 1){
    size(646/*660*/, 818, P2D);//set for KufiStandardGK-10
  } else if (use == 2){
    size(686, 820, P2D);//pretty close with Krungthep-12
  } else if (use == 3){
    size(686, 819, P2D);//used with no font specified
  }
  noLoop();
}

PFont f;
//3 works well, just the font is too clean
//1 has a nice pixely font
static final int use = 1;

void draw(){
  PImage img = loadImage("girl_gaze_contrast1_small2.jpg");
  PGraphics i = createGraphics(width, height, P2D);
  i.beginDraw();
  i.background(0);
  float srcWidth = width/(((float)height)/img.height);
  i.blend(img, (int)((img.width - srcWidth)/2), 0, (int)srcWidth, img.height, 0, 0, width, height, DIFFERENCE);
  i.endDraw();
  
  PGraphics t = createGraphics(width, height, P2D);
  t.beginDraw();
  if (use == 0){
    f = loadFont("Krungthep-10.vlw");
  } else if (use == 1){
    f = loadFont("KufiStandardGK-10.vlw");//"Krungthep-10.vlw");
  } else if (use == 2){
    f = loadFont("Krungthep-12.vlw");
  } else if (use == 3){
    //don't load a font
  }
  if (f != null){
    t.textFont(f);
  }
  t.background(0);
  t.stroke(255);
  t.textAlign(CENTER);
  String s = join(loadStrings("Universal Declaration of Human Rights.txt"), " ");
  String small = s;
  int offset = 0;
  float px = width/2.;
  float py = 16;
  while (small.length() > 0){
    while (small.length() > 0 && !lineJustify(small, px, py, width-20, t)){
      int lastSpace = small.lastIndexOf(' ');
      if (lastSpace == -1){
        println("OH NO!");
        return;
      }
      small = small.substring(0, lastSpace);
    }
    py += 11;
    offset += small.length() + 1;
    if (offset >= s.length()){
      break;
    }
    small = s.substring(offset);
  }
  t.endDraw();
  PShader shade = loadShader("frag.glsl");
  i.loadPixels();
  t.loadPixels();
  loadPixels();
  for(int k = 0; k < pixels.length; k++){
    int ip = i.pixels[k];
    int tp = t.pixels[k];
    colorMode(RGB, 1);
    pixels[k] = color((red(ip)*3/4+.25)*(red(tp)), 
                      (green(ip)*3/4+.25)*(green(tp)), 
                      (blue(ip)*3/4+.25)*(blue(tp)));
  }
  updatePixels();
  filter(shade);
  filter(shade);
  //filter(shade);
  //filter(shade);
  //filter(THRESHOLD, .2);//too strong
}

//thanks to https://forum.processing.org/topic/writing-text-without-line-word-breaks
boolean lineJustify(String s, float px, float py, int w, PGraphics g){
  float tw = g.textWidth(s);
  if (tw > w){
    return false;
  }
  if (tw == w){
    g.text(s, px, py);
    return true;
  }
  String[] tokens = split(s, " ");
  if (tokens.length <= 1){
    g.text(s, px, py);
    return true;
  }
  float tow = 0;
  for(String currS : tokens){
    tow += g.textWidth(currS);
  }
  
  float cx = px - w/2.;
  float gap = w - tow;
  float gutter = gap/(tokens.length-1.);
  for(int i = 0; i < tokens.length; i++){
    cx += g.textWidth(tokens[i])/2;
    g.text(tokens[i], cx, py);
    cx += g.textWidth(tokens[i])/2+gutter;
  }
  return true;
}
