/**
 * This sketch is part of the ReCode Project - http://recodeproject.com
 * From Computer Graphics and Art vol1 no2
 * 
 * "Structure"
 * by Zdenek Sykora 1976
 *
 * experimental recode by Kof 2012
 *
 * Copyright (c) 2012 Krystof Pesek
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:

 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

/////////////////////////////////

float theta[];
PGraphics plny;
int [] moznosti = {0,90,180,270};
float [] rot = {1,2,4};
float  r;

/////////////////////////////////

void setup(){
  size(576,704,P2D);
  imageMode(CENTER);

  plny = createGraphics(32,32,JAVA2D);
  createShaped();

  theta = new float[3000];
  for (int i = 0 ; i < theta.length ; i ++){
    theta[i] = moznosti[(int)random(4)];
  }
}

/////////////////////////////////

void draw(){
  background(0);

  r = plny.width;

  int idx = 0;
  for(int y = 0;y <= height/plny.height;y++){
    for(int x = 0;x <= width/plny.width;x++){
      pushMatrix();
      translate(x*r+plny.width/2,y*r+plny.height/2);
      rotate(radians(theta[idx]));
      theta[idx] += 0.004*degrees(frameCount/200.0*atan2(mouseY-y*r,mouseX-x*r));
      image (plny,0,0);
      popMatrix();

      idx += 1;
    }
  }
}

/////////////////////////////////

void createShaped(){
  int W = plny.width;
  int H = plny.height;

  plny.beginDraw();
  plny.smooth();
  plny.fill(255);
  plny.noStroke();
  plny.arc(W/2,H/2,W-2,H-2,0,PI);
  plny.endDraw();
}

/////////////////////////////////
