
class AllBricks extends ArrayList<Brick> {

  public AllBricks()
  {
    for (int i = 0; i < 4; i ++)
    {
      Brick temp = new Brick(padding + (padding + blockSize)*i, 0, blockSize, (int)(random(maxSize)+1));
      add(temp);
    }
  }
  void display()
  {
    for (int i = 0; i < size(); i++)
    {
      Brick brick = get(i);
      brick.display();
    }
  }
  void checkBounds()
  {
    for (int i = 0; i < size(); i++)
    {
      Brick brick = get(i);
      brick.checkBounds();
      if (brick.isDead())
      {
        remove(i);
      }
    }
  }
  void checkCollisions()
  {
    for (int i = 0; i < size(); i++)
    {
      Brick b= get(i);
      //  if (x == b.x + b.widthB && y>b.y && y< b.y+b.widthB)
      //{

      //  x = b.x + b.widthB;
      //}   

      //  if (x+widthS == b.x&& y>b.y && y< b.y+b.widthB)
      //{

      //  x = b.x + b.widthB;
      //}       
      //if (ship.x+ship.widthS > b.x && ship.x < b.x+b.widthB && ship.y + ship.widthS >b.y && ship.y<= +b.widthB)
      //{
      //  ship.counter = 0;
      //}
      b.checkCollision();
    }
  }
  void addBricks(int randomLoc)
  {
      Brick temp = new Brick(padding + (padding + blockSize)*randomLoc, -blockSize, blockSize, (int)(random(maxSize)+1));
       add(temp);
  }
  void addRows()
  {
    for (int i = 0; i < 4; i ++)
    {
      Brick temp = new Brick(padding + (padding + blockSize)*i, -blockSize, blockSize, (int)(random(maxSize)+1));
      add(temp);
    } 
  }
}