void vernacular() {
  rectMode(CENTER);
  noFill();
  float side = 100;
  for(int y = 0; y < 7; y++) {
    for(int x = 0; x < 5; x++) {
      int n = int(random(2, 11));
      float ox = random(side / 2) + side / 4;
      float oy = random(side / 2) + side / 4;
      for(int i = 0; i < n; i++) {
        float curSide = map(i, 0, n - 1, .2, 1) * side;
        float cx = x * side + map(i, 0, n - 1, ox, side / 2);
        float cy = y * side + map(i, 0, n - 1, oy, side / 2);
        rect(cx, cy, curSide, curSide);
      }
    }
  }
}
