import java.util.HashSet;

// Number of rows and columns
final int numCols = 21;
final int numRows = 21;

// Debug mode shows grid numbers in the game when set to true 
final boolean debug = false;

// Size of rows and columns
float colSize;
float rowSize;

// Character objects
Man pacman;
Ghost[] ghosts = new Ghost[4];
Grid grid;


void setup() {
  size( 630, 630 );
  noStroke();
  rectMode( CENTER );
  
  colSize = width / numCols;
  rowSize = height / numRows;
  
  grid = new Grid(); // initialize the grid
  grid.tidyRestrictions();
  
  // initalize character objects
  pacman = new Man();
  
  ghosts[0] = new Ghost( grid.getLocation( 7, 10 ), color( 215, 50, 41 ) ) {
    protected PVector getTarget() { return millis() % 20000 < 5000 ? grid.getLocation( 2, 3 ) : pacman.pos; };
  };
  ghosts[1] = new Ghost( grid.getLocation( 9, 9 ), color(  84, 196, 196 ) ) {
    protected PVector getTarget() { return millis() % 20000 < 5000 ? grid.getLocation( 2, 17 ) 
                                                                   : PVector.add( pacman.pos, pacman.direction.getVector().mult( rowSize * 4 ) ); };
  };
  ghosts[2] = new Ghost( grid.getLocation( 9, 10 ), color( 202, 118, 166 ) ) {
    protected PVector getTarget() { return millis() % 20000 < 5000 ? grid.getLocation( 20, 8 ) : PVector.sub( pacman.pos, ghosts[0].pos ).mult(2); };
  };
  ghosts[3] = new Ghost( grid.getLocation( 9, 11 ), color( 243, 136, 68 ) ) {
    protected PVector getTarget() { if ( millis() % 20000 < 5000 ) return grid.getLocation( 20, 12 );
                                    else return PVector.dist( pos, pacman.pos ) > rowSize * 8 ? pacman.pos : grid.getLocation( 20, 12 ); };
  };
  
}

void draw() {
 
  grid.show();

  pacman.update();
  pacman.show();
  
  for ( Ghost ghost : ghosts ) {
    ghost.update();
    ghost.show();
  }
  
  // if pacman touches any ghosts it's game over
  for ( Ghost ghost : ghosts ) {
    if ( dist( pacman.pos.x, pacman.pos.y, ghost.pos.x, ghost.pos.y ) < colSize / 2 ) {
      textSize( 100 );
      pacman.show();
      fill( 255, 0, 0 );
      textAlign( CENTER );
      text( "GAME OVER", width/2, height/2 );
      noLoop();
    }
  }
}

void keyPressed() {
  if ( keyCode == RIGHT )
    pacman.pushMovement( Direction.RIGHT );
  if ( keyCode == UP )
    pacman.pushMovement( Direction.UP );
  if ( keyCode == LEFT )
    pacman.pushMovement( Direction.LEFT );
  if ( keyCode == DOWN )
    pacman.pushMovement( Direction.DOWN );
}