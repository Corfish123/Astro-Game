
//bricks to break
public class Brick {

  float x;
  float y;
  int widthB;
  int counter;


  Brick(float inX, float inY, int inWidth, int count)
  {
    x = inX;
    y = inY;
    widthB = inWidth;
    counter = count;
  }
  boolean isDead() {
    if (counter<=0)
    {
      return true;
    }
    return false;
  }
  void display()
  {
    if(!isDead())
    {
    fill(255);
    rect(x, y, widthB, widthB, width/70);
    fill(100, 102, 153);
    textt("" + counter, x, y+(widthB/3), widthB, widthB, color(0), widthB/4, CENTER);
    }
    move();
  }
  //move the bricks
  void move()
  {
    y+=speed;
  }
  //check if shihp is in bounds
  void checkBounds()
  {
    if(y>height)
    {
       counter = 0; 
    }
  }
  //check if the brick has hit the ship and if it does, play a sound and does double damage to the ship
  void checkCollision()
  {
     if (ship.x+ship.widthS > x && ship.x < x+widthB && ship.y + ship.widthS >y && ship.y<= y+widthB)
      {
        playSound(2);
        ship.counter -= counter*2;
        score += counter;
        levelUpCounter += counter;
        counter = 0;
      }
  }
}