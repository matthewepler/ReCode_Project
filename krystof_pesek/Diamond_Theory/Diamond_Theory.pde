/**
 * This sketch is part of the ReCode Project - http://recodeproject.com
 * From Computer Graphics and Art vol2 no1
 * 
 * "Diamond Theory"
 * by Steven H Cullinane 1977
 *
 * direct recode by Krystof Pesek 2012
 * released under Creative Commons Attribution-ShareAlike 3.0 license
 *
 */

int siz = 4;

int w = 16*siz;
int h = 16*siz;

PGraphics triangle;
ArrayList generators;

void setup(){
  size(w*8+16*8,h*8+16*8);
  triangle = prepareTriangle();
  generateUnits(triangle);
}

void draw(){
  background(255);

  //if(frameCount%3==0)
  //  mutate();

  translate(triangle.width/2,triangle.height/2);

  for(int i = 0 ; i < generators.size();i++){
    Generator current = (Generator)generators.get(i);
    current.draw();
  }

}

void generateUnits(PGraphics _tmp){

  generators = new ArrayList();
  for(int y = 0 ;y < height ; y += w+_tmp.width){
    for(int x = 0 ;x < width ; x += h+_tmp.height){
      generators.add(new Generator(x,y,w,h,_tmp));
    }
  }


}

PGraphics prepareTriangle(){
  PGraphics tmp = createGraphics(siz*4,siz*4,JAVA2D);

  tmp.beginDraw();
  tmp.background(255);
  tmp.fill(0);
  tmp.noStroke();
  tmp.triangle(0,0,width,height,0,height);
  tmp.endDraw();

  return tmp;
}

class Generator{

  PGraphics shape;
  int X,Y,W,H;
  ArrayList rulesx,rulesy;

  float speed = 1.0;
  int row = 0;

  Generator(int _x,int _y,int _w, int _h, PGraphics _shape){
    X = _x;
    Y = _y;
    W = _w/siz;
    H = _h/siz;
    shape = _shape;


    randomize();

    //initialize();
    //generate(10);


  }

  void generate(int howmuch){
    for(int i = 0; i < howmuch;i++){
      float ran = random(100);
      if(ran>66){
        mirrorX((int) random(5));
      }else if(ran>33){
        mirrorY((int) random(5));
      }else{
        //swap1((int)random(3) );
      }
    }
  }

  void initialize(){
    rulesx = new ArrayList();
    rulesy = new ArrayList();

    for(int i = 0 ; i < 4;i++){
      rulesx.add("1111");
      rulesy.add("1000");
    }

  }

  void swap1(int mode){
    switch(mode){
      case 0:
        for(int i = 0 ; i < 2;i++){
        
          String rx = (String)rulesx.get(i);
          String other = (String)rulesx.get(i+2);
          String neue = "";

          for(int ii = 0 ; ii < 4 ; ii++){
            if(ii<2)
              neue += other.charAt(ii+2)=='0'?'0':'1';
            else
              neue+=rx.charAt(ii);
          }
          rulesx.set(i,neue);
        }
        break;
      
      case 1:
        for(int i = 2 ; i < 4;i++){
        
          String rx = (String)rulesx.get(i);
          String other = (String)rulesx.get(i-2);
          String neue = "";

          for(int ii = 0 ; ii < 4 ; ii++){
            if(ii<2)
              neue += other.charAt(ii+2)=='0'?'0':'1';
            else
              neue+=rx.charAt(ii);
          }
          rulesx.set(i,neue);
        }
        break;


    }
  }

  void mirrorX(int where){
    for(int i = 0 ; i < rulesx.size();i++){
      String rx = (String)rulesx.get(i);
      String ry = (String)rulesy.get(i);
      
      String neuex = "";
      String neuey = "";
      for(int ii = 0 ; ii < where ; ii++){
        neuex += rx.charAt(3-ii)=='0'?'1':'0';
        neuey += ry.charAt(3-ii);

      }
      for(int ii = where ; ii < 4 ; ii++){
        neuex += rx.charAt(ii);
        neuey += ry.charAt(ii);
      }
      rulesx.set(i,neuex);
      rulesy.set(i,neuey);
    }
  }



  void mirrorY(int where){
    for(int i = 0 ; i < rulesx.size();i++){
      String rx = (String)rulesx.get(i);
      String ry = (String)rulesy.get(i);
      
      String neuex = "";
      String neuey = "";
      for(int ii = 0 ; ii < where ; ii++){
        neuey += ry.charAt(3-ii)=='0'?'1':'0';
        neuex += rx.charAt(3-ii);

      }
      for(int ii = where ; ii < 4 ; ii++){
        neuey += ry.charAt(ii);
        neuex += rx.charAt(ii);
      }
      rulesx.set(i,neuex);
      rulesy.set(i,neuey);
    }
  }

  void randomize(){

    rulesx = new ArrayList();
    rulesy = new ArrayList();

    for(int r = 0 ; r < 4;r++){

      String rulex = "";
      String ruley = "";

      for(int i = 0 ; i < 4;i++){
        rulex += random(100)>50?"1":"0";
        ruley += random(100)>50?"1":"0";
      }

      rulesx.add(rulex);
      rulesy.add(ruley);

      row++;

    }

  }

  void draw(){
    int cntx = 0, cnty = 0;

    pushMatrix();
    translate(X,Y);
    for(int yy = 0; yy < W*siz ; yy+=shape.width){
      cntx = 0;
      for(int xx = 0; xx < H*siz ; xx+=shape.height){
        pushMatrix();

        translate(xx,yy);

        String rulex = (String)rulesx.get(cntx);
        String ruley = (String)rulesx.get(cntx);

        if(rulex.charAt(cntx)=='1'){
          scale(-1,1);
          translate(-shape.width,0);
        }

        if(ruley.charAt(cnty)=='1'){
          scale(1,-1);
          translate(0,-shape.height);
        }

        image(shape,0,0);
        popMatrix();
        cntx++;
      }
      cnty++;
    }
    popMatrix();
  }

}

void mutate(){
  for(int i = 0 ; i < generators.size();i++){
    Generator current = (Generator)generators.get(i);
    current.generate(1);
  }
}

void mousePressed(){
  mutate();
}

