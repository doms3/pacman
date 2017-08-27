public enum Direction {
  UP    ( new PVector(  0, -1 ) ), 
  DOWN  ( new PVector(  0,  1 ) ), 
  LEFT  ( new PVector( -1,  0 ) ), 
  RIGHT ( new PVector(  1,  0 ) ), 
  STILL ( new PVector(  0,  0 ) );

  private PVector direction;

  private Direction( PVector direction ) {
    this.direction = direction;
  }

  public PVector getVector() {
    return direction.copy();
  }

  public Direction getOpposite() {
    switch( this ) {
    case UP: 
      return Direction.DOWN;
    case DOWN:
      return Direction.UP;
    case LEFT:
      return Direction.RIGHT;
    case RIGHT:
      return Direction.LEFT;  
    case STILL:
      return null;
    }
    return null;
  }
}