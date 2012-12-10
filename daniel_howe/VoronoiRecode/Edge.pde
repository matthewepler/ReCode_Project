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


class Edge {
  
  Node p1, p2; // start and end point of the edge
  Triangle inT; // triangle containing this edge
  float a, b, c; // line equation parameters: aX+bY+c=0
  Edge invE, nextE, nextH;

  public Edge(Node p1, Node p2) {
    updateEdge(p1, p2);
  }

  public void updateEdge(Node p1, Node p2) {
    this.p1 = p1;
    this.p2 = p2;
    setAbc();
    asIndex();
  }

  void setNextE(Edge e) {
    nextE = e;
  }

  void setNextH(Edge e) {
    nextH = e;
  }

  void setTri(Triangle t) {
    inT = t;
  }

  void setInvE(Edge e) {
    invE = e;
  }

  Edge makeSymm() {
    Edge e = new Edge(p2, p1);
    rinkSymm(e);
    return e;
  }

  void rinkSymm(Edge e) {
    this.invE = e;
    if (e != null)
      e.invE = this;
  }

  public int onSide(Node nd) {
    float s = a * nd.x + b * nd.y + c;
    if (s > 0.0)
      return 1;
    if (s < 0.0)
      return -1;
    return 0;
  }

  void setAbc() // set parameters of a,b,c
  {
    a = p2.y - p1.y;
    b = p1.x - p2.x;
    c = p2.x * p1.y - p1.x * p2.y;
  }

  void asIndex() {
    p1.anEdge = this;
  }

  Edge mostLeft() {
    Edge ee, e = this;
    while ( (ee = e.nextE.nextE.invE) != null && ee != this)
      e = ee;
    return e.nextE.nextE;
  }

  Edge mostRight() {
    Edge ee, e = this;
    while (e.invE != null && (ee = e.invE.nextE) != this)
      e = ee;
    return e;
  }
}

