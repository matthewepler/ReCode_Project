/*
 methods:
 1. vernacular
   preserve the spirit of the image
   least work
   but the influence of the original tool is lost
 2. rosetta
   preserve the spirit of the code itself
   connects old languages to new languages
 3. revival
   write a parser to run the original code
   most work
   preserves everything but the output medium (plotter)
*/

/*
// JOB
// FOR RDMSQ
*NONPROCESS PROGRAM
*ONE WORD INTEGERS
*LIST SOURCE PROGRAM
*INCS(CARD,1443 PRINTER)
C******************PROGRAMMED FOR COMPUTER GRAPHICS AND ART BY BILL KULOMYJEC
      DIMENSION A(4,2),B(4,2),AA(4,2),BB(4,2)
C                  PROVIDE MEMORY FOR 2 SETS OF SQUARES, RANDOMIZE
      CALL RANST
C                  DEFINE VARIABLES
      NUMX=5
      NUMY=7
C                  BSS=THE SIZE OF THE SIDE OF THE SQUARE, SSPCT=THE PERCENT
C                  OF THE SIZE OF THE INSIDE SQUARE
      BSS=1.25
      SSPCT=0.20
      HFBSS=BSS/2.0
C                  VLIMIT IS THE MAXIMUM AMOUNT THE INNER SQUARE MAY VARY
      VLIMT=HFBSS-(BSS*SSPCT/2.0)
C                  SET UP CORNERS OF BIG SQUARE
      A(1,1)= HFBSS
      A(1,2)= HFBSS
      A(2,1)=-HFBSS
      A(2,2)= HFBSS
      A(3,1)=-HFBSS
      A(3,2)=-HFBSS
      A(4,1)= HFBSS
      A(4,2)=-HFBSS
C                  SCALE DOWN SMALL SQUARE BY SSPCT
      DO 100 J=1,4
      DO 100 K=1,2
  100 B(J,K)=A(J,K)*SSPCT
C                  INITIALIZE PLOTTER
      CALL HYPLT (0.,0.,0)
C                  BEGIN DRAWING RANDOM SQUARE MODULES
      DO 200 J=1,NUMY
      YC=FLOAT(J-1)*BSS
      DO 200 K=1,NUMX
      XC=FLOAT(K-1)*BSS
C                  ADJUST OUTER SQUARE TO RELATIVE LOCATION
      DO 201  L=1,4
      AA(L,1)=A(L,1)+XC
      AA(L,2)=A(L,2)+YC
  201 CONTINUE
C                  DETERMINE X AND Y VARIANCE BASED ON VLIMT
      XVAR=RANF(0)*VLIMT-(VLIMT/2.0)
      YVAR=RANF(0)*VLIMT-(VLIMT/2.0)
C                  ADJUST INNER SQUARE TO RELATIVE LOCATION, ADD VARIANCE
      DO 202 M=1,4
      BB(M,1)=B(M,1)+XVAR+XC
      BB(M,2)=B(M,2)+YVAR+YC
  202 CONTINUE
C                  DETERMINE RANDOM NUMBER OF INTERVALS (BETWEEN 2 AND 10)
      NSPCS=9*RANF(D)+2
C                  PLOT EACH MODULE
      DO 203 N=1,NSPCS
C                  P CALCULATES RELATIVE SPACING ON NSPCS
      P=FLOAT(N-1)/(NSPCS-1)
      X=AA(4,1)+P*(BB(4,1)-AA(4,1))
      Y=AA(4,2)+P*(BB(4,2)-AA(4,2))
C                  MOVE THE PEN TO THE LAST CORNER OF THE SQUARE
      CALL HYPLT (X,Y,2)
C                  PLOT INTERMEDIATE SQUARES
      DO 300 I=1,4
      X=AA(I,1)+P*(BB(I,1)-AA(I,1))
      Y=AA(I,2)+P*(BB(I,2)-AA(I,2))
  300 CALL HYPLT (X,Y,1)
  203 CONTINUE
  200 CONTINUE
C                  TERMINATE
      CALL HYPLT (0.,0.,-1)
      CALL EXIT
      END

FEATURES SUPPORTED
 NONPROCESS
 ONE WORD INTEGERS
 INCS

CORE REQUIREMENTS FOR RDMSQ
 COMMON    O  INSKEL COMMON    0  VARIABLES    110  PROGRAM    444
*/

void setup() {
  size(500, 700);
  background(255);
  noLoop();
}

void draw() {
  //vernacular();
  rosetta();
}
