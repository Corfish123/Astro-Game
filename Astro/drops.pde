public class Drops {

  float x;
  float y;
  float widthD;
  boolean isDead;
  int counter;


  Drops(float inX, float inY, float inWidth, int count)
  {
    x = inX;
    y = inY;
    widthD = inWidth;
    isDead = false;

    counter = count;
  }

  void move()
  {

    y+=speed;
  }
  void display()
  {
    fill(255);

    ellipse(x, y, widthD, widthD);
    fill(100, 102, 153);
    textt("" + counter, x, y+(widthD/(5.5)), widthD, widthD, color(0), widthD/(1.5), CENTER);
    move();
  }
  void checkCollision()
  {
    if (ship.x+ship.widthS > x && ship.x < x+widthD && ship.y + ship.widthS >y && ship.y<= y+widthD)
      {
        ship.counter += counter;
        counter = -1;
      }
  }
   void checkBounds()
  {
    if(y<-width/2)
    {
       counter = 0;
    }
  }
   boolean isDead() {
    if (counter<=0)
    {
      return true;
    }
    return false;
  }
}