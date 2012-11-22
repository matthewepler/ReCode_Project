class Square {
  
    int i, j, type;

    int tri_padding = 3;
    int tri_length = square_size-tri_padding;
    
    boolean top_open;
    boolean right_open;
    boolean bottom_open;
    boolean left_open;
  
  Square (int i_,  int j_) {
    
    i = i_;
    j = j_;

    //type = 0;
    //type = 1;
    // set the triange type - big or small
    type = int (random(2));
    
    // assign one side randonly to be blank
    // but match up two blank sides
    setRandomSide();

  }
  
  boolean checkRandomSide() {
   
    if(top_open || bottom_open || left_open || right_open) {
      return true;
    } else {
     return false; 
    }
    
  }
  
  void setRandomSide() {
    
    /// check if we are not on the first column
    if(i > 0) {
      
    // check if the square to the left has a space open to the right
    // if so then this square needs to open to the left
      
      if(squares[i-1][j].right_open) {
        
        left_open = true;
        
      }

    }
   
    if(j > 0) { // check if we are on the top row
    
    // check if the square to the above has a space open to the bottom
    // if so then this square needs to open to the top
      if(squares[i][j-1].bottom_open) {
        
        top_open = true;
        
      }
      
    }
     
    // check if we are not on the bottom row
    if(j < canvasheight-1 && !checkRandomSide() ) {
      bottom_open = generateRandom();
    }
    
    // check if we are not on far right column
    if( i < canvaswidth-1 && !checkRandomSide() ) {
      right_open = generateRandom();
    }
    
  }
  
  boolean generateRandom() {
    
    int R = int (random(1));
    
    if(R == 0) {
      return true; 
    } else {
      return true;
    }
    
  }
  
  void display() {
    
  switch(type) {
    case 0:
    
    // big triangles

    pushMatrix();
    
    translate((square_size*i) + square_size, (square_size*j) + square_size);
    
    if(int (random(2)) == 0) {
  
      if(left_open) {
        

        
        beginShape();
        
        vertex(0, tri_padding);
        vertex(tri_length - tri_padding, tri_padding);
        vertex(0, tri_length - 0);
        
        endShape();
        
      } else if(top_open) {
                
        // fixed        
        beginShape();
        

        
        vertex(tri_padding, 0);
        vertex(tri_padding, tri_length - tri_padding);
        vertex(tri_length-0, 0);
        
        endShape();
        
      } else if (right_open) {
        
        // no need
        beginShape();
       
        vertex(tri_padding, tri_padding);
        vertex(tri_length-tri_padding, tri_padding);
        vertex(tri_padding, tri_length-tri_padding);
        
        
        endShape(CLOSE);
       
      } else {
     

        
        beginShape();
        
        vertex(tri_padding, tri_padding);
        vertex(tri_length-tri_padding, tri_padding);
        vertex(tri_padding, tri_length-tri_padding);
        
        endShape(CLOSE);
      }
      

  
      if(bottom_open) {
        
        // fixed

        beginShape();
        
        vertex(tri_padding+0, tri_length+tri_padding);
        
        vertex(tri_length, tri_padding+tri_padding);
        vertex(tri_length, tri_length+tri_padding);
        
        endShape();

      } else if(right_open) {
        
      beginShape();
      
      //stroke(255,0,255);
      
      vertex(tri_length + tri_padding, tri_padding + 0);
      vertex(tri_padding + tri_padding, tri_length);
      vertex(tri_length + tri_padding, tri_length);
      
       
      endShape();      
        
      }else {
        
      beginShape();
      
      vertex(tri_length, tri_padding+tri_padding);
      vertex(tri_padding+tri_padding, tri_length);
      vertex(tri_length, tri_length);
        
        endShape(CLOSE);
      }
    
    } else {

      //

      if(left_open) {
        
        // fixed
        
        beginShape();
        
        vertex(0, tri_padding+0);
        vertex(tri_length-tri_padding, tri_length);
        vertex(0, tri_length);
          
        endShape();
        
      } else if(bottom_open) {
                
        // fixed
          
        beginShape();
        
        vertex(tri_padding, tri_length+tri_padding);
        
        vertex(tri_padding, tri_padding+tri_padding);
        vertex(tri_length, tri_length+tri_padding);
        
        endShape();
      
      } else if(right_open) {
        
        // no need
        
        beginShape();
        
        
        vertex(tri_padding, tri_length);
        
        vertex(tri_padding, tri_padding+tri_padding);
        vertex(tri_length-tri_padding, tri_length);

        endShape(CLOSE);
        
      } else {
        
        beginShape();
        
        vertex(tri_padding, tri_length);
        
        vertex(tri_padding, tri_padding+tri_padding);
        vertex(tri_length-tri_padding, tri_length);
      
        endShape(CLOSE);
      }
      
  
      //
      

  
      if(top_open) {
        
        beginShape();
  
        // fixed
      
        vertex(tri_padding, 0);
        vertex(tri_length, tri_length-tri_padding);
        vertex(tri_length, 0);
        
        endShape();
        
      } else if (right_open) {
        
        // fixed
        
        beginShape();
        
        vertex(tri_length + tri_padding, tri_length - 0);
        vertex(tri_padding+tri_padding, tri_padding);
        vertex(tri_length + tri_padding, tri_padding);
        
        endShape();
      
      } else {

        beginShape();
        
        vertex(tri_length, tri_length-tri_padding);
        vertex(tri_padding+tri_padding, tri_padding);
        vertex(tri_length, tri_padding);
        
        endShape(CLOSE);
        
        
      }

    }
    
    popMatrix();

    break;
  case 1:
  
    // little triangles
  
    pushMatrix();
    translate((square_size*i) + square_size, (square_size*j) + square_size);
    
      // top
      beginShape();
  
      if(top_open) {
        
        vertex(tri_padding, 0);
        vertex(square_size/2, (square_size/2) - tri_padding);
        vertex(tri_length, 0);
      
        endShape();
        
      } else {
        
        vertex(tri_padding+tri_padding, tri_padding);
        vertex(square_size/2, (square_size/2) - tri_padding);
        vertex(tri_length-tri_padding, tri_padding);
        
        endShape(CLOSE);
      }
      
      // right
      beginShape();
  
      if(right_open) {
        
      vertex(tri_length + tri_padding, tri_padding);
      vertex( (square_size/2) + tri_padding, square_size/2);
      vertex(tri_length + tri_padding, tri_length );
        
        endShape();
        
      } else {
        
      vertex(tri_length, tri_padding+tri_padding);
      vertex( (square_size/2) + tri_padding, square_size/2);
      vertex(tri_length, tri_length - tri_padding);
        
        endShape(CLOSE);
      }
      
      // bottom
      
      beginShape();

      if(bottom_open) {
        
        vertex(tri_padding, tri_length + tri_padding );
        
        vertex(square_size/2, (square_size/2) + tri_padding );
        vertex(tri_length, tri_length + tri_padding );
  
        endShape();
        
      } else {
        
        vertex(tri_padding+tri_padding, tri_length );
        
        vertex(square_size/2, (square_size/2) + tri_padding );
        vertex(tri_length-tri_padding, tri_length );
        
        endShape(CLOSE);
      }
      
      // left

  
      if(left_open) {
        
      beginShape();
      
      vertex(0, tri_padding );
      vertex( (square_size/2) - tri_padding, square_size/2);
      vertex(0, tri_length );
        
        endShape();
      } else {
        
      beginShape();
      
      vertex(tri_padding, tri_padding+tri_padding);
      vertex( (square_size/2) - tri_padding, square_size/2);
      vertex(tri_padding, tri_length - tri_padding);
        
        endShape(CLOSE);
      }
    
    
    popMatrix();

    break;
}
    
  }

} 
