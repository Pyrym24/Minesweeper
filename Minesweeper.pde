import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_MINES = 40;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0;r<NUM_ROWS;r++){
      for(int c = 0;c<NUM_COLS;c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    mines = new ArrayList<MSButton>();
    
    setMines();
    System.out.println(countMines(3,3));
    
}
public void setMines()
{
  while(mines.size()<NUM_MINES){
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_ROWS);
   
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
      System.out.println(r+","+c);
}
}
}
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
        text("You Win",200,200);
}
public boolean isWon()
{
    int sum = 0;
    for(int r = 0;r<mines.size();r++){
      if(mines.get(r).flagged ==true){
          sum++;
        }
      
    }
    if(sum==mines.size()){
      return true;
    }
    return false;
}
public void displayLosingMessage()
{
    //your code here
    System.out.println("loss");
    for(int r = 0;r<mines.size();r++){
      mines.get(r).clicked=true;
    }
    stroke(255,0,0);
}
public void displayWinningMessage()
{
    //your code here
    System.out.println("win");
    stroke(0,255,0);
}
public boolean isValid(int r, int c)
{
    //your code here
     if(c<0||r<0){
    return false;
  }
  if(r>NUM_ROWS-1){
    return false;
  }
  if(c>NUM_COLS-1){
    return false;
  }
  return true;
}
public int countMines(int row, int col)
{
  int sum = 0;

 if(isValid(row,col-1)==true&&mines.contains(buttons[row][col-1])==true){
   sum++;
}
 if(isValid(row-1,col-1)==true&&mines.contains(buttons[row-1][col-1])==true){
   sum++;
}
 if(isValid(row-1,col)==true&&mines.contains(buttons[row-1][col])==true){
   sum++;
}
 if(isValid(row,col+1)==true&&mines.contains(buttons[row][col+1])==true){
   sum++;
}
 if(isValid(row+1,col)==true&&mines.contains(buttons[row+1][col])==true){
   sum++;
}
 if(isValid(row+1,col+1)==true&&mines.contains(buttons[row+1][col+1])==true){
   sum++;
}
 if(isValid(row+1,col-1)==true&&mines.contains(buttons[row+1][col-1])==true){
   sum++;
}
 if(isValid(row-1,col+1)==true&&mines.contains(buttons[row-1][col+1])==true){
   sum++;
}
return sum;
}

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
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
        System.out.println("set");
      clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          flagged = !flagged;
        }else if(mines.contains(this)){
          displayLosingMessage();}
      else if(countMines(this.getR(),this.getC())>0){
         myLabel = countMines(myRow,myCol) + "";
      }else{
        for(int g = -1;g<=1;g++){
          for(int l = -1;l<=1;l++){
            if(isValid(myRow+g,myCol+l)==true && buttons[myRow+g][myCol+l].clicked==false){
            buttons[myRow+g][myCol+l].mousePressed();
          }
          }
        }
      }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
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
    public int getR(){
      return myRow;
    }
    public int getC(){
      return myCol;
    }
}
