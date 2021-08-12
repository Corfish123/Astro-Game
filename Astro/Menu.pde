
class Menu {

  //0 is playing button, 1 is sharing page, 2 is rating, 3 is astro name, 4 is facebook
  Button[] allButtons;
  PImage highscoreIcon;
  PVector iconSize;


  Menu()
  {
    //standard size :)
    float widthL = width * .7142857;
    iconSize = new PVector(width*.15, width*.15);

    allButtons = new Button[5];
    allButtons[0] = new Button("playButtonNoBackground.png", new PVector( width*.5 - width*.4142857143/2, height*.35), new PVector(width*.4142857143, width*.4142857143));
    allButtons[1] = new Button("shareButtonNoBackground.png", new PVector(width*.25 - iconSize.x/2, height*.75), iconSize);

    allButtons[2] = new Button("ratingNoBackground.png", new PVector( width*.75-iconSize.x/2, height*.75), iconSize);
    allButtons[3] = new Button("astro.png", new PVector(width * .14285714, height * .1), new PVector(width * .7142857, .2 *width * .7142857));
    allButtons[4] = new Button("facebook.png", new PVector( width*.5-iconSize.x/2, height*.75), iconSize);
     
    highscoreIcon = loadImage("crown.png");
    //startScreen = loadImage(".png");
    //  startScreen = loadImage("playButtonNoBackground.png");
  }
  void display()
  {
    //  image(startScreen, width*.125, width*.5, width*.75, height*.05);
    //      image(startScreen, width*.5 - width*.4142857143/2, height*.3, width*.4142857143, width*.4142857143);

    background(0);
    image(highscoreIcon, width/3, height*.25, width*.09, width*.09);
    fill(255);

    textSize(width*.07);
    text(highscore, width/3 + width*.16, height*.289); 
    
    for (int i = 0; i < allButtons.length; i ++) {
      allButtons[i].display();
    }
  }
  void checkCollision()
  {
    for (int i = 0; i < allButtons.length; i ++) {
      if (allButtons[i].checkCollision())
      {
        if (i==0)
        {
          gamestate = 1;
        } else if (i ==1)
        {
          skinChange = true;
 
          Intent sendIntent = new Intent();
          sendIntent.setAction(Intent.ACTION_SEND);
          sendIntent.putExtra(Intent.EXTRA_TEXT, "I scored " + score + " in Astro! Can you beat me? \nhttps://play.google.com/store/apps/details?id=com.facebook.orca" );
          sendIntent.setType("text/plain");
          startActivity(sendIntent);
        } else if ( i ==2)
        {
          // score += 450;
          // link("https://play.google.com/store/apps/details?id=com.facebook.orca");
        }
        else if(i == 4)
        {
          link("https://www.facebook.com/XenonGamingForLife/?modal=admin_todo_tour");
        }
      }
    }
  }

}