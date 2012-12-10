class Triangle {
  
  Edge anEdge; // edge of this triangle
  float c_cx, c_cy, c_r;

  public Triangle(Edge e1, Edge e2, Edge e3) {
    updateTriangle(e1, e2, e3);
  }

  public Triangle(ArrayList edges, Edge e1, Edge e2, Edge e3) {
    updateTriangle(e1, e2, e3);
    edges.add(e1);
    edges.add(e2);
    edges.add(e3);
  }

  public void updateTriangle(Edge e1, Edge e2, Edge e3) {
    anEdge = e1;
    e1.setNextE(e2);
    e2.setNextE(e3);
    e3.setNextE(e1);
    e1.setTri(this);
    e2.setTri(this);
    e3.setTri(this);
    findCircle();
  }

  boolean inCircle(Node nd) {
    return nd.distance(c_cx, c_cy) < c_r;
  }

  void removeEdges(ArrayList edges) {
    edges.remove(anEdge);
    edges.remove(anEdge.nextE);
    edges.remove(anEdge.nextE.nextE);
  }

  void findCircle() {
    float x1 = anEdge.p1.x, y1 = anEdge.p1.y, x2 = anEdge.p2.x, y2 = anEdge.p2.y;
    float x3 = anEdge.nextE.p2.x, y3 = anEdge.nextE.p2.y;
    float a = (y2 - y3) * (x2 - x1) - (y2 - y1) * (x2 - x3);
    float a1 = (x1 + x2) * (x2 - x1) + (y2 - y1) * (y1 + y2);
    float a2 = (x2 + x3) * (x2 - x3) + (y2 - y3) * (y2 + y3);
    c_cx = (a1 * (y2 - y3) - a2 * (y2 - y1)) / a / 2;
    c_cy = (a2 * (x2 - x1) - a1 * (x2 - x3)) / a / 2;
    c_r = anEdge.p1.distance(c_cx, c_cy);
  }
}

