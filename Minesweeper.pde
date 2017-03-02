

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public int bCounter = 20;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row=0; row<NUM_ROWS; row++){
        for(int col=0; col<NUM_COLS; col++)
            buttons[row][col]=new MSButton(row,col);
    }
        
    while(bCounter>=1)
        setBombs();
}
public void setBombs()
{
    //your code
    int numRow = (int)(Math.random()*NUM_ROWS);
    int numCol = (int)(Math.random()*NUM_COLS);
    if(bCounter>=1) {
        if(!bombs.contains(buttons[numRow][numCol])){
            bombs.add(0,buttons[numRow][numCol]);
            bCounter--;
             }
        else{
            setBombs();
        }
    }
    System.out.println(bCounter);
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(marked == true)
        {
          marked = false;
          if(numBombs>0)
            
           if(isValid(r,c-1) && !bombs.contains(buttons[r][c-1]) && !buttons[r][c-1].isMarked())
                buttons[r][c-1].mousePressed();
            /*
           if(isValid(r,c+1) && buttons[r][c+1].isMarked())
                buttons[r][c+1].mousePressed();
           if(isValid(r-1,c) && buttons[r-1][c].isMarked())
                buttons[r-1][c].mousePressed();
           if(isValid(r+1,c) && buttons[r+1][c].isMarked())
                buttons[r+1][c].mousePressed();
            */
        }
    
        clicked = true;
        //your code here
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c) //post condition: returns true if both row and col are valid, false otherwise
    {
      if(r>=0 && r<=NUM_ROWS-1 && c>=0 && c<=NUM_COLS-1)
        return true;
      return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(r,c-1) && !bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r,+1) && !bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r+1,c) && !bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(isValid(r-1,c) && !bombs.contains(buttons[r-1][c]))
            numBombs++;


        return numBombs;
    }
}