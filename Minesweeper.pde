import de.bezier.guido.*;
public int NUM_ROWS =25;
public int NUM_COLS =25;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r=0; r<buttons.length; r++) {
    for (int c=0; c<buttons[0].length; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }

  setMines();
}
public void setMines() {
  for(int i=0;i<10;i++){
    int numberOfRows = ((int)Math.random()*NUM_ROWS);
    int numberOfCols = ((int)Math.random()*NUM_COLS);
      if (mines.contains(buttons[numberOfRows][numberOfCols])==false) {
        mines.add(buttons[numberOfRows][numberOfCols]);
      }
  }
  //your code
}

public void draw ()
{
  background( 0 );
  if (isWon() == true){
    displayWinningMessage();
    noLoop();
  }
}
public boolean isWon()
{
  //your code here
  int numberOfMines =  0;
  for (int i=0; i<mines.size(); i++) {
    if (mines.get(i).isFlagged()==true) {
      numberOfMines++;
    }
  }
  if (numberOfMines==mines.size()) {
    return true;
  }
  return false;
}
public void displayLosingMessage()
{
  buttons[0][0].setLabel("L");
  buttons[0][1].setLabel("O");
  buttons[0][2].setLabel("S");
  buttons[0][3].setLabel("E");

  //your code here
}
public void displayWinningMessage()
{
  buttons[0][0].setLabel("W");
  buttons[0][1].setLabel("I");
  buttons[0][2].setLabel("N");
  //your code here
}
public boolean isValid(int r, int c)
{
  if (r<NUM_ROWS && c<NUM_COLS && c>=0 && r>=0) {
    return true;
  }
  return false;
  //your code here
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row-1, col-1)==true && mines.contains(buttons[row-1][col-1])==true) {
    numMines++;
  }
  if (isValid(row-1, col)==true && mines.contains(buttons[row-1][col])==true) {
    numMines++;
  }
  if (isValid(row-1, col+1)==true && mines.contains(buttons[row-1][col+1])==true) {
    numMines++;
  }
  if (isValid(row+1, col)==true && mines.contains(buttons[row+1][col])==true) {
    numMines++;
  }
  if (isValid(row+1, col+1)==true&& mines.contains(buttons[row+1][col+1])==true) {
    numMines++;
  }
  if (isValid(row+1, col-1)==true && mines.contains(buttons[row+1][col-1])==true) {
    numMines++;
  }
  if (isValid(row, col-1)==true && mines.contains(buttons[row][col-1])==true) {
    numMines++;
  }
  if (isValid(row, col+1)==true && mines.contains(buttons[row][col+1])==true) {
    numMines++;
  }
  //if(buttons[row][col].isFlagged()==true){
  //  numMines--;
  //}
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton==RIGHT) {
      if (flagged==true) {
        flagged=false;
      } else if (flagged==false) {
        flagged=true;
      }
    } else if (mines.contains(this)==true) {
      displayLosingMessage();
    } else if (countMines(myRow, myCol)>0) {
      buttons[myRow][myCol].setLabel(countMines(myRow, myCol));
    } else {
      if (isValid(myRow, myCol-1)&&buttons[myRow][myCol-1].clicked==false) {
        buttons[myRow][myCol-1].mousePressed();
      }
      if (isValid(myRow, myCol+1)&&buttons[myRow][myCol+1].clicked==false) {
        buttons[myRow][myCol+1].mousePressed();
      }
      if (isValid(myRow-1, myCol-1)&&buttons[myRow-1][myCol-1].clicked==false) {
        buttons[myRow-1][myCol-1].mousePressed();
      }
      if (isValid(myRow-1, myCol)&&buttons[myRow-1][myCol].clicked==false) {
        buttons[myRow-1][myCol].mousePressed();
      }
      if (isValid(myRow-1, myCol+1)&&buttons[myRow-1][myCol+1].clicked==false) {
        buttons[myRow-1][myCol+1].mousePressed();
      }
      if (isValid(myRow+1, myCol-1)&&buttons[myRow+1][myCol-1].clicked==false) {
        buttons[myRow+1][myCol-1].mousePressed();
      }
      if (isValid(myRow+1, myCol)&&buttons[myRow+1][myCol].clicked==false) {
        buttons[myRow+1][myCol].mousePressed();
      }
      if (isValid(myRow+1, myCol+1)&&buttons[myRow+1][myCol+1].clicked==false) {
        buttons[myRow+1][myCol+1].mousePressed();
      }
    }

    //ignore trashy code
    //if(isValid(myRow,myCol-1)==true && buttons[myRow][myCol-1].mouseButton()){
    //  buttons[r][c-1].mousePressed();
    //}
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
