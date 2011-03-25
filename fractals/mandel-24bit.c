#define GAMUT 0xFFFFFF
#include <stdio.h>
#include <stdlib.h>

/* 24 bit color Mandelbrot plotter
 * Author: Lindsay Gaff
 * Date: July 18, 2008
 * Draws a mandelbrot graph in X PixMap format 
 * of user specified size using the escape-time algorithm.
 * The algorithm iteratively computes complex numbers based
 * on the x/y co-ordinates of the current pixel, using the
 * result of the previous iteration as a starting value
 * for the next. It iterates until either the complex number
 * reaches a threshold value, or the maximum number of iterations
 * is reached. Upon either of these happening, the pixel is assigned
 * the color corresponding to the number of iterations reached, and is
 * 'drawn', as an 8 byte integer representing the chosen color.
 */

int result;
int iterations = 0;
int x,y;
double a, b, u, v = 0.0;
double x0, y0 = 0.0;
double valthresh = 0.0;
int main(int argc, char *argv[]) {
  if (argc != 7) {
    printf("Usage mandel iterations zoom xres yres xthresh ythresh %d\n", argc);
    return 0;
  }
  int max = atol(*(argv+1));
  int zoom = atoi(*(argv+2));
  int xres = atoi(*(argv+3));
  int yres = atoi(*(argv+4));
  double xthresh = atof(*(argv+5));
  double ythresh = atof(*(argv+6));
  printf("/* XPM */\nstatic char * mandel_xpm[] = { \n");
  printf("\"%d %d %d 8\", \n", xres, yres, max);
  int cc;
  int gap = (GAMUT / max); /* gap indicates the number of colors to skip
                            * when writing the palette. ensures we get an
                            * even distribution of color across the full
                            * gamut, and only write out as many as we actually
                            * need. */
  /* Print the header info for the xpm format */
  for(cc=(GAMUT-(GAMUT%max))-gap;cc>=0;cc = cc - gap) {
    printf("\"%08d  c #%06x\",\n",cc, cc);
  }

  /* Begin drawing pixels */
  for (y = 0;y < yres;y++) { // columns
    printf("\"");
    for (x = 0;x < xres;x++) { // rows
      u = x/((float)xres/2)-xthresh;
      v = y/((float)yres/2)-ythresh;
      x0 = u;
      y0 = v;
      a = 0.0;
      b = 0.0;
      /* Begin determining whether pixel is in the set or not */
      for(iterations = (GAMUT-(GAMUT%max));iterations >= 0;iterations = iterations - gap) {
        a = x0*x0;
        b = y0*y0;
        y0 = 2 * x0 * y0 + v;
        x0 = a - b + u;
        if (a + b > 4.0) {
          break; // pixel is not in the set.
        }
      }
      if (iterations < 0) { // pixel is 'probably' in the set, and should therefore be black.
        iterations = 0x00000000; // this helps to avoid any issues with negative color values.
      } 
      printf("%08d", iterations); // plot pixel
    }
    printf("\",\n"); //EOL
  }
  printf("};");
  return 1;
}
