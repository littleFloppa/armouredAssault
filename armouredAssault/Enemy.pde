
class Enemy {
  //////////////////VARS
 PVector pos;
 PVector vel;
 PVector acc;
 int d;
 float speed = random(8,14);
 
float Top;
float Bot;
float Left;
float Right;

boolean shouldRemove;

int quadrant;

// Define variables for enemy position
float enemyX, enemyY;

PImage[] ufoImages = new PImage[8];
Animation ufoAnimation;

/////////////////////////CONSTRUCTOR

Enemy(){
 
quadrant = int(random(4));
d = 75;

if (quadrant == 0) {
  // Top-left quadrant
  enemyX = random(p1.x - 800, p1.x - 600);
  enemyY = random(p1.y - 700, p1.y - 500);
} else if (quadrant == 1) {
  // Top-right quadrant
  enemyX = random(p1.x + 600, p1.x + 800);
  enemyY = random(p1.y - 700, p1.y - 500);
} else if (quadrant == 2) {
  // Bottom-left quadrant
  enemyX = random(p1.x - 800, p1.x - 600);
  enemyY = random(p1.y + 500, p1.y + 700);
} else {
  // Bottom-right quadrant
  enemyX = random(p1.x + 600, p1.x + 800);
  enemyY = random(p1.y + 500, p1.y + 700);
}
pos = new PVector(enemyX, enemyY);
  
vel = new PVector(0, 0);
acc = new PVector(0, 0);


 for(int i=0; i<ufoImages.length; i++){
   ufoImages[i] = loadImage("UFO" + i + ".png");
 }

//Initialize my animation

 ufoAnimation = new Animation(ufoImages, 0.1, 5.0);
 
  ufoAnimation.isAnimating = true;
}



void render(){
  imageMode(CENTER);

  stroke(0);
  strokeWeight(2);
  fill(255, 0, 0);
  //image(ufoImages, pos.x, pos.y, ufoImages.width*5, ufoImages.height*5);
ufoAnimation.display(pos.x, pos.y);
ufoAnimation.next();
 
 ufoAnimation.isAnimating = true;
  
  shouldRemove = false;
  }


void update(){

  PVector player = new PVector(p1.x, p1.y);
  PVector dir = PVector.sub(player, pos);
  
  dir.normalize();
  
  acc = dir;
  
  vel.add(acc);
  vel.limit(speed);
  pos.add(vel);
  
 }
 }

 
