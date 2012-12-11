/*
 * A port to Processing of 
 * <a href=http://www.geo.tu-freiberg.de/~apelm/>Marcus Appel</a>'s
 * 'Delaunay Triangulation' routines
 */
class Delaunay {

  public Delaunay(int num) {
    tris = new ArrayList();
    nodes = new ArrayList();
    edges = new ArrayList();
    for (int i = 0; i < num; i++)
      insert((int) random(width/4, width*.75), (int) random(height/4, height*.75));
  }

  public void clear() {
    nodes.clear();
    edges.clear();
    tris.clear();
  }

  public void insert(int px, int py) {
    int eid;
    Node nd = new Node(px, py);
    nodes.add(nd);
    if (nodes.size() < 3)
      return;
    if (nodes.size() == 3) // create the first tri
    {
      Node p1 = nodeAt(0), p2 = nodeAt(1), p3 = nodeAt(2);
      Edge e1 = new Edge(p1, p2);
      if (e1.onSide(p3) == 0) {
        nodes.remove(nd);
        return;
      }
      if (e1.onSide(p3) == -1) // right side
      {
        p1 = (Node) nodes.get(1);
        p2 = (Node) nodes.get(0);
        e1.updateEdge(p1, p2);
      }
      Edge e2 = new Edge(p2, p3), e3 = new Edge(p3, p1);
      e1.setNextH(e2);
      e2.setNextH(e3);
      e3.setNextH(e1);
      hullStart = e1;
      tris.add(new Triangle(edges, e1, e2, e3));
      return;
    }
    actE = (Edge) edges.get(0);
    if (actE.onSide(nd) == -1) {
      if (actE.invE == null)
        eid = -1;
      else
        eid = searchEdge(actE.invE, nd);
    } 
    else
      eid = searchEdge(actE, nd);
    if (eid == 0) {
      nodes.remove(nd);
      return;
    }
    if (eid > 0)
      expandTri(actE, nd, eid); // nd is inside or on a triangle
    else
      expandHull(nd); // nd is outside convex hull
  }

  public void delete(int px, int py) {

    if (nodes.size() <= 3) return; // not for single tri

    Node nd = nearest(px, py);
    if (nd == null)
      return; // not found
    nodes.remove(nd);
    Edge e, ee, start;
    start = e = nd.anEdge.mostRight();
    int nodetype = 0, idegree = -1;

    if (edges==null || index.length < edges.size())
      index = new Edge[(edges==null?0:edges.size()) + 100];

    while (nodetype == 0) {
      edges.remove(ee = e.nextE);
      index[++idegree] = ee;
      ee.asIndex();
      tris.remove(e.inT); // delete triangles involved
      edges.remove(e);
      edges.remove(ee.nextE);
      e = ee.nextE.invE; // next left edge
      if (e == null) nodetype = 2; // nd on convex hull
      if (e == start) nodetype = 1; // inner node
    }

    // generate new tris and add to triangulation
    int cur_i = 0, cur_n = 0;
    int last_n = idegree;
    Edge e1 = null, e2 = null, e3;
    while (last_n >= 1) {
      e1 = index[cur_i];
      e2 = index[cur_i + 1];
      if (last_n == 2 && nodetype == 1) {
        tris.add(new Triangle(edges, e1, e2, index[2]));
        swapTest(e1, e2, index[2]); // no varargs in pjs
        break;
      }
      if (last_n == 1 && nodetype == 1) {
        index[0].invE.rinkSymm(index[1].invE);
        index[0].invE.asIndex();
        index[1].invE.asIndex();
        swapTest(index[0].invE);
        break;
      }
      if (e1.onSide(e2.p2) == 1) // left side
      {
        e3 = new Edge(e2.p2, e1.p1);
        cur_i += 2;
        index[cur_n++] = e3.makeSymm();
        tris.add(new Triangle(edges, e1, e2, e3));
        swapTest(e1, e2);
      } 
      else
        index[cur_n++] = index[cur_i++];

      if (cur_i == last_n)
        index[cur_n++] = index[cur_i++];

      if (cur_i == last_n + 1) {
        if (last_n == cur_n - 1)
          break;
        last_n = cur_n - 1;
        cur_i = cur_n = 0;
      }
    }
    if (nodetype == 2) // reconstruct convex hull
    {
      index[last_n].invE.mostLeft().setNextH(hullStart = index[last_n].invE);
      for (int i = last_n; i > 0; i--) {
        index[i].invE.setNextH(index[i - 1].invE);
        index[i].invE.setInvE(null);
      }
      index[0].invE.setNextH(start.nextH);
      index[0].invE.setInvE(null);
    }
  }

  void expandTri(Edge e, Node nd, int type) {
    Edge e1 = e, e2 = e1.nextE, e3 = e2.nextE;
    Node p1 = e1.p1, p2 = e2.p1, p3 = e3.p1;

    if (type == 2) {// nd is inside of the triangle

      Edge e10 = new Edge(p1, nd), e20 = new Edge(p2, nd), e30 = new Edge(p3, nd);
      e.inT.removeEdges(edges);
      tris.remove(e.inT); // remove old triangle
      tris.add(new Triangle(edges, e1, e20, e10.makeSymm()));
      tris.add(new Triangle(edges, e2, e30, e20.makeSymm()));
      tris.add(new Triangle(edges, e3, e10, e30.makeSymm()));
      swapTest(e1, e2, e3); // swap test for the three new triangles
    } 
    else {// nd is on the edge e

        Edge e4 = e1.invE;
      if (e4 == null || e4.inT == null) // one triangle involved
      {
        Edge e30 = new Edge(p3, nd), e02 = new Edge(nd, p2), 
        e10 = new Edge(p1, nd), e03 = e30.makeSymm();
        e10.asIndex();
        e1.mostLeft().setNextH(e10);
        e10.setNextH(e02);
        e02.setNextH(e1.nextH);
        hullStart = e02;
        tris.remove(e1.inT); // remove oldtriangle 
        edges.remove(e1);
        edges.add(e10);// add two new triangles
        edges.add(e02);
        edges.add(e30);
        edges.add(e03);
        tris.add(new Triangle(e2, e30, e02));
        tris.add(new Triangle(e3, e10, e03));
        swapTest(e2, e3, e30); // swap test for the two new triangles
      } 
      else // two triangle involved
      {
        Edge e5 = e4.nextE, e6 = e5.nextE;
        Node p4 = e6.p1;
        Edge e10 = new Edge(p1, nd), e20 = new Edge(p2, nd), 
        e30 = new Edge(p3, nd), e40 = new Edge(p4, nd);
        tris.remove(e.inT); // remove oldtriangle
        e.inT.removeEdges(edges);
        tris.remove(e4.inT); // remove old triangle
        e4.inT.removeEdges(edges);
        e5.asIndex();
        e2.asIndex();
        tris.add(new Triangle(edges, e2, e30, e20.makeSymm()));
        tris.add(new Triangle(edges, e3, e10, e30.makeSymm()));
        tris.add(new Triangle(edges, e5, e40, e10.makeSymm()));
        tris.add(new Triangle(edges, e6, e20, e40.makeSymm()));
        swapTest(e2, e3, e5, e6, e10, e20, e30, e40); // no varargs in pjs
      }
    }
  }

  void expandHull(Node nd) {
    Edge e1, e2, e3 = null, enext, e = hullStart, comedge = null, lastbe = null;
    while (true) {
      enext = e.nextH;
      if (e.onSide(nd) == -1) // right side
      {
        if (lastbe != null) {
          e1 = e.makeSymm();
          e2 = new Edge(e.p1, nd);
          e3 = new Edge(nd, e.p2);
          if (comedge == null) {
            hullStart = lastbe;
            lastbe.setNextH(e2);
            lastbe = e2;
          } 
          else
            comedge.rinkSymm(e2);
          comedge = e3;
          tris.add(new Triangle(edges, e1, e2, e3));
          swapTest(e);
        }
      } 
      else {
        if (comedge != null) break;
        lastbe = e;
      }
      e = enext;
    }

    lastbe.setNextH(e3);
    e3.setNextH(e);
  }

  int searchEdge(Edge e, Node nd) {
    int f2, f3;
    Edge e0 = null;
    if ((f2 = e.nextE.onSide(nd)) == -1) {
      if (e.nextE.invE != null)
        return searchEdge(e.nextE.invE, nd);
      else {
        actE = e;
        return -1;
      }
    }
    if (f2 == 0)
      e0 = e.nextE;
    Edge ee = e.nextE;
    if ((f3 = ee.nextE.onSide(nd)) == -1) {
      if (ee.nextE.invE != null)
        return searchEdge(ee.nextE.invE, nd);
      else {
        actE = ee.nextE;
        return -1;
      }
    }
    if (f3 == 0)
      e0 = ee.nextE;
    if (e.onSide(nd) == 0)
      e0 = e;
    if (e0 != null) {
      actE = e0;
      if (e0.nextE.onSide(nd) == 0) {
        actE = e0.nextE;
        return 0;
      }
      if (e0.nextE.nextE.onSide(nd) == 0)
        return 0;
      return 1;
    }
    actE = ee;
    return 2;
  }

  void swapTest(Edge ... e) {
    for (int i = 0; i < e.length; i++)
      swapTest(e[i]);
  }

  void swapTest(Edge e) {
    Edge e21 = e.invE;
    if (e21 == null || e21.inT == null)
      return;
    Edge e12 = e.nextE, e13 = e12.nextE, e22 = e21.nextE, e23 = e22.nextE;
    if (e.inT.inCircle(e22.p2) || e21.inT.inCircle(e12.p2)) {
      e.updateEdge(e22.p2, e12.p2);
      e21.updateEdge(e12.p2, e22.p2);
      e.rinkSymm(e21);
      e13.inT.updateTriangle(e13, e22, e);
      e23.inT.updateTriangle(e23, e12, e21);
      e12.asIndex();
      e22.asIndex();
      swapTest(e12);
      swapTest(e22);
      swapTest(e13);
      swapTest(e23);
    }
  }

  Node nearest(float x, float y) {
    // locate a node nearest to (px,py)
    float dismin = 0.0f, s;
    Node nd = null;
    for (int i = 0; i < nodes.size(); i++) {
      s = ((Node) nodes.get(i)).distance(x, y);
      if (s < dismin || nd == null) {
        dismin = s;
        nd = (Node) nodes.get(i);
      }
    }
    return nd;
  }
}

class Node {
  int x, y;
  Edge anEdge; // an edge which start from this node

    public Node(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public float distance(float px, float py) {
    return dist(x, y, px, py);
  }
}

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

