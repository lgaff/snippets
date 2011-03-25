#include <ncurses.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include "shapes.h"


struct timespec delay = {0, 300000000};
struct timespec delayrem;
WINDOW *create_win(int height, int width, int starty, int startx);
int choosepiece();
void drawpiece(WINDOW *win, int shape[], int offset, int posy, int posx);
int main() {
  int ch;
  int rot;
  int current_piece;
  int next_piece;
  int pchoose;
  int posx, posy;
  WINDOW *score_panel;
  WINDOW *play_area;
  initscr();
  cbreak();
  noecho();
  keypad(stdscr, TRUE);
  refresh();
  timeout(0);
  if ((COLS < 80) || (LINES < 25)) {
    endwin();
    printf("Your terminal isn't big enough slim :) (Needs to be 80*25, yours is %d*%d)\n", COLS, LINES);
    return 1;
  }
  score_panel = create_win(25, 20, 0, 60);
  play_area = create_win(25, 60, 0, 0);
  pchoose = choosepiece();
  rot = 0;
  next_piece = pchoose + rot;
  werase(score_panel);
  box(score_panel, 0, 0);
  drawpiece(score_panel, shapes, next_piece, 5, 5);
  wrefresh(score_panel);
  wrefresh(play_area);
  while(1) {
    werase(score_panel);
    box(score_panel, 0, 0);
    drawpiece(score_panel, shapes, next_piece, 5, 5);
    posx = 30;
    posy = 2;
    pchoose = choosepiece();
    current_piece = next_piece + rot;
    next_piece = pchoose;
    while (posy <= 20) { //this'll need changing later when you implement the line algo
    nanosleep(&delay, &delayrem);
    ch = getch();
    while(getch() != ERR);  
    switch (ch) {
        case KEY_LEFT:
         posx -= 1;
          break;
        case KEY_RIGHT:
          posx += 1;
          break;
        case KEY_UP:
          rot += 6;
          rot = rot % 24;
          break;
        case KEY_DOWN:
          break;
        case 113:
          endwin();
          return 0;
          break;
        default:
          break;
      }
      posy++;
      werase(play_area);
      drawpiece(play_area, shapes, current_piece+rot, posy, posx);
      wrefresh(play_area);
//      while(getch() != ERR);
    }
  }
  endwin();
  return 0;
}


WINDOW *create_win(int height, int width, int starty, int startx) {
  WINDOW *local_win;
  local_win = newwin(height,width,starty,startx);
  wrefresh(local_win);
  return local_win;
}

int choosepiece() {
  return (rand() % 6) * 24;
}

void drawpiece(WINDOW *win, int shape[], int offset, int posy, int posx) {
  int i, lposy, lposx;
  mvwprintw(win, posy, posx, "0");
  for (i = 0;i < 6;i += 2) {
     lposy = posy + shape[offset+i];
     lposx = posx + shape[offset+i+1];
     mvwprintw(win, lposy, lposx, "#");
  }
}






