void tile(int col, int row, int maxLines, int reducer) {
  
  pushMatrix();
  translate(col * n * tileSize, row * n * tileSize);
  
  for (int i = 0; i < numTiles; i++) {
    int c = i % n;
    int r = i / n;
    
    int numLines = maxLines - (reducer * max(abs(r - centerTile), abs(c - centerTile)));
    
    pushMatrix();
    translate(c * tileSize, r * tileSize);
    drawLines(numLines);
    
    popMatrix();
  }
  
  popMatrix();
  
}
