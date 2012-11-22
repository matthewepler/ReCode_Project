void setup() {

  size(800, 800);
  rectMode(CENTER);
  strokeWeight(2);
  // Create 36 crosses.
  Cross[] crosses;
  crosses = new Cross[36];
  translate(100, 300);

  //for every row...
  for (int r = 0; r<6; r++) {
    //for every column...
    for (int c = 0; c<6; c++) {
      pushMatrix();
      translate(80*c+r*40, -40*c + r*80);

      //rotate 180 degrees per column.
      rotate(PI* c);

      //rotate 90 degrees per row
      rotate(PI/2 * r);

      Cross newCross = new Cross(0, 0);
      newCross.display();
      popMatrix();
    }
  }
}

void draw() {
}

