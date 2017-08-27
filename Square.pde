public class Square {
  public color colour;
  public PVector pos;

  private int indexRow;
  private int indexCol;

  public HashSet<Direction> restrictions = new HashSet();

  Boolean hasFood;

  private float wid = colSize;
  private float hei = rowSize;

  public Boolean isWall;

  Square( int row, int col, int desc, int food ) {
    float x = col * colSize + colSize/2;
    float y = row * rowSize + rowSize/2;

    indexRow = row;
    indexCol = col;

    if ( food == 1 ) {
      hasFood = false;
    } else if ( food == 0 ) {
      hasFood = true;
    }
    pos = new PVector( x, y );
    if ( desc == 1 ) {
      isWall = true;
      colour = color( 52, 93, 169 );
    } else if ( desc == 0 ) {
      isWall = false;
      colour = color( 0 );
    }
  }

  public void show() {
    showBackground();
    showFood();
    if ( debug ) {
      showNums();
    }
  }

  private void showNums() {
    fill( 255 );
    textSize( 8 );
    textMode( CENTER );
    text( indexRow + "," + indexCol, pos.x, pos.y);
  }

  private void showBackground() {
    fill( colour );
    rect( pos.x, pos.y, wid, hei );
  }

  private void showFood() {
    if ( hasFood ) {
      fill(255);
      ellipse( pos.x, pos.y, colSize / 3, rowSize / 3 );
    }
  }

  public void getRestrictions() {
    int index = indexRow * numRows + indexCol + 1;
    if ( indexCol >= numCols - 1 || grid.squares[index].isWall )
      restrictions.add( Direction.RIGHT );   
    index = ( indexRow - 1 ) * numRows + indexCol;
    if ( indexRow <= 0 || grid.squares[index].isWall )
      restrictions.add( Direction.UP );  
    index = indexRow * numRows + indexCol - 1;
    if ( indexCol <= 0 || grid.squares[index].isWall)
      restrictions.add( Direction.LEFT );   
    index = (indexRow + 1) * numRows + indexCol;
    if ( indexRow >= numRows - 1 || grid.squares[index].isWall)
      restrictions.add( Direction.DOWN );
  }

  public int getIndex() {
    return indexRow * numCols + indexCol;
  }
}