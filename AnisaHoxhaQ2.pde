Player player = new Player();
Barrier b1 = new Barrier(200, 900, 200, 200);
Barrier b2 = new Barrier(400, 700, 400, 0);
Barrier b3 = new Barrier(600, 900, 600, 200);
FinishLine fl = new FinishLine(710, 850, 200, 100);

void setup(){
  size(800, 900);
}

void draw(){
  //if the player has reached the finish line display the text "You Win!"
  if (player.checkFinish(fl)){
    background(0);
    textSize(50);
    textAlign(CENTER, RIGHT);
    text("You Win!", 255, 255);
  }
  // if the player hasnt reached finish line continue with game
  else{
    background(220);
    rectMode(CENTER);
    player.update();
    b1.placeBarrier();
    b2.placeBarrier();
    b3.placeBarrier();
    fl.placeFinish();
    player.checkCollision(b1);
    player.checkCollision(b2);
    player.checkCollision(b3);
    player.checkFinish(fl);
  }
  
}

//Player Class
class Player{
  float xPos, yPos;
  Player(){ // To begin with player is set at the bottom left cornor of game
    xPos = 100;
    yPos = 850;
  }
  
  // check if player has collided with a barrier 
  void checkCollision(Barrier b){ 
    if (xPos > b.getXStart() - 25 && xPos < b.getXEnd() + 25 && yPos > b.getYEnd() - 25 && yPos < b.getYStart() + 25){
      // if player has collided with a barrier send back to starting position
      xPos = 100;
      yPos = 850;
    } 
  }
  
  boolean checkFinish(FinishLine f){
    // if the player is within the coordinates of the finish box
    if( xPos > f.xFinish() && yPos > f.yFinish()){
      return true;
    }
    return false;
  }
  
  void update(){ //if a key is pressed check which key, then move player as required until key is no longer pressed 
    if(keyPressed == true){
      if (key == CODED){
        if(keyCode == UP){
          if (yPos > 25){
            yPos -=4;
          }
        }
        else if (keyCode == DOWN){
          if (yPos < 875){
            yPos += 4;
          }
        }
        else if (keyCode == LEFT){
          if (xPos > 25){
            xPos -= 4;
          }
        }
        else if (keyCode == RIGHT){
          if (xPos < 775){
            xPos += 4;
          }
        }
      }
    }
    strokeWeight(5);
    stroke(0, 255, 0);
    fill(0, 255, 0);
    rect(xPos, yPos, 50, 50);
  }
}

//Barrier class note when initiating class, yStart should be at the bottom of the screen and yEnd at the top, to ensure collision check is accurate (yStart > yEnd)
class Barrier{
  float xStart, yStart, xEnd, yEnd;
  
  Barrier(float x1, float y1, float x2, float y2){
    xStart = x1;
    yStart = y1;
    xEnd = x2;
    yEnd = y2;
  }
  
  void placeBarrier(){
    strokeWeight(5);
    stroke(255, 0, 0);
    line(xStart, yStart, xEnd, yEnd);
  }
  
  float getXStart(){
    return xStart;
  }
  
  float getYStart(){
    return yStart;
  }
  
  float getXEnd(){
    return xEnd;
  }
  
  float getYEnd(){
    return yEnd;
  }
}

class FinishLine{
  float x, y, width, height;
  
  FinishLine(float a, float b, float c, float d){
    x = a;
    y = b;
    width = c;
    height = d;
  }
  
  void placeFinish(){
    strokeWeight(5);
    stroke(255, 255, 0);
    fill(255, 255, 0);
    rect(x, y, width, height);
  }
  
  float yFinish(){
    return (y - (height / 2));
  }
  
  float xFinish(){
    return (x - (width / 2));
  }
    
}

// didnt get time to do the enemies
// but my approach for detecting collision would be similar to before 
// using getters 
// would need to check if enemy is colliding with barrier and then change direction
//also would need to check if player collided with enemy and send player back to start
