//shapes.h - header file containing shape info for ncurses tetris program
#define ABOVE -1
#define BELOW 1
#define RIGHT 1
#define LEFT -1
#define INLINE 0

typedef struct state {
  int oldstate;
  int newstate;
} board;

int shapes[144] = //shape maps, grouped as units of 3, doublets indicating position relative to element 0 of the shape. 4 sets/shape correspond to possible rotations.
{
      
        ABOVE, INLINE, //  ## 
        ABOVE, LEFT,   //  ##
        INLINE, LEFT,  //   
        ABOVE, INLINE, // 
        ABOVE, LEFT,   //
        INLINE, LEFT,  // SQUARE IS A SPECIAL CASE: REMAINS THE SAME.
        ABOVE, INLINE, //
        ABOVE, LEFT,   //
        INLINE, LEFT,  //
        ABOVE, INLINE, //
        ABOVE, LEFT,   //
        INLINE, LEFT,
      
        ABOVE, INLINE, //  # 
        BELOW, INLINE, //  0
        BELOW, RIGHT,  //  ##
        INLINE, RIGHT, //  
        INLINE, LEFT,  // #0#
        BELOW, LEFT,   // #
        BELOW, INLINE, // ## 
        ABOVE, INLINE, //  0
        ABOVE, LEFT,   //  #
        INLINE, LEFT,  //   #
        INLINE, RIGHT, // #0#
        ABOVE, RIGHT   //
      ,   //ELL
      
        ABOVE, LEFT,   // # 
        INLINE, LEFT,  // #0
        BELOW, INLINE, //  #
        ABOVE, RIGHT,  //  ##
        ABOVE, INLINE, // #0
        INLINE, LEFT,  //
        BELOW, RIGHT,  //  #
        INLINE, RIGHT, //  0#
        ABOVE, INLINE, //   #
        BELOW, LEFT,   // 
        BELOW, INLINE, //  0#
        INLINE, RIGHT  // ##
      ,   //ESS
      
        -2, INLINE,    // LINE IS A SPECIAL CASE - HAS TWO PERMUTATIONS:
        ABOVE, INLINE, // 
        BELOW, INLINE, //  #
        INLINE, 2,     //  #
        INLINE, RIGHT, //  0
        INLINE, LEFT,  //  #
        -2, INLINE,    //
        ABOVE, INLINE, //  #0##
        BELOW, INLINE, //
        INLINE, 2,     //
        INLINE, RIGHT, //
        INLINE, LEFT   //
      ,  //LINE
      
        ABOVE, RIGHT,  //   #
        INLINE, RIGHT, //  0#
        BELOW, INLINE, //  #
        BELOW, RIGHT,  //
        BELOW, INLINE, // #0 
        INLINE, LEFT,  //  ##
        BELOW, LEFT,   //  #
        INLINE, LEFT,  // #0
        ABOVE, INLINE, // #
        ABOVE, LEFT,   // ##
        ABOVE, INLINE, //  0#
        INLINE, RIGHT  //
      ,   //ZED
      
        INLINE, LEFT,  //  #
        INLINE, RIGHT, // #0#
        ABOVE, INLINE, //  
        ABOVE, INLINE, //  #
        BELOW, INLINE, //  0#
        INLINE, RIGHT, //  #
        INLINE, RIGHT, // 
        INLINE, LEFT,  // #0#
        BELOW, INLINE, //  #
        BELOW, INLINE, //  #
        ABOVE, INLINE, // #0
        INLINE, LEFT   //  #
          //TEE
        };
