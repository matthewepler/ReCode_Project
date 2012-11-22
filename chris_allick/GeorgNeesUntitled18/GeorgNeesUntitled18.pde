           int radius = 150;
            int min, max;

            void setup() {
              size( 600, 600 );
              background( 255 );
              stroke( 0 );
              noFill();
              strokeWeight( 2 );
              min = 100;
              max = 300;
              drawCircles();
            }

            void draw() {}

            void drawCircles() {
             background( 255 );
             
             for( int r = 0; r < 2; r++ ) {
               for( int c = 0; c < 2; c++ ) {
                  pushMatrix();
                    translate( 150+(300*r), 150+(300*c));
                    //ellipse( 0, 0, 300, 300 );
                    for( int i = 0; i < (int)random(min,max); i++ ) {
                      float a = random(0, TWO_PI);
                      float x1 = radius*cos(a);
                      float y1 = radius*sin(a);
                      a = random(0, TWO_PI);
                      float x2 = radius*cos(a);
                      float y2 = radius*sin(a);
                    
                      line( x1, y1, x2, y2);
                    }
                  popMatrix();
               }
             }
            }

            void mousePressed() {
              drawCircles();
            }
