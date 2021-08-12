//set up the music and sounds
void setupMusic()
{
  //set up essential part for music playing
  act = this.getActivity();
  context = act.getApplicationContext();

  //set up media player
  try {
    player = new MediaPlayer();
    afd = context.getAssets().openFd("test.mp3");//which is in the data folder

    player.setDataSource(afd.getFileDescriptor(), afd.getStartOffset(), afd.getLength());
    player.prepare();
  } 
  catch(IOException e) {
    println("file did not load");
  }
  player.setVolume(1.0, 1.0);

  // set up soundPool
  try {
    shipExplosion = context.getAssets().openFd("Explosion Of Ship.mp3");
    logoMusic = context.getAssets().openFd("logo thunder.mp3");
  } 
  catch(IOException e) {
    println("error loading files:" + e);
  }

  // create the soundPool HashMap - apparently this constructor is now depracated?
  soundPool = new SoundPool(12, AudioManager.STREAM_MUSIC, 0);
  soundPoolMap = new HashMap<Object, Object>(2);

  soundPoolMap.put(s1, soundPool.load(logoMusic, 1)); 
  soundPoolMap.put(s2, soundPool.load(shipExplosion, 1));
}


//make a rectangle
void rectt(float x, float y, float w, float h, float r, color c) { 
  fill(c); 
  rect(x, y, w, h, r);
}
//addes text 
void textt(String t, float x, float y, float w, float h, color c, float s, int align) {
  fill(c); 
  textAlign(align); 
  textSize(s); 
  text(t, x, y, w, h);
}
void addStuff()
{

  if (addRow % (height * 2) < speed)
  { 
    allBricks.addRows();
  } else if (addRow % (height/2) < speed)
  {

    int interations = (int)(random(2, 5));

    int[] checkArray = new int[4];

    for (int i = 0; i<interations; i++)
    {
      int checkType = (int)(Math.random()*4);

      int randomLoc;

      do {
        randomLoc = (int)(Math.random()*4);
      } while (checkArray[randomLoc]==1);

      checkArray[randomLoc]=1;

      if (checkType<1)
      {

        allBricks.addBricks(randomLoc);
      } else if (checkType<2)
      {
        allDrops.addDrop(randomLoc);
      }
    }
  }
}
void createLogo()
{
  if (height>width)
  {
    background(0);
    float widthL = width * .7142857;
    image(logo[0], width * .14285714, height * .001, widthL, .7 *widthL );

    if (frameCount>=121)
    {
      streamId =  soundPool.play(1, 1.0, 1.0, 1, 0, 1f);
    }
    if (frameCount>=122)
    {
      image(logo[1], 0, 0, width, height);
    }
    if (frameCount>=126)
    {
      image(logo[2], 0, 0, width, height);
      image(logo[0], width * .14285714, height * .001, widthL, .7 *widthL );
      image(logo[4], width*.1428571429, height*.4, width*.7142857143, width*.7142857143);
      soundPool.stop(streamId);
    }
    if (frameCount>=170)
    {
      gamestate = 0;
    }
  }
}
void tiltingTutorial() {
  float heightTilt =  height * .35;
  float widthTilt = displayWidth /2;
  frameCounter++;
  frameCounter = frameCounter%tiltingPhone.length;
  if (frameCounter == 0) {
    image(tiltingPhone[frameCounter], displayWidth/4, height/10, widthTilt, heightTilt);
  }
  if (frameCounter == 1) {
    image(tiltingPhone[frameCounter], displayWidth/4, height/10, widthTilt, heightTilt);
  }
  if (frameCounter == 2) {
    image(tiltingPhone[frameCounter], displayWidth/4, height/10, widthTilt, heightTilt);
  }
  if (frameCounter == 3) {
    image(tiltingPhone[frameCounter], displayWidth/4, height/10, widthTilt, heightTilt);
  }
}
public void pause() {
  super.pause();
  if (player !=null) {
    player.release();
    player = null;
  }
};

public void stop() {
  super.stop();
  if (player !=null) {
    player.release();
    player = null;
  }
};
void playSound(int soundID)
{
  // play(int soundID, float leftVolume, float rightVolume, int priority, int loop, float rate)

  soundPool.stop(streamId); // kill previous sound - quick hack to void mousePressed triggering twice
  streamId = soundPool.play(soundID, 1.0, 1.0, 1, 0, 1f);
}
//for screen tilting 
void onAccelerometerEvent(float x, float y, float z)   
{  
  accelerometerX = x;
  accelerometerY  =  y;    
  accelerometerZ  =  z;
}  

//for uploading highscore
void saveData() {
  SharedPreferences sharedPreferences;
  SharedPreferences.Editor editor;
  Activity act;
  act = this.getActivity();
  sharedPreferences = PreferenceManager.getDefaultSharedPreferences(act.getApplicationContext()); 
  editor = sharedPreferences.edit();
  editor.putInt("Highscore", highscore);
  editor.commit();
}
void loadData() {
  SharedPreferences sharedPreferences;
  Activity act;
  act = this.getActivity();
  sharedPreferences = PreferenceManager.getDefaultSharedPreferences(act.getApplicationContext()); 
  highscore = sharedPreferences.getInt("Highscore", highscore);
}
void reset() {

  background(0);
  ship.x=  (width/2)-(shipWidth/2);
  ship.y = height/10*9;
  allBricks = new AllBricks(); 
  allDrops.clear();
  ship.pellets.clear();
  ship.counter = 100;
  speed = height/200;
  speedCounter = 10;

  levelUpCounter = 0;

  saveData();
  score = 0;
  delay(100);
}
void initializingVariables()
{

  startScreen = loadImage("default startscreen.png");
  startScreen.resize(width, height);
  imageMode(CORNER);
  ellipseMode(CORNER);
  noStroke();
  gamestate = 1000;
  speed = height/200;
  speedCounter =10;

  addRow = 0;
  addRandom = 0;

  padding = width/500;
  blockSize = (int)(width/(4.04));
  maxSize = 50;
  shipWidth = blockSize/2;
  allBricks = new AllBricks();
  allDrops = new AllDrops();
  pause = new Pause();
  menu = new Menu();
  score = 0;
  levelUpCounter= 0;
  gameoverSign = loadImage("gameover.png");
  textAlign(CENTER);

  background(0);
  //animation
  logo = new PImage[5];

  //lighter one //starting screen
  for (int i = 0; i < logo.length; i++) {
    String filename = "startScreen" + i + ".gif";
    logo[i] = loadImage(filename);
  }

  //tilting phone
  tiltingPhone = new PImage[4];

  for (int i = 0; i < tiltingPhone.length; i++) {
    String filename = "tilt" + i + ".gif";
    tiltingPhone[i] = loadImage(filename);
  }
  ship = new Ship((width/2)-(shipWidth/2), height/10*9, shipWidth);
}
void showTextAndScores() {

  //score
  textSize(width*.075);

  fill(255);
  text(score, width*.1, width*.1);
}
void speedUp()
{
  addRow += speed;
  addRandom += speed;

  if (levelUpCounter > 200)
  {
    levelUpCounter = 0;
    if (score <= 2000)
    {


      speed = (float)(height/(200 - speedCounter));
    } else
    {
      speed = (float)(height/(160 - Math.sqrt(score)));

      //      float ratio = (height/160)/(speed);
      //      addSpeed = (int) (400 *ratio);
    }  
    score++;
  }
}