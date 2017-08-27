public abstract class Player {
  public PVector pos;
  protected Direction direction = Direction.STILL;
  protected float speed;
  protected color colour;
  
  public void update() {
    if( grid.isOnGrid( this ) )
      direction = chooseDirection();
    wrapPosition();
    PVector vel = direction.getVector().setMag( speed );
    pos.add( vel );
  }
  
  abstract protected Direction chooseDirection();
  
  abstract public void show();
  
  protected void wrapPosition() {
    if( pos.x > width ) {
      pos.x -= width + colSize / 2;
      grid.placeOnGrid( pacman );
    }
    else if( pos.x < 0 ) {
      pos.x += width + colSize / 2;
      grid.placeOnGrid( pacman );
    }
  }
  
}