#include <stdio.h>
#include <stdlib.h>

int result;
int iterations = 0;
int x,y;
double a, b, u, v = 0.0;
double x0, y0 = 0.0;
double valthresh = 0.0;
int main(int argc, char *argv[]) {
  if (argc != 7) {
    printf("Usage mandel iterations xres yres xthresh ythresh %d\n", argc);
    return 0;
  }
  long max = atol(*(argv+1));
  int zoom = atoi(*(argv+2));
  int xres = atoi(*(argv+3));
  int yres = atoi(*(argv+4));
  double xthresh = atof(*(argv+5));
  double ythresh = atof(*(argv+6));
  printf("/* XPM */\nstatic char * mandel_xpm[] = { \n");
  printf("\"%d %d 50 1\", \n", xres, yres);
  int cc;
  int red = 0xFF0000;
  int green = 0x100000;
  for(cc=0;cc<48;cc++) {
    printf("\"%c  c #%06x\",\n", cc+40,red);
    red -= green;
    if (cc == 15) {
      red = 0x00FF00;
      green >>= 8;
    }
    if (cc == 31) {
      red = 0x0000FF;
      green >>= 8;
    }
  }
  printf("\"%c c #000007\",\n", 88);
  printf("\"%c c #000000\",\n", 89);
    
  for (y = 0;y < yres;y++) {
    printf("\"");
    for (x = 0;x < xres;x++) {
      u = x/((float)xres*zoom)-xthresh;
      v = y/((float)yres*zoom)-ythresh;
      x0 = u;
      y0 = v;
      iterations = 0;
      result = 40;
      valthresh = ((max/100)*2 );
      a = 0.0;
      b = 0.0;
      while (a + b < 4.0 && iterations < max) {
        if (iterations > valthresh) {
          result = result + 1;
          valthresh = valthresh + ((max/100)*2);
        }
        a = x0*x0;
        b = y0*y0;
        y0 = 2 * x0 * y0 + v;
        x0 = a - b + u;
        iterations++;
      }
      if (iterations == max) {
        result = 89;
      }
      printf("%c", result);
    }
    printf("\",\n");
  }
  printf("};");
  return 1;
}
