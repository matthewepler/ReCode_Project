/*
 translation notes:
 * BASIC uses 1-indexed arrays, Java uses 0-indexed arrays
 * lines with  //? have no corollary in this environment
 * with a few exceptions, there is no decorative whitespace in the original code
 * RANF(0) corresponds to random(1)
 * the HYPLT plotter interface is replaced with beginShape/endShape helper functions
*/

void rosetta() {
  // ******************PROGRAMMED FOR COMPUTER GRAPHICS AND ART BY BILL KULOMYJEC
  float[][]
    A = new float[4][2],
    B = new float[4][2],
    AA = new float[4][2],
    BB = new float[4][2];
  // PROVIDE MEMORY FOR 2 SETS OF SQUARES, RANDOMIZE
  randomSeed(0); //CALL RANST
  // DEFINE VARIABLES
  int NUMX=5;
  int NUMY=7;
  // BSS=THE SIZE OF THE SIDE OF THE SQUARE, SSPCT=THE PERCENT
  // OF THE SIZE OF THE INSIDE SQUARE
  float BSS=1.25;
  float SSPCT=0.20;
  float HFBSS=BSS/2.0;
  // VLIMIT IS THE MAXIMUM AMOUNT THE INNER SQUARE MAY VARY
  float VLIMT=HFBSS-(BSS*SSPCT/2.0);
  // SET UP CORNERS OF BIG SQUARE
  A[0][0]= HFBSS;
  A[0][1]= HFBSS;
  A[1][0]=-HFBSS;
  A[1][1]= HFBSS;
  A[2][0]=-HFBSS;
  A[2][1]=-HFBSS;
  A[3][0]= HFBSS;
  A[3][1]=-HFBSS;
  // SCALE DOWN SMALL SQUARE BY SSPCT
  for(int J=0;J<4;J++) {
    for(int K=0;K<2;K++) {
      B[J][K]=A[J][K]*SSPCT;
    }
  }
  // INITIALIZE PLOTTER
  HYPLT(0.,0.,0);
  // BEGIN DRAWING RANDOM SQUARE MODULES
  for(int J=0;J<NUMY;J++) {
    float YC=float(J)*BSS;
    for(int K=0;K<NUMX;K++) {
      float XC=float(K)*BSS;
      // ADJUST OUTER SQUARE TO RELATIVE LOCATION
      for(int L=0;L<4;L++) {
        AA[L][0]=A[L][0]+XC;
        AA[L][1]=A[L][1]+YC;
      }
      // DETERMINE X AND Y VARIANCE BASED ON VLIMT
      float XVAR=random(1)*VLIMT-(VLIMT/2.0);
      float YVAR=random(1)*VLIMT-(VLIMT/2.0);
      // ADJUST INNER SQUARE TO RELATIVE LOCATION, ADD VARIANCE
      for(int M=0;M<4;M++) {
        BB[M][0]=B[M][0]+XVAR+XC;
        BB[M][1]=B[M][1]+YVAR+YC;
      }
      // DETERMINE RANDOM NUMBER OF INTERVALS (BETWEEN 2 AND 10)
      int NSPCS=int(9*random(1)+2);
      // PLOT EACH MODULE
      for(int N=0;N<NSPCS;N++) {
        // P CALCULATES RELATIVE SPACING ON NSPCS
        float P=float(N)/(NSPCS-1);
        float X=AA[3][0]+P*(BB[3][0]-AA[3][0]);
        float Y=AA[3][1]+P*(BB[3][1]-AA[3][1]);
        // MOVE THE PEN TO THE LAST CORNER OF THE SQUARE
        HYPLT(X,Y,2);
        // PLOT INTERMEDIATE SQUARES
        for(int I=0;I<4;I++) {
          X=AA[I][0]+P*(BB[I][0]-AA[I][0]);
          Y=AA[I][1]+P*(BB[I][1]-AA[I][1]);
          HYPLT(X,Y,1);
        }
      }
    }
  }
  // TERMINATE
  HYPLT(0.,0.,-1);
  // CALL EXIT //?
  // END //?
}

// HYPLT implementation with beginShape/endShape
int plotterState = UP;
void penDown() {
  if(plotterState == UP) {
    noFill();
    beginShape();
    plotterState = DOWN;
  }
}
void penUp() {
  if(plotterState == DOWN) {
    endShape(CLOSE);
    plotterState = UP;
  }
}
void penMove(float x, float y) {
  vertex(x,y);
}
void HYPLT(float x, float y, int mode) {
  if(mode == -1) { // finish
    penUp();
  } else if(mode == 0) { // initialize
    strokeWeight(0);
    noSmooth();
    // original used the range (-0.625, -0.625) to (5.625, 8.15)
    // perhaps in or cm? we use 80x zoom to convert to pixels.
    scale(80, 80);
    translate(.625,.625);
  } else if(mode == 1) { // down + move
    penDown();
    penMove(x, y);
  } else if(mode == 2) { // close/up
    penUp();
  }
}
