
import processing.sound.*;

//Class call
Player p1;
ArrayList<Enemy> enemyList;
Enemy e1;
Enemy e2;
ArrayList<Obstacle> obstacleList;
ArrayList<Bullet> bulletList;
ArrayList<Medkit> medList;

//Timer Vars
int startTime;
int endTime;
int interval = 5000;
boolean isState = true;

//Size Vars
float transX;
float transY;

//Sound
SoundFile pew;
SoundFile soundTrack;
SoundFile hit;
SoundFile dead;
SoundFile title;
SoundFile heal;

//State and screen vars
int state = 0;

PImage titleScreen;
PImage deathScreen;
PImage bg;
PImage atk;

PImage tankUp, tankDown, tankLeft, tankRight;
PImage tankUpLeft, tankUpRight, tankDownLeft, tankDownRight;
PImage currentTankImage;


//Timer vars
int lastHitTime = 0;

int immunityDuration = 1000;

int score;

void setup() {
  
  smooth(6);
  frameRate(120);
  
    size(1200, 800);

  pew = new SoundFile(this, "pew1.wav");
  soundTrack = new SoundFile(this, "Rules of Engagement.mp3");
  hit = new SoundFile(this, "Collision.mp3");
  dead = new SoundFile(this, "deathSound.mp3");
  title = new SoundFile(this, "Title Screen Music.mp3");
  heal = new SoundFile(this, "health.mp3");

 reset();


  titleScreen = loadImage("Title Screen.png");
  deathScreen = loadImage("Death Screen.png");
  bg = loadImage("map.jpg");
  atk = loadImage("UFO10.png");

  tankUp = loadImage("sprite_0.png");
  tankDown = loadImage("sprite_4.png");
  tankLeft = loadImage("sprite_2.png");
  tankRight = loadImage("sprite_6.png");
  tankUpLeft = loadImage("sprite_1.png");
  tankUpRight = loadImage("sprite_7.png");
  tankDownLeft = loadImage("sprite_3.png");
  tankDownRight = loadImage("sprite_5.png");
  currentTankImage = tankUp; // Initial tank image
  
  title.play();
}


void draw() {
  //Movement change
  transX = width/2 - p1.x;
  transY = height/2 - p1.y;
  translate(transX, transY);


  background(50);
  image(bg, 4000, 4000);

  switch(state) {

  case 0:

    drawMenuScreen();
    reset();

    break;

  case 1:

    //Stop title music
    title.stop();

    //Boundaries
    line(0, 0, 0, 8000);

    line(0, 0, 8000, 0);

    line(8000, 0, 8000, 8000);

    line(0, 8000, 8000, 8000);


    if (soundTrack.isPlaying() == false) {
      soundTrack.play();
    }
    //Score
    showScore();


      // Draw tank based on movement direction
      if (p1.isMovingUp) {
        if (p1.isMovingLeft) {
          currentTankImage = tankUpLeft;
        } else if (p1.isMovingRight) {
          currentTankImage = tankUpRight;
        } else {
          currentTankImage = tankUp;
        }
      } else if (p1.isMovingDown) {
        if (p1.isMovingLeft) {
          currentTankImage = tankDownLeft;
        } else if (p1.isMovingRight) {
          currentTankImage = tankDownRight;
        } else {
          currentTankImage = tankDown;
        }
      } else if (p1.isMovingLeft) {
        currentTankImage = tankLeft;
      } else if (p1.isMovingRight) {
        currentTankImage = tankRight;
      }

      // Display tank image
      image(currentTankImage, p1.x, p1.y, 500, 500);

    //Player Functions
    p1.healthBar();
    p1.render();
    p1.movementBooleans();
    p1.barrierCollision();


    for (Obstacle anObstacle : obstacleList) {
      anObstacle.render();
      anObstacle.collision(p1);
    }

  for(Medkit aMedkit : medList){
    aMedkit.render();
    aMedkit.collision(p1);
  }
  
 for (int i = medList.size() - 1; i >= 0; i--) {
     Medkit aMedkit = medList.get(i);
      if (aMedkit.collected == true) {
        medList.remove(aMedkit);

      }
      }

    //Enemy functions
    for (Enemy anEnemy : enemyList) {
      anEnemy.render();
      anEnemy.update();
    }
    //Spawn players
    if (score <= 10000) {
      if (enemyList.size() <= 10) {
        enemyList.add(new Enemy());
      }
    } 
    else if (score > 10000) {
      if (enemyList.size() <= 15) {
        enemyList.add(new Enemy());
      }
    }
    else if (score > 20000) {
      if (enemyList.size() <= 20) {
        enemyList.add(new Enemy());
      }
    }
        else if (score > 30000) {
      if (enemyList.size() <= 30) {
        enemyList.add(new Enemy());
      }
    }

    //calling functions
    //Enemy collision with player
    for (Enemy anEnemy : enemyList) {
      collision(anEnemy);
    }


    //Delete bullets after they go off screen
    delBullets();


    //Remove enemies if shot
    for (int i = enemyList.size() - 1; i >= 0; i--) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        score += 100;
      }
    }

    break;

  case 2:

    soundTrack.stop();
    deathScreen();

    break;
  }
}

//Menu screen
void drawMenuScreen() {

  background(60);
  imageMode(CENTER);
  fill(255);
  image(titleScreen, 4000, 4000);
}

//Death screen
void deathScreen() {
  background(60);
  imageMode(CENTER);
  textAlign(CENTER);
  fill(255);
  textSize(100);
  fill(255);
  image(deathScreen, p1.x, p1.y);
  textSize(30);
//Text that shows final score
  text("Your score was: " + score, p1.x-450, p1.y-350);

}

// Movement functions
void keyPressed() {
  if (key == ' ') {
    state = 1;
    println("space pressed");
    // Obstacle/medkit spawning to remove lag at the start of game
 while (obstacleList.size() <= 100) {
      obstacleList.add(new Obstacle());
    }
    
 while (medList.size() <= 15) {
      medList.add(new Medkit());
    }
  }
  
  if (key == 'm') {
    state = 0;
  }
  if (key == 'w') {
    p1.isMovingUp = true;
  }
  if (key == 's') {
    p1.isMovingDown = true;
  }
  if (key == 'a') {
    p1.isMovingLeft = true;
  }
  if (key == 'd') {
    p1.isMovingRight = true;
  }
}
//More movement functions
void keyReleased() {
  if (key == 'w') {
    p1.isMovingUp = false;
  }
  if (key == 's') {
    p1.isMovingDown = false;
  }
  if (key == 'a') {
    p1.isMovingLeft = false;
  }
  if (key == 'd') {
    p1.isMovingRight = false;
  }
}

//Shooting fucntion
void mousePressed() {
  bulletList.add(new Bullet(transX, transY));
  pew.play();
}


//Enemy and player Collision
void collision(Enemy anEnemy) {  
//Attack animation
if (dist(p1.x, p1.y, anEnemy.pos.x, anEnemy.pos.y) < p1.d/2 + anEnemy.d/2 && p1.health > 0) {
      // Reduce player's health
      image(atk, anEnemy.pos.x, anEnemy.pos.y, atk.width*5, atk.height*5);
    }
    else{
    }
    
// Check if player is currently immune
if (millis() - lastHitTime > immunityDuration) {
    // Check for collision
   if (dist(p1.x, p1.y, anEnemy.pos.x, anEnemy.pos.y) < p1.d/2 + anEnemy.d/2 && p1.health > 0) {
      // Reduce player's health
      p1.health -= 1;
      hit.play();
      // Set last hit time to current time for immunity
      lastHitTime = millis();
    }
  } 
  
else if (p1.health <= 0) {
    soundTrack.stop();
    state = 2;
    dead.play();
  }
}


//Function that deletes bullets that go off screen
void delBullets() {
  ArrayList<Bullet> bulletsToRemove = new ArrayList<>(); 

  for (int i = bulletList.size() - 1; i >= 0; i--) {
    Bullet b = bulletList.get(i);
    b.render();
    b.shoot();

//If a bullet hits a player, add it to the to remove list
    for (Enemy anEnemy : enemyList) {
      b.shootEnemy(anEnemy);
      if (anEnemy.shouldRemove) {
        bulletsToRemove.add(b); 
      }
    }
    
    // Remove bullets that have gone off-screen
    if (dist(p1.x, p1.y, b.location.x, b.location.y) > 2000) {
      bulletsToRemove.add(b);
    }
  }

  // Remove bullets outside the loop
  for (Bullet bullet : bulletsToRemove) {
    bulletList.remove(bullet);
  }
}


//Score function that displays score on screen
void showScore() {
  textAlign(CENTER);
  fill(255);
  textSize(40);
  text(score, p1.x-550, p1.y+350);
}


//Reset class that resets parts of the setup
void reset(){
 score = 0;

  startTime = millis();

  //Player Class
  p1 = new Player(4000, 4000, 75, color(0, 200, 0));

  //Obstacle ArrayList
  obstacleList = new ArrayList<Obstacle>();

  //Enemy Class

  enemyList= new ArrayList<Enemy>();

  //Bullet Array List
  bulletList = new ArrayList<Bullet>();
  
//Medkit arrayList
  medList = new ArrayList<Medkit>();

}
