

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS=20;
private int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
//private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private ArrayList<MSButton> bombs = new ArrayList<MSButton>();
private int numCol=20;
private int numRow=20;
private int bombCounter=0;
private int clearChecker=0;
private static int bombInit=30;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons= new MSButton[NUM_ROWS][NUM_COLS];

    for(int j=0; j<NUM_ROWS; j++){
        for(int i=0; i<NUM_COLS; i++){
            buttons[j][i]=new MSButton(j,i);
        }
    }
    bombCounter=bombInit;
    while(bombCounter>=1){
        setBombs();
    }    
}
public void setBombs()
{
    //your code    
    numRow=(int)(Math.random()*NUM_ROWS);
    numCol=(int)(Math.random()*NUM_COLS);
        if(bombCounter>=1){
            if(!bombs.contains(buttons[numRow][numCol])){
                bombs.add(0,buttons[numRow][numCol]);
                bombCounter--;
            }else{
                setBombs();
            }
        }
    //System.out.println(bombCounter);asjksdf
}

public void draw ()
{
    //background( 0 );
    //System.out.println(clearChecker);
    //if(isWon())
      // displayWinningMessage();
}
public boolean isWon()
{
        //your code here
            for(int rowBomb=0; rowBomb<NUM_ROWS;rowBomb++){
                for(int colBomb=0; colBomb<NUM_COLS;colBomb++){
                    if(buttons[rowBomb][colBomb].isClicksed()){
                        clearChecker++;
                    }
                   
                }
            }
        if(clearChecker>=(NUM_ROWS*NUM_COLS)-bombInit){
            return true;    
        }
        clearChecker=0;
        return false;
}
public void displayLosingMessage()
{
    //your code here
    //background(40);
    textSize(50);
    fill(0);
    text("Game Over", 200, 90);
    textSize(12);
    for(int rowBomb=0; rowBomb<NUM_ROWS;rowBomb++){
        for(int colBomb=0; colBomb<NUM_COLS;colBomb++){
                //fill(255,0,0);
                //rect(buttons[rowBomb][colBomb].x,buttons[rowBomb][colBomb].y,buttons[rowBomb][colBomb].width,buttons[rowBomb][colBomb].height);
                buttons[rowBomb][colBomb].mousePressed();
                fill(255,0,0);
        }
    }
    //noLoop();
 }
public void displayWinningMessage()
{
    //your code here
    textSize(50);
    text("You Win", 200, 90);
    textSize(12);
    noLoop();
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
    public boolean isClicksed()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        if(keyPressed==false){
            clicked=true;
            if(countBombs(r,c)>0){
                fill(0);
                label = ""+(this.countBombs(r,c));
                //text(label, x+width/2, y+ height/2);
            }else{
                    if(isValid(r,c-1) && !bombs.contains(buttons[r][c-1])&&!buttons[r][c-1].isClicksed())
                         buttons[r][c-1].mousePressed();
                    if(isValid(r,c+1) && !bombs.contains(buttons[r][c+1])&&!buttons[r][c+1].isClicksed())
                         buttons[r][c+1].mousePressed();
                    if(isValid(r-1,c) && !bombs.contains(buttons[r-1][c])&&!buttons[r-1][c].isClicksed())
                         buttons[r-1][c].mousePressed();
                    if(isValid(r+1,c) && !bombs.contains(buttons[r+1][c])&&!buttons[r+1][c].isClicksed())
                         buttons[r+1][c].mousePressed();
                    
                    if(isValid(r-1,c-1) && !bombs.contains(buttons[r-1][c-1])&&!buttons[r-1][c-1].isClicksed())
                         buttons[r-1][c-1].mousePressed();
                    if(isValid(r-1,c+1) && !bombs.contains(buttons[r-1][c+1])&&!buttons[r-1][c+1].isClicksed())
                        buttons[r-1][c+1].mousePressed();
                    if(isValid(r+1,c-1) && !bombs.contains(buttons[r+1][c-1])&&!buttons[r+1][c-1].isClicksed())
                         buttons[r+1][c-1].mousePressed();
                    if(isValid(r+1,c+1) && !bombs.contains(buttons[r+1][c+1])&&!buttons[r+1][c+1].isClicksed())
                         buttons[r+1][c+1].mousePressed();

            }
        }else if(keyPressed==true){
            marked=!marked;

        }
    }

    public void draw () 
    {    
        if (marked){
            fill(0);
        }
        else if( clicked && bombs.contains(this) ){
            fill(255,0,0);
            displayLosingMessage();
        }
        else if(clicked){
            fill( 200 );
            if(countBombs(r,c)>0){
                label = ""+(this.countBombs(r,c)); 
                text(label, x+width/2, y+ height/2);
            }
        }
        else if(isWon()){
                displayWinningMessage();
                noLoop();
        }
        else{
            fill( 100 );
        }
        rect(x, y, width, height);
        fill(0);
        //label = Integer.toString(this.countBombs(r,c));
        text(label, x+width/2, y+ height/2);
    
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<=NUM_ROWS-1&&r>=0&&c<=NUM_COLS-1&&c>=0){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        /*for(int i=-1; i<2;i++){
            for(int j=-1; j<2;j++){
                if(isValid(r-i,c-j)){
                    if(bombs.contains(buttons[numRow-i][numCol-j])){
                        numBombs++; 
                    }
                }
            }
        }*/
                if(isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
                     numBombs++;
                if(isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
                     numBombs++;
                if(isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
                     numBombs++;
                if(isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
                    numBombs++;
                
                if(isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
                    numBombs++;
                if(isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
                    numBombs++;
                if(isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
                    numBombs++;
                if(isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
                    numBombs++;

        return numBombs;
    }
}
