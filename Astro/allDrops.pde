class AllDrops extends ArrayList<Drops> {


  public AllDrops()
  {
    

  }
  void display()
  {
    for (int i = 0; i < size(); i++)
    {
      Drops drop = get(i);
      drop.display();
    }
  }
  void checkBounds()
  {
    for (int i = 0; i < size(); i++)
    {
      Drops drop = get(i);
      
        drop.checkBounds();
        if (drop.isDead())
        {
          remove(i);
        }
      
    }
  }
    void checkCollisions()
  {
    for (int i = 0; i < size(); i++)
    {
      Drops drop = get(i);
      drop.checkCollision();
    }
  }
  void addDrop(int randomLoc)
  {

      add(new Drops(randomLoc*blockSize + blockSize/2, -blockSize/2, shipWidth/(2.5), (int)(random(maxSize)+1)/4));
  }
}