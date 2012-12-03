color c1 = color(255);
color c2 = color(0);
class Diamond {

  int qSide = 4;
  public float drawScale = 10;
  ArrayList<Integer> items = new ArrayList<Integer>();

  Diamond(int qSide){
    this.qSide = qSide;
    this.generate();
  }
  public void generate(){
//    for(int i = 0; i < qSide*qSide; i++){
//      items.add(Integer.valueOf(int(random(0,4))));
//    }
    // "Latin" generation
    items.clear();
    HashSet<Integer> testSet = new HashSet<Integer>();
    for(int i = 0; i < qSide*qSide; i++){
      testSet.clear();
      Integer v = Integer.valueOf(int(random(0,qSide)));
      boolean again = false;
      int x = i%qSide;
      int y = i/qSide;
//      println(x+","+y+" -");
      
      do{
        again = false;
        for(int j = 0; j < x; j++){
          Integer tv = items.get(y*qSide+j);
//          println("test "+tv+","+v);
          testSet.add(tv);
        }
        for(int j = 0; j < y; j++){
          Integer tv = items.get(j*qSide+x);
//          println("check index "+(j*qSide+x));
          testSet.add(tv);
        } 
        do{
          v = Integer.valueOf(int(random(0,qSide)));
//          println("size "+testSet.size());
//          println(testSet.contains(v));
        }while(testSet.contains(v) && testSet.size() < qSide);
      }while(again);
      items.add(v);
      
    }
    this.prt();
    int r = int(random(0,3));
    if(r == 0){
      this.mirror(int(random(0,2)));
    }else if(r == 1){
      this.invert(int(random(0,2)));
    }else{
      this.loop();
    }
        this.prt();
  }
  
  public void loop(){
    this.mirror(0);
    this.mirror(1);
  }
  
  public void mirror(int axis){
    if(axis == 0){
      for(int x = 0; x < qSide/2; x++){
        for(int y = 0; y < qSide; y++){ 
          int tx = qSide-1-x;
          items.set(y*qSide+tx, Integer.valueOf(this.mirrorElementX(items.get(y*qSide+x).intValue())) );
        }
      }
    }else{
      for(int y = 0; y < qSide/2; y++){
        for(int x = 0; x < qSide; x++){ 
          int ty = qSide-1-y;
          println(y+" : "+ty);
          items.set(ty*qSide+x, Integer.valueOf(this.mirrorElementY(items.get(y*qSide+x).intValue())) );
        }
      }
    }
  }

  public void invert(int axis){
    if(axis == 0){
      for(int x = 0; x < qSide/2; x++){
        for(int y = 0; y < qSide; y++){ 
          int tx = qSide-1-x;
          items.set(y*qSide+tx, Integer.valueOf(this.invertElement(items.get(y*qSide+x).intValue())) );
        }
      }
    }else{
      for(int y = 0; y < qSide/2; y++){
        for(int x = 0; x < qSide; x++){ 
          int ty = qSide-1-y;
          items.set(ty*qSide+x, Integer.valueOf(this.invertElement(items.get(y*qSide+x).intValue())) );
        }
      }
    }
  }
  
  int mirrorElementX(int e){
    if(e == 1) return 2;
    if(e == 2) return 1;
    if(e == 0) return 3;
    if(e == 3) return 0;
    return 0;
  }
  int mirrorElementY(int e){
    if(e == 1) return 0;
    if(e == 0) return 1;
    if(e == 3) return 2;
    if(e == 2) return 3;
    return 0;
  }
  int invertElement(int e){
    if(e == 1) return 3;
    if(e == 3) return 1;
    if(e == 2) return 0;
    if(e == 0) return 2;
    return 0;
  }
//  int invertElement(int e){
//    if(e == 1) return 3;
//    if(e == 3) return 1;
//    if(e == 2) return 0;
//    if(e == 0) return 2;
//    return 0;
//  }
  
  public void draw(){
    pushMatrix();
    for(int y = 0; y < qSide; y++){
      pushMatrix();
      for(int x = 0; x < qSide; x++){
        drawTri(items.get(qSide*y+x).intValue(),drawScale);
        translate(drawScale,0);
      }
      popMatrix();
      translate(0,drawScale);
    }
    popMatrix();    
  }
  public void prt(){
    for(int y = 0; y < qSide; y++){
      for(int x = 0; x < qSide; x++){
        if(items.size() > y*qSide+x){
          print(items.get(y*qSide+x).intValue()+",");
        }
      }
      print("\n");
    }
  }
  public void drawTri(int orientation,float s){
   noStroke();
   fill(c1);
   rect(0,0,s,s);
   fill(c2);
   switch(orientation){
     case 0:
       /* 
              *
             **
       */
       beginShape();
       vertex(s,0);
       vertex(s,s);
       vertex(0,s);
       endShape(CLOSE);
       break;
      case 1:
       /* 
             **
              *
       */
       beginShape();
       vertex(0,0);
       vertex(s,0);
       vertex(s,s);
       endShape(CLOSE);
       break;
     case 2:
       /* 
             **
             *
       */
       beginShape();
       vertex(s,0);
       vertex(0,0);
       vertex(0,s);
       endShape(CLOSE);
       break;
      case 3:
       /* 
             *
             **
       */
       beginShape();
       vertex(0,0);
       vertex(0,s);
       vertex(s,s);
       endShape(CLOSE);
       break;
   }
  }
}
Diamond d = new Diamond(4);

void setup(){
  background(255);
  int spacing = 16;
  int rows = 10;
  int cols = 10;
  size(
  int((d.drawScale*d.qSide+spacing)*cols)+spacing,
  int((d.drawScale*d.qSide+spacing)*rows)+spacing
  );
  translate(spacing,spacing);
  for(int y = 0; y < rows; y++){
      pushMatrix();
      for(int x = 0; x < cols; x++){
        d.generate();
        d.draw();
        translate(d.drawScale*d.qSide+spacing,0);
      }
      popMatrix();
      translate(0,d.drawScale*d.qSide+spacing);
    }
}
