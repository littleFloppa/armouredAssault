class Medkit {
  //vars
  float mX;
float mY;
int mW;
int mH;

//hitbox vars
    float mTop;
  float mBot;
  float mLeft;
  float mRight;
  
    PImage medkit;
    boolean collected;

    
Medkit(){

  collected = false;
    mX = random(8000);
    mY = random(8000);
    mW = 90;
    mH = 70;
    
    
    
        
    mLeft = mX - mW/2;
    mRight = mX + mW/2;
    mTop = mY - mH/2;
    mBot = mY + mH/2;
    
    
        
    medkit = loadImage("meds.png");
    medkit.resize(mW, mH);
}

  void render(){
    stroke(20);
    fill(0);
    imageMode(CENTER);
    image(medkit, mX, mY);
  }
  
  void collision(Player p1){
        
        // Collision from the right
    if (p1.pTop <= mBot && 
        p1.pBot >= mTop && 
        p1.pLeft < mRight && 
        p1.pRight >= mRight){
        float healthToAdd = min(p1.maxHealth - p1.health, 3);
        p1.health += healthToAdd;
    collected = true;
    heal.play();
  }
    // Player from the left
    else if(p1.pTop <= mBot &&
            p1.pBot >= mTop &&
            p1.pRight > mLeft &&
            p1.pLeft <= mLeft){
        float healthToAdd = min(p1.maxHealth - p1.health, 3);
        p1.health += healthToAdd;
    collected = true;
    heal.play();
    }
    // Player from top
    else if(p1.pLeft <= mRight &&
            p1.pRight >= mLeft &&
            p1.pBot > mTop &&
            p1.pTop <= mTop){
        float healthToAdd = min(p1.maxHealth - p1.health, 3);
        p1.health += healthToAdd;
    collected = true;
    heal.play();
    }
    // Player from bottom
    else if(p1.pLeft <= mRight &&
            p1.pRight >= mLeft &&
            p1.pTop < mBot &&
            p1.pBot >= mBot){
        float healthToAdd = min(p1.maxHealth - p1.health, 3);
        p1.health += healthToAdd;
    collected = true;
    heal.play();
    }
  }
}
