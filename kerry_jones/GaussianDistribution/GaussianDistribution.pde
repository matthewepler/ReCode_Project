/* ******************************************
 *
 * Name.......:  GaussianDistribution.pde
 * Project....:  This sketch is part of the ReCode Project - http://recodeproject.com
 * Based on...:  «Gaussian Distribution» by Kerry Jones – 1976
 * As seen in.:  Computer Graphics and Art – May, 1977 – Vol. 2, No. 2 – Pg 33
 * Author.....:  Stefan Huber (initial commit)
 * Contact....:  sh{at}signalwerk[dot]ch
 * Version....:  1.0.0
 * Date.......:  2012-12-03
 * Comment....:  Please be aware of the fact that the smoothing and resolution 
 *               of the sketch has a huge impact on the look of the rendering. 
 *               I tried to optimize the view to 900px width. All other parameters 
 *               are based on the width. So if you change to an other 
 *               resolution it will also change the point count an the height.
 * Code.......:  Java with (some) Javadoc comments – four Space Indentation 
 * Environment:  Processing 2.0b6 (Java) – Mac OS X
 * Alternative:  If you would like to run this sketch with processing.js do a sed:
 *
 *               # -r flag with GNU sed, -E flag with BSD/MacOSX sed
 *               # depending on your sed write all between the two '' in one line
 *               sed -E '
 *               s/private double /function /g;
 *               s/private void /function /g;
 *               s/private static final //g;
 *               s/\(double\)//g;
 *               s/double /var /g;
 *               s/screenW, screenH/900, 400/g;
 *               ' GaussianDistribution.pde > GaussianDistribution.js
 *
 * License....:  You may use this work under the terms of either the 
 *               MIT License (http://opensource.org/licenses/MIT) or the
 *               GNU General Public License (GPL) Version 3 
 *               (http://opensource.org/licenses/GPL-3.0)
 * Keywords...:  gaussian, distribution, random, processing, kerry, jones, recode
 * Inspiration:  http://www.colingodsey.com/javascript-gaussian-random-number-generator/
 *               http://www.dreamincode.net/code/snippet1446.htm
 * History....:  2012-12-03 c1.0.0 - first public release
 * 
 * ********************************************/


// define some fixtures with the abbility for the compiler to precalculate them
private static final int   screenW       = 900;                     // the width of the sketch
private static final int   screenH       = Math.round(screenW*4/9); // the height of the sketch
private static final float outOfCenter   = 1.3;                     // the original stripe doesn't seem to be centered
private static final float gaussianRange = 1.2;                     // to stretch the stripe a bit in height
private static final int   dotCount      = screenW*screenH/14;      // the count of dots
private static final float dotSize       = screenW/230;             // size of the dot


/**
 * The Function to draw the dot. 
 * I took dots but the original might be rect. hard to say from the scann
 *
 * @param centerX  The x-Position of the center of the dot
 * @param centerY  The y-Position of the center of the dot
 */ 
private void doPoint(float centerX, float centerY) {
    // rect implementation:
    // rect(centerX-(dotSize/2), centerY-(dotSize/2) , dotSize, dotSize);
    // circle implementation:
    ellipse(centerX, centerY , dotSize, dotSize);
}


/**
 * General setup for processing
 * In the JavaScript-Version (processing.js) the size of the canvas is hardcoded
 * @see #screenW
 * @see #screenH
 */ 
void setup()
{
    size(screenW, screenH);
    smooth(4); // try to smooth the little dots
    noStroke();
    noLoop();
    fill(0);
}


/**
 * General draw for processing (no loop)
 * @see #setup()
 */ 
void draw()
{
    // position of the current point
    float posX, posY;
    
    // set the background
    background(255);
    
    // draw the points
    for (int i = 0; i < dotCount; i++) {
        posX = random(0, screenW); // bleeding canvas
        posY = ((float)getGaussian() * (float)screenH * gaussianRange) / 8.0; // the height (range) of the gaussian strip
        posY += (screenH/outOfCenter/2); // to adjust the position of the strip
        doPoint(posX,posY); // call the function to draw the element
    }
}


/**
 * We could have use the gaussian of Java with Random.nextGaussian()
 * but processing.js people would find it hard to use it then
 * for this gaussian implementation see:
 * http://www.colingodsey.com/javascript-gaussian-random-number-generator/
 * @return   return a double between -4 and +4
 */
private double getGaussian() {
    double u,v,r;
    
    u = ((double)Math.random()) * (double)2.0 - (double)1.0;
    v = ((double)Math.random()) * (double)2.0 - (double)1.0;
    r = u * u + v * v;
    
    if (r == 0 || r > 1) {
        return getGaussian();
    }
    double c = Math.sqrt((double)-2.0 * Math.log(r) / r);
    return u * c;
}