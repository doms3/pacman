public class Man extends Player {
  
  private Direction dirStack;
  private float mouthAngle = 0;

  public Man() {
    pos = grid.getLocation( 15, 10 );
    speed = 2;
    colour = color( 237, 237, 59 );
  }

  public void show() {
    fill( colour );

    if ( direction != Direction.STILL ) {
      pushMatrix();
      translate( pos.x, pos.y );
      rotate( direction.getVector().heading() );
      arc( 0, 0, colSize - 2, rowSize - 2, mouthAngle, TWO_PI - mouthAngle );
      popMatrix();
      float dist = max( ( pacman.pos.x - colSize / 2 ) % colSize, ( pacman.pos.y - rowSize / 2 ) % rowSize );
      dist -= colSize / 2;
      dist = abs( dist );
      mouthAngle = map( dist, 0, colSize / 2, 0, QUARTER_PI );
    } else {
      ellipse( pos.x, pos.y, colSize - 2, rowSize - 2 );
    }
  }

  protected Direction chooseDirection() {
    Direction potentialDirection = popMovement();
    Square currentSquare = grid.checkPos( pos.x, pos.y );
    if (  currentSquare.restrictions.contains( potentialDirection ) )
      return Direction.STILL;
    return potentialDirection;
  }

  public void pushMovement( Direction direction ) {
    dirStack = direction;
  }

  private Direction popMovement() {
    if( dirStack != null ) {
      Direction temp = dirStack;
      dirStack = null;
      return temp;
    }
    return direction;
  }
}