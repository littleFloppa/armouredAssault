class Obstacle {
  // vars
  float x;
  float y;
  int w;
  int h;



  color fillColor;
  
  // Hitbox vars
  float oTop;
  float oBot;
  float oLeft;
  float oRight;
  
  
  PImage image;

  
  ////////Constructor
  Obstacle(){
    // Initialize obstacle vars
    x = random(8000);
    y = random(8000);
    w = int(random(100,200));
    h = int(random(100,200));
    fillColor = 0;

    
    
    // Initialize hitbox vars   
    oLeft = x - w/2;
    oRight = x + w/2;
    oTop = y - h/2;
    oBot = y + h/2;

    
    image = loadImage("wall.png");
    
    image.resize(w, h);

  }
   
  // Draw barriers 
  void render(){
    stroke(20);
    fill(0);
    imageMode(CENTER);
    image(image, x,y);
  }
  
  // Collision against barrier from player
  void collision(Player p1){
    // Collision from the right
    if (p1.pTop <= oBot && 
        p1.pBot >= oTop && 
        p1.pLeft < oRight && 
        p1.pRight >= oRight){
      p1.isMovingLeft = false;
      p1.x = oRight + p1.d/2 + 1;
    }
    // Player from the left
    else if(p1.pTop <= oBot &&
            p1.pBot >= oTop &&
            p1.pRight > oLeft &&
            p1.pLeft <= oLeft){
      p1.isMovingRight = false;
      p1.x = oLeft - p1.d/2 - 1;
    }
    // Player from top
    else if(p1.pLeft <= oRight &&
            p1.pRight >= oLeft &&
            p1.pBot > oTop &&
            p1.pTop <= oTop){
      p1.isMovingDown = false;
      p1.y = oTop - p1.d/2 - 1;
    }
    // Player from bottom
    else if(p1.pLeft <= oRight &&
            p1.pRight >= oLeft &&
            p1.pTop < oBot &&
            p1.pBot >= oBot){
      p1.isMovingUp = false;
      p1.y = oBot + p1.d/2 + 1;
    }
    
  }
}
