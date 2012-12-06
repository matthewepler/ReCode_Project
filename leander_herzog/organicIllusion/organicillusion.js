
// This sketch is part of the ReCode Project - http://recodeproject.com
// From Computer Graphics and Art vol2 no3 pg 13
// "Organic Illusion"
// by William Kolomyjec
//
// Leander Herzog
// 2012
// Creative Commons license CC BY-SA 3.0

var things = [];

var Thing = Base.extend({
  initialize: function(point ) {
    this.res=Math.round(unit*0.1*2), this.flex=180;
    this.offset=r(-this.flex, this.flex);
    this.nextoffset=r(-this.flex, this.flex);
    this.angle=0, this.radius=unit*0.25;
    this.start=new Point(),this.end=new Point();
    this.shift= new Point(),this.newshift= new Point();
    this.dir=new Point(),this.tmp= new Point();
    this.paths=[];
    this.m=Math.round(unit*0.1);
    this.n=new Point(i*unit,j*unit);
    this.createPaths();
  },
    createPaths: function() {
      this.shift=new Point(Math.random()*unit*0.4-unit*0.2, Math.random()*unit*0.4-unit*0.2);
      this.dir=new Point(this.m,0);
      for (var k=0;k<this.res; k++) {
        this.angle=(map(k, 0, this.res, 0,360)+this.offset)/180*Math.PI;
        this.start.set(this.n.x+unit*0.5+this.shift.x+Math.sin(this.angle)*this.radius,this.n.y+unit*0.5+this.shift.y+Math.cos(this.angle)*this.radius);
        this.end.set(this.n.x+this.tmp.x, this.n.y+this.tmp.y);
        this.tmp+=this.dir;
        if (k+1==this.res/4) this.dir.set(0, this.m);else if (k+1==this.res/2) this.dir.set(-this.m, 0);else if (k+1==this.res/4*3) this.dir.set(0, -this.m);
        this.path = new Path.Line(this.start,this.end); // draw line form inner circle to outer rectangle
        this.path.strokeColor = 'black';
        this.paths[k]=this.path;
      }
    },
    iterate: function() {
      this.offset+=(this.nextoffset-this.offset)/10.0;// interpolation
      this.shift.x+=(this.newshift.x-this.shift.x)/10.0;// interpolation
      this.shift.y+=(this.newshift.y-this.shift.y)/10.0;// interpolation
      for (var k=0;k<this.res; k++) {
        this.angle=(map(k, 0, this.res, -180,180)+this.offset)/180*Math.PI;// update angle
        this.start.set(this.n.x+unit*0.5+this.shift.x+Math.sin(this.angle)*this.radius,this.n.y+unit*0.5+this.shift.y+Math.cos(this.angle)*this.radius);
        this.paths[k].firstSegment.point=this.start;// update inner points
      }
    },
    moveit: function() {
      this.nextoffset=r(-this.flex*5, this.flex*5);// new rotation for animation
      this.newshift=new Point(Math.random()*unit*0.4-unit*0.2, Math.random()*unit*0.4-unit*0.2);// new random offset for center
    }
});

function onFrame() { for (var i = 0, l = things.length; i < l; i++)things[i].iterate(); }
function onMouseDown(event) { for (var i = 0, l = things.length; i < l; i++)things[i].moveit(); }
function map(value, low1, high1, low2, high2) { return low2 + (high2 - low2) * (value - low1) / (high1 - low1); }
function r(to,from){ return Math.random()*to-from; }
var unit=200,rows=Math.ceil(view.viewSize._height/unit), columns=Math.ceil(view.viewSize._width/unit),one,two, shift, res, radius,tmp,n,dir;
for (var i=0;i<columns;i++) {
  for (var j=0;j<rows;j++) {
    vector = ( i*unit, j*unit),
      things.push(new Thing(vector));
  }
}


