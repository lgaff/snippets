#include <ncurses.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>

typedef struct ns {
 int xpos;
 int ypos;
 struct ns *next;
} snake;

typedef struct nom {
  int xpos;
  int ypos;
  int time;
  int score;
  char sym;
} munch;

void *addlength(snake *head) {
  snake *new = (snake *)malloc(sizeof(snake));
  while (head->next != NULL) {
   head  = head->next;
  }
  head->next = new;
  new->next = NULL;
  new->xpos = -1;
  new->ypos = -1;
}

void rmlength(snake *head) {
  snake *seg = head->next;
  head->next = seg->next;
  free(seg);
}


snake *init_snake(int x, int y, int length) {
  int i;
  snake *new = (snake *)malloc(sizeof(snake));
  new->xpos = x;
  new->ypos = y;
  new->next = NULL;
  for(i = 1;i < length;i++) {
    addlength(new);
  }
  return new;
}

void resetsnake(snake *head, int x, int y, int length) {
  int i;
  while(head->next != NULL) {
    rmlength(head);
  }
  head->xpos = x;
  head->ypos = y;
  for (i = 0;i < length;i++) {
    addlength(head);
  }
}

int movesnake(snake *head, int vector, int resy, int resx) {
  int oldx,oldy;
  int headx, heady;
  oldx = head->xpos;
  oldy = head->ypos;
  switch (vector) {
    case -2: //up
      head->ypos = head->ypos - 1;
      break;
    case 1: //right
      head->xpos = head->xpos + 1;
      break;
    case 2: //down
      head->ypos = head->ypos + 1;
      break;
    case -1: //left
      head->xpos = head->xpos - 1;
      break;
    }
  if (head->ypos < 1) { 
    head->ypos = resy - 1;
  }
  else if (head->ypos == resy) {
    head->ypos = 1;
  }
  heady = head->ypos;

  if (head->xpos < 1) {
    head->xpos = resx - 1;
  }
  else if (head->xpos == resx) {
    head->xpos = 1;
  }
  headx = head->xpos; //save these for collision detection
  while(head->next !=NULL) {
    head = head->next;
    if ((heady == head->ypos) && (headx == head->xpos)) {
      return 1;
    }
    head->xpos = head->xpos ^ oldx;
    oldx = head->xpos ^ oldx;
    head->xpos = head->xpos ^ oldx;

    head->ypos = head->ypos ^ oldy;
    oldy = head->ypos ^ oldy;
    head->ypos = head->ypos ^ oldy;
    
  }
  return 0;
}

void drawsnake(snake *head) {
  mvprintw(head->ypos, head->xpos, "+"); 
  while (head->next != NULL) {
    head = head->next;
    mvprintw(head->ypos, head->xpos, "+");
  } 
}

void  movemunch(munch *nom, snake *head, int lines, int cols) {
  int munchx, munchy;
  snake *tmp;
  tmp = head;
  munchx = rand() % (cols -2);
  munchy = rand() % (lines -2);
  while (tmp->next != NULL) {
    if (munchx == tmp->xpos || munchx == tmp->ypos) {
      munchx = rand() % (cols -2);
      munchy = rand() % (lines -2);
      tmp = head;
      continue;
    }
    tmp = tmp->next;
  }
  munchy++;
  munchx++;
  nom->xpos = munchx;
  nom->ypos = munchy;    
} 

void drawbox(int h,int w) {
  int i;
  for(i = 1;i<h;i++) {
    mvprintw(i, 0, "|");
    mvprintw(i, w, "|");
  }
  for(i = 1;i<w;i++) {
    mvprintw(0, i, "-");
    mvprintw(h, i, "-");
  }
  mvprintw(0, 0, "+");
  mvprintw(0, w, "+");
  mvprintw(h, 0, "+");
  mvprintw(h, w, "+");
}
        
int main(int argc, char *argv[]) {
  int lives;
  int speed;
  int links;
  int i;
  int vector;
  int ch;
  int resx, resy;
  munch* chomp;
  snake* sammy;
  vector = 1;
  srand(time(0));
  
  if (argc > 1) { //difficulty specified
    switch (atoi ((*(argv + 1)))) { 
        case 1: //easy
          lives = 10;
          speed = 200;
          links = 2;
          break;
        case 2: //medium
          lives = 5;
          speed = 100;
          links = 4;
          break;
        case 3: //hard
          lives = 3;
          speed = 50;
          links = 8;
          break;
        default:
          printf("Difficulty specified is not a valid value.\n");
          printf("Specify either 1, 2 or 3\n");
          return 1;
          break;
    }
  }
  else { //no difficulty specified. revert to medium
    lives = 5;
    speed = 100;
    links = 4;
  }

  initscr();
  
  if (has_colors()) {
      start_color();
      init_pair(1, COLOR_RED, COLOR_BLACK);
  }
  raw();
  timeout(speed);
  cbreak();
  keypad(stdscr, TRUE); //enable function keys & arrows.
  noecho();             //Don't echo keypresses
  curs_set(0);
  sammy = init_snake(1,1, 10);
  resx = COLS - 1;
  resy = LINES - 2;

  movemunch (chomp, sammy, resy-1, resx-1);
  while((ch = getch()) != 113) {
  clear();
  drawbox(resy, resx);
  switch(ch) {
    case KEY_LEFT:
      if (vector != 1)
        vector = -1;
      break;
    case KEY_RIGHT:
      if (vector != -1)
        vector = 1;
      break;
    case KEY_UP:
      if (vector != 2)
        vector = -2;
      break;
    case KEY_DOWN:
      if (vector != -2)
        vector = 2;
      break;
    default:
      break;
  }

  if (movesnake(sammy, vector, resy, resx)) {
    lives--;
    timeout(-1);
  if (lives == 0) {
      mvprintw((LINES/2), (COLS/2-5), "GAME OVER!");
      getch();
      endwin();
      return 0;
    }
    mvprintw((LINES-1),0, "COLLISION!! LIVES LEFT: %d", lives);
    getch();
    vector = 2;
    resetsnake(sammy, 1, 1, 10);
    timeout(speed);
  }
  
  if (sammy->xpos == chomp->xpos && sammy->ypos == chomp->ypos) {
    for(i = 0;i <= links;i++) {
      addlength(sammy);
    }
    refresh();
    movemunch(chomp, sammy, resy, resx);
  }
  if (has_colors()) {
    attron(COLOR_PAIR(1) | A_BOLD);
  }
  mvprintw(chomp->ypos, chomp->xpos, "@");
  if (has_colors()) {
    attroff(COLOR_PAIR(1) | A_BOLD);
  }
  drawsnake(sammy);
  refresh();
  mvprintw(resy+1, 0, "LIVES %d", lives);
  }
  endwin();
  return 0;
}
