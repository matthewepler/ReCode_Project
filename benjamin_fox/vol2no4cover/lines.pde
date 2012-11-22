void drawLines(int l) {
  //lets randomise the order of lines to draw
  Collections.shuffle(lines);
  
  for (int j = 0; j < l; j++) {
    
    int i = (Integer) lines.get(j);
  
    switch (i) {
      case 1:
        line(0, 0, tileSize, tileSize);
        break;
      case 2:
        line(0, tileSize, tileSize, 0);
        break;
      case 3:
        line(0, tileSize/2, tileSize, tileSize/2);
        break;
      case 4:
        line(tileSize/2, 0, tileSize/2, tileSize);
        break;
      case 5:
        line(0, tileSize/2, tileSize/2, 0);
        break;
      case 6:
        line(tileSize/2, 0, tileSize, tileSize/2);
        break;
      case 7:
        line(tileSize, tileSize/2, tileSize/2, tileSize);
        break;
      case 8:
        line(tileSize/2, tileSize, 0, tileSize/2);
        break;
    }
  }
}
