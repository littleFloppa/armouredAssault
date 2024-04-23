
class Player {
  //////////////////VARS
  float x;
  float y;
  float d;
  
      Player(float x, float y, float d) {
      this.x = x;
      this.y = y;
      this.d = d;
      }
  
  int c;  
  
  int playerSpeed = 10;
  
boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

//Mouse position for barrel
PVector mouse;
PVector center;
  
//Barrel things
float barrelLength;
float barrelAngle;

//Tip of barrel
  float endX;
  float endY;

//Hitboxes
float pTop;
float pBot;
float pLeft;
float pRight;

//Health

float health = 5;
float maxHealth = 5;
float healthBar = 75;

/////////////////////////CONSTRUCTOR

Player(float xPos, float yPos, float diameter, int hue){
//Declaring vars 
  x = xPos;
  y = yPos;
  d = diameter;
  c = hue;
  
  barrelLength = 75;
  
//Declaring hitbox vars 
pLeft = x-d/2;
pRight = x+d/2;
pTop = y-d/2;
pBot = y+d/2;

//Movement booleans
isMovingUp = false;
isMovingDown = false;
isMovingLeft = false;
isMovingRight = false;

    //mouse = new PVector(mouseX - transX, mouseY - transY);
    //center = new PVector(x, y);
}

//Drawing player and barrel
void render(){
//Barrel Direction
  float dx = mouseX - x - transX;
  float dy = mouseY - y - transY;
  
//More Barrel Directtion 
  barrelAngle = atan2(dy, dx);

  endX = x + cos(barrelAngle) * barrelLength;
  endY = y + sin(barrelAngle) * barrelLength;
  
  strokeWeight(15);

//Barrel
  stroke(20);
  line(p1.x, p1.y, endX, endY);

//Player itself
  fill(c);
  strokeWeight(2);
  //ellipse(x, y, d, d);
  fill(200);
  }
  
//Movement function
void movementBooleans(){
  
//Declaring hitbox vars so they move with the player
pLeft = x-d/2;
pRight = x+d/2;
pTop = y-d/2;
pBot = y+d/2;

//Movement statements
    if (isMovingUp == true) {
      y -= playerSpeed;
    } 
    if (isMovingDown == true) {
      y += playerSpeed;
    } 
    if (isMovingLeft == true) {
      x -= playerSpeed;
    } 
    if (isMovingRight == true) {
      x += playerSpeed;
    }

  }

//Collision against walls from player
void barrierCollision(){
//collision with left wall
      if (p1.pLeft < 0){
          p1.isMovingLeft = false;
          p1.x = 0 + p1.d/2 +1;
    }
//right wall
    else if(p1.pRight > 8000){
         p1.isMovingRight = false;
         p1.x = 8000 - p1.d/2-1;
       }
       // player from top
    else if(p1.pBot > 8000){
         p1.isMovingDown = false;
         p1.y = 8000 - p1.d/2 - 1;
       }
       // player from bottom
    else if(p1.pTop < 0){
         p1.isMovingUp = false;
         p1.y = 0 + p1.d/2 + 1;
       }
  }
  
void healthBar(){
   if (health <= 1){
    fill(255, 0, 0);
  }  
  
  else if (health <= 2){
    fill(255, 200, 0);
  }
   else if (health <= 3){
    fill(235, 252, 3);
  }
  
  else if (health <= 4){
    fill(165, 252, 3);
  }
  else
  {
    fill(0, 255, 0);
  }
  
  
  noStroke();
  // Get fraction 0->1 and multiply it by width of bar
  float drawWidth = (health / maxHealth) * healthBar;
  rect(x-35, y+50, drawWidth, 10, 28);
  
  // Outline
  stroke(0);
  noFill();
  rect(100, 100, healthBar, 25);
}

}

 
