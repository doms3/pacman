public abstract class Ghost extends Player {  

  public Ghost( PVector pos, color colour ) {
    this.pos = pos.copy();
    this.colour = colour;
    speed = 1.5;
  }

  public void show() {
    PVector rect;
    float d = 2 * colSize / 3;
    fill( colour );
    ellipse( pos.x, pos.y - rowSize / 8, d, d );
    rect = PVector.add( pos, new PVector( 0, d/3 - d / 8 ));
    rect( rect.x, rect.y, d, 3 * d / 4 );
  }
  
  private Direction[] seekSquare( PVector target ) {
    int index = grid.checkPos( pos.x, pos.y ).getIndex();
    HashMap< Square, Direction > potentialMoves = new HashMap();
    
    potentialMoves.put( grid.squares[ index - numRows ],    Direction.UP );
    potentialMoves.put( grid.squares[ index + numRows ],  Direction.DOWN );
    potentialMoves.put(       grid.squares[ index - 1 ],  Direction.LEFT );
    potentialMoves.put(       grid.squares[ index + 1 ], Direction.RIGHT );
    
    Square[] targetSquares = potentialMoves.keySet().toArray( new Square[4] );
    
    int count = 0;
    do { 
      count = 0;
      for( int i = 0; i < targetSquares.length - 1; i++ ) {
        if( PVector.dist(targetSquares[i + 1].pos, target) < PVector.dist(targetSquares[i].pos, target) ) {
          Square temp = targetSquares[i];
          targetSquares[i] = targetSquares[ i + 1 ];
          targetSquares[ i + 1 ] = temp;
          count++;
        }
      }
    } while( count != 0 );
    
    Direction[] directionOrder = new Direction[4];
    
    for( int i = 0; i < targetSquares.length; i++ ) {
      directionOrder[i] = potentialMoves.get( targetSquares[i] );
    }
   
    return directionOrder;
  }
  
  private Direction[] seekSquare() {
    return seekSquare( this.getTarget() );
  }
  
  private Direction[] seekSquare( Square square ) {
    return seekSquare( square.pos );
  }
  
  protected Direction chooseDirection() {
    Direction[] orderedDirections = seekSquare();
    
    if( orderedDirections.length != 4 ) {
      throw new RuntimeException( "Invalid Array Length!" );
    }
    
    Square target = grid.checkPos( pos.x, pos.y );
    for( int i = 0; i < orderedDirections.length; i++ ) {
      if( !target.restrictions.contains( orderedDirections[i] ) && orderedDirections[i] != direction.getOpposite() )
        return orderedDirections[i];
    }
    
    return Direction.STILL;
  }
  
  abstract protected PVector getTarget();
}