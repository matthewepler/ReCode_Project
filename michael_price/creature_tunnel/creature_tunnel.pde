void setup() {
  size(512,512);
}

final float BASE_ANIMAL_SCALE = 100.0;
final float TUNNEL_RADIUS = 50;

void drawAnimal(float[][] pts) {
  beginShape();
  for(int i = 0; i < pts.length; i++) {
    vertex(BASE_ANIMAL_SCALE*pts[i][0] - BASE_ANIMAL_SCALE/2,
           BASE_ANIMAL_SCALE*pts[i][1] - BASE_ANIMAL_SCALE/2); 
  }
  endShape(CLOSE); 
}

void transformToTunnelPoint() {
   float theta, zz, r, dx, dy, tx, ty, tunneldist;
   do {
     theta = random(TWO_PI);
     // Bastardization of perspective transform.
     zz = random(5) + 1.0;
     r = height/2 + TUNNEL_RADIUS;
     dx = r * cos(theta) / zz;
     dy = r * sin(theta) / zz;
     tx = width/2 + dx;
     ty = height/2 + dy;
     tunneldist = sqrt(dx*dx + dy*dy);
     // Rejection sampling.
   } while (tunneldist < TUNNEL_RADIUS);
   
   translate(tx, ty);
   
   float persp = (tunneldist - TUNNEL_RADIUS + 25) / (height/2);
   // Persepective attentuation.
   float angle = atan2(dy, dx);
   rotate(angle);
   scale(min(1.0,persp*persp*persp*2), min(1.0,persp));
   rotate(-angle);
   
   // Random rotation.
   rotate(random(2*PI));
}

void draw() {
  background(0xffffff);
  fill(0,0,0,0);
  for (int i = 0; i < 300; i++) {
    pushMatrix();
     transformToTunnelPoint();
     drawAnimal(ANIMALS[floor(random(ANIMALS.length))]);
    popMatrix(); 
  }
  noLoop();
}
