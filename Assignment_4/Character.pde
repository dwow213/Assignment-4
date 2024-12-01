class Character {
  
  //PImage array for the character animation
  PImage straightSprite[] = new PImage[3];
  //variable for the frame of animation
  int frame;
  //variable for character movement
  PVector position;
  //variable for how fast the character moves
  PVector velocity;
  //variable for name of character
  String name;
  //variable that determines whether character is P1 or P2
  int playerNum;
  
  //constructor
  Character (String tempName, int tempPlayerNum) {
    //set name to the parameter accepted
    name = tempName;
    //set player number to parameter accepted
    playerNum = tempPlayerNum;
    //set velocity to a set amount of 10 pixels/frame
    velocity = new PVector(10, 10);
    
    //for loop that will load all frames of character sprite into array
    for (int i = 0; i < straightSprite.length; i++) {
      straightSprite[i] = loadImage(name + "_straight" + (i + 1) + ".png");
    }
    
    //set frame to be at start of animation
    frame = 0;
    
    //determines starting position of character based on player assignment
    //if P1 controls this character
    if (playerNum == 1) {
      //place on left side of screen
      position = new PVector(600, 900);
    //if P2 controls this character
    } else {
      //place on right side of screen
      position = new PVector (680, 900);
    }
    
  }
  
  //function that displays the character on the screen
  void display() {
    //change image mode so it draws in the middle
    imageMode(CENTER);
    
    //animation changes every 7 frames
    if (frameCount % 7 == 0) {
      frame = (frame + 1) % straightSprite.length;
    }
    
    //draw the character's sprite on screen
    image(straightSprite[frame], position.x, position.y);
    
  }
  
  void update() {
    
  }
  
  void move() {
    //if (keyPressed) {
      
    }
  }
}
