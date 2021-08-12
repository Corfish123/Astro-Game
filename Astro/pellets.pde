//pellet for bullet
public class Pellets {

  float x;
  float y;
  int widthB;
  boolean isDead;

  Pellets(float inX, float inY, int inWidth)
  {
    x = inX;
    y = inY;
    widthB = inWidth;
    isDead = false;
  }
  boolean isDead() {

    return isDead;
  }
  void display()
  {
    fill(255);
    ellipse(x, y, widthB, widthB);
    move();
  }
  void move()
  {
    y-= speed;
  }
  void checkBounds()
  {
    if (y>height)
    {
      isDead = true;
    }
  }
}