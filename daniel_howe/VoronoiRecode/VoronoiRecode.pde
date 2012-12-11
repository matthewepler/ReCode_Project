/**
 * This sketch is part of the ReCode Project - http://recodeproject.com
 * Computer Graphics and Art – May, 1978 – Vol. 3, No. 2 – Pg 11
 * 
 * "Equidistant Space"
 * by Peter Milojevic
 *
 * direct recode by Daniel C. Howe (Delaunay code from Marcus Appel)
 *
 * Copyright (c) 2012 Daniel C. Howe
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


ArrayList nodes, edges, tris;
Edge actE, hullStart, index[];
Delaunay dt;

void setup() {

  frameRate(10);
  size(580, 580);
  dt = new Delaunay(45);  
}

void draw() {

  if (keyPressed && key==' ') return;
  
  update();

  background(255);
  strokeWeight(2);
  rect(0,0,width-1,height-1);
  
  float tcx, tcy;
  for (int i = 0; i < edges.size(); i++) {
    
    Edge e = (Edge) edges.get(i), ee = e.invE;
    if (ee == null || ee.inT == null) {
      
      tcx = e.inT.c_cx - e.p2.y + e.p1.y;
      tcy = e.inT.c_cy - e.p1.x + e.p2.x;
    } 
    else {
      tcx = ee.inT.c_cx;
      tcy = ee.inT.c_cy;
    }
    line(e.inT.c_cx, e.inT.c_cy, tcx, tcy);
  }

  for (int i = 0; i < nodes.size(); i++)
    ellipse((nodeAt(i)).x - 1, (nodeAt(i)).y - 1,2,2);
}

void update() {

  background(255);

  // insert points at center
  int px = width/2;
  int py = height/2;
  dt.insert(px, py);
  dt.insert(px + 1, py);
  dt.insert(px + 1, py + 1);
  dt.insert(px, py + 1);

  // neighbors repulse each other
  int D = (int) Math.sqrt(nodes.size());
  for (int i = 0; i < edges.size(); i++) {
    Edge edge = (Edge) edges.get(i);
    clip2(edge.p1);
    clip2(edge.p2);
    int x = edge.p2.x - edge.p1.x;
    int y = edge.p2.y - edge.p1.y;
    int rr = x * x + y * y;
    if (rr < width * height / D / D)
      rr /= 2;
    if (rr > 0) {
      rr *= D;
      x = width * x / rr;
      y = height * y / rr;
      edge.p1.x -= x;
      edge.p1.y -= y;
      edge.p2.x += x;
      edge.p2.y += y;
    }
  }

  // move/scale the graph to fit
  ArrayList tmpNodes = new ArrayList();
  int xlo = width, ylo = height, xhi = 0, yhi = 0;
  for (int i = 0; i < nodes.size(); i++) {
    Node node = nodeAt(i);
    xlo = Math.min(xlo, node.x);
    ylo = Math.min(ylo, node.y);
    xhi = Math.max(xhi, node.x);
    yhi = Math.max(yhi, node.y);
    tmpNodes.add(node);
  }

  for (int i = 0;  i < 4; i++) 
      tmpNodes.remove((int) random(tmpNodes.size()));

  dt.clear();
  for (int i = 0; i < tmpNodes.size(); i++) {
    Node node = (Node) tmpNodes.get(i);
    int nx = (node.x - xlo) * width / (xhi - xlo);
    int ny = (node.y - ylo) * height / (yhi - ylo);
    dt.insert(nx,ny);
  }
}

void clip(Node p) {
  if (p.x < 1) p.x++;
  if (p.x > width - 2) p.x--;
  if (p.y < 1) p.y++;
  if (p.y > height - 2) p.y--;
}

void clip2(Node p) {
  float d = dist(p.x,p.y,width/2,height/2);
  if (d > width/2) {
    p.x += (p.x < width/2) ? 1 : -1; 
    p.y += (p.y < height/2) ? 1 : -1; 
  }
}

Node nodeAt(int i) {
  return (Node) nodes.get(i);
}

