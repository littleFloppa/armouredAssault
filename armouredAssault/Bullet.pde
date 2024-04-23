
class Bullet {

PImage exImage;
PImage bul;

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector mouse;

  // The Mover's maximum speed
  float topspeed;

  boolean shouldRemove;
/////////CONSTRUCTOR
  Bullet(float offsetX, float offsetY) {
    

 exImage = loadImage("EX1.png");
 bul = loadImage("bullet.png");
    // Start in the center
    

    location = new PVector(p1.endX, p1.endY);
    velocity = new PVector(0, 0);
    
//Jean Mark Wages Code
    mouse = new PVector(mouseX - offsetX, mouseY - offsetY);
    acceleration = PVector.sub(mouse,location);
    topspeed = 20;
        
    shouldRemove = false;
  }
//Shooting function
  void shoot() {
    // Set magnitude of acceleration
   velocity.setMag(10);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
  }
  
//Drawing the bullets
  void render() {
    fill(127);
    image(bul,location.x,location.y,40,40);
  }
//Function that makes the shouldRemove boolean false when a bullet hits an Enemy
  void shootEnemy(Enemy anEnemy){
     if(dist(location.x, location.y, anEnemy.pos.x, anEnemy.pos.y) < 10 + anEnemy.d/2){
image(exImage, anEnemy.pos.x, anEnemy.pos.y, exImage.width*5, exImage.height*5);

   anEnemy.shouldRemove = true;
     }
  }
}
