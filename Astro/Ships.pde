
public class Ship {
  public ArrayList<Pellets> pellets = new ArrayList<Pellets>();
  PImage ship;
  int widthS;
  int counter;
  float x;
  float y;
  int attackSpeed;
  boolean opstate;

  Ship(float x, float y, int inWidth)
  {
    ship = loadImage("spaceshipDown1.png");
    // pellets.add(new Pellets(x + widthS/2 - widthS/10, y, widthS/5));
    this.x = x;
    this.y = y;
    widthS = inWidth;
    counter = 100;
    attackSpeed = 10;
    opstate = false;
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
    fill(255);

    if (skinChange) {
      image(ship, x, y, widthS, widthS);

      textt("" + counter, x, y - widthS/3, widthS, widthS, color(255), widthS/3, CENTER);
    } else
    {
      // image(ship, x, y, widthS, widthS);
      ellipse(x, y, widthS, widthS);
      fill(100, 102, 153);
      textt("" + counter, x, y+(widthS/3), widthS, widthS, color(0), widthS/3, CENTER);
    }

    move();
    for (int i = 0; i < pellets.size(); i++)
    {
      Pellets pellet = pellets.get(i);
      pellet.display();
      pellet.checkBounds();
      if (pellet.isDead())
      {
        pellets.remove(i);
      }
    }
    shooting();
  }
  void move()
  {
    //    print(oz);

    if (Math.abs(accelerometerX) > 1)
    {
      println(Math.pow(accelerometerX, 2) /( accelerometerX * .3));
  //    if (accelerometerX < 0)
 //     {
        x-= Math.pow(accelerometerX, 2) /( accelerometerX * .3);
      //}
      //else
      //{
      //  x -= Math.pow(accelerometerX, 2)/( accelerometerX * .3);
      //}
    }
  }
  void shooting()
  {
    //for (Brick b : allBricks)
    //{
    //if (frameCount%20==0&& (b.y<y&& x > b.x && x<b.x+b.widthB))
    //{


    if (frameCount% attackSpeed==0&&mousePressed)
    {
      pellets.add(new Pellets(x + widthS/2 - widthS/10, y, widthS/5));
      counter--;
    }

    //  println("pellet " + (pellets.get(pellets.size() -1).y + pellets.get(0).widthB > y));
    //    println("mouse " + mousePressed);
    //    println(pellets.size());
    //println(pellets.size());
    //if(mousePressed)
    //{

    //  if(pellets.size() == 1 || pellets.get(pellets.size() -1).y + pellets.get(0).widthB > y)
    //  {
    //  pellets.add(new Pellets(x + widthS/2 - widthS/10, y, widthS/5));
    //  counter--;
    //  }

    //}


    //}
    ///   }
  }
  /*
  void checkCollisions()
   {
   for (Brick b : allBricks)
   {
   //  if (x == b.x + b.widthB && y>b.y && y< b.y+b.widthB)
   //{
   
   //  x = b.x + b.widthB;
   //}   
   
   //  if (x+widthS == b.x&& y>b.y && y< b.y+b.widthB)
   //{
   
   //  x = b.x + b.widthB;
   //}       
   
   if (x+widthS > b.x && ship.x < b.x+b.widthB && y + widthS >b.y && y<= b.y+b.widthB)
   {
   counter = 0;
   }
   }
   }
   */
  void checkCollisionsPellet()
  {
    for (Brick b : allBricks)
    {
      for (Pellets p : pellets)
      {
        if (p.x+p.widthB/2 >= b.x && p.x <= b.x+b.widthB && p.y > b.y && p.y < b.y+b.widthB)
        {
          p.isDead = true;
          b.counter--;
          score++;
          levelUpCounter++;
        }
      }
    }
  }
  void checkBounds()
  {
    if (x<0)
    {
      x=0;
    } else if (x+widthS > width)
    {
      x = width-widthS;
    }
  }
}