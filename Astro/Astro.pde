
//import for sound 
//acutall

import ketai.sensors.*;  


import android.content.res.AssetFileDescriptor;
import android.media.MediaPlayer;
import android.content.Context;
import android.app.Activity;
import android.media.SoundPool;
import android.media.AudioManager;

//save highscore stuff
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

//share stuff
import android.widget.ShareActionProvider;
import android.view.MenuItem;
import android.view.ActionProvider;
import android.widget.ShareActionProvider;
import android.content.Intent;
import android.content.res.Resources;



//screen tilting stuff
KetaiSensor sensor;  
float  accelerometerX = 0, accelerometerY = 0, accelerometerZ = 0;


//music stuff
MediaPlayer player;
Context context; 
Activity act;
AssetFileDescriptor afd;

SoundPool soundPool;  
HashMap<Object, Object> soundPoolMap;
AssetFileDescriptor shipExplosion, logoMusic;
int s1, s2;
int streamId;

AllBricks allBricks;
AllDrops allDrops;
int padding, blockSize;
int maxSize;
Ship ship;
int shipWidth;
//gamestate 1000 is logo, 0 is loading screen, 1 is playing,2 is dead,3 is pause
int gamestate;
float speed;
float speedCounter;
int wtf;
//add the bricks and drops
float addRow;
float addRandom;


//check to make sure u level up
int levelUpCounter;

int score;
int highscore;
boolean skinChange;


PImage startScreen;
PImage gameoverSign;
PImage[] logo;

//TUTORIAL GUIDE
PImage[] tiltingPhone;
int timesPlayed;
int frameCounter = 0;
//pause button
Pause pause;

//menu
Menu menu;

void setup()
{
  fullScreen();

  //size(500, 700);


  orientation(PORTRAIT);
  initializingVariables();

  //set up music
  setupMusic();

  //set up screen tilt
  sensor = new KetaiSensor(this);  
  sensor.start();  

  //load highscore
  loadData();

  frameRate(50);
}


void draw() {

  if (gamestate == 1000)
  {
    createLogo();
  } else if (gamestate == 0)
  {

    // image(startScreen, 0, 0, width, height);
    menu.display();
  } else if (gamestate == 1)
  {
   // gamestate = 4;
    background(0);


    showTextAndScores();

    //increasing the speed of game
    speedUp();


    allDrops.display();
    allDrops.checkBounds();
    allDrops.checkCollisions();


    allBricks.display();
    allBricks.checkBounds();
    allBricks.checkCollisions();
    addStuff();

    ship.display();
    ship.checkBounds();
    ship.checkCollisionsPellet();
    
    
    //pause actions
    pause.display();
    pause.checkCollision();
    if (ship.isDead())
    {
      gamestate = 2;
      //  background(0);
    }
  } else if (gamestate == 2)
  {//player dies


    if (score > highscore)
    {
      highscore = score;
    }

    background(0);
    fill(255);

    image(gameoverSign, width * .14285714, height * .1, width * .7142857, .14 *width * .7142857);

    image(menu.highscoreIcon, width*.2, height*.35, width * .132, width * .132);

    fill(255);
    textAlign(CENTER);
    textSize(width * .1);
    text(highscore, width*.23 + width * .264, height*.407 ); 

    textSize(width * .22);
    text(score, width*.23 + width * .264, height *.58 );



    //gameover
  } else if (gamestate == 3)//pause 
  {
    pause.display();
  }
  else if(gamestate == 4)
  {
      tiltingTutorial();
  }
 
}
void mousePressed()
{
  if (gamestate == 2)//gameover state
  {
    reset();


    gamestate = 0;
  } else if (gamestate == 0)//menu
  {
    menu.checkCollision();
  } else  if (gamestate == 3)//pause menu
  {
    pause.checkCollision();
  } else if(gamestate == 4)
  {
   gamestate = 1; 
  }
}