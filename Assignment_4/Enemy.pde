class Enemy {
  
  //variable that will allow attacks to be executed
  Attacks attackCore;
  //PImage array for the character animation
  PImage straightSprite[] = new PImage[4];
  //variable for the frame of animation
  int frame;
  //variables for projectile position, velocity and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;
  //variable for the hitbox size of enemy
  int size;
  //variable for the name of enemy
  String name;
  //variable for the health of enemy
  int health;
  //array list that will hold the attacks of the enemy
  ArrayList<String> attacks = new ArrayList<String>();

  //constructor
  Enemy (String tempName) {
    //set name to the parameter accepted
    name = tempName;
    
    //assign values to variables based on name
    if (name == "waste") {
      //starting spot of enemy is at the middle top, with normal velocity and standard acceleration (velocity and acceleration dont really matter rn)
      position = new PVector(640, 200);
      velocity = new PVector(10, 10);
      acceleration = new PVector(1, 1);
      size = 68;
      
      attacks.add("dustSpecks");
    }
    
    //set up attacks, passing enemy's position into the object
    attackCore = new Attacks(position);
    
    //for loop that will load all frames of enemy sprite into array
    for (int i = 0; i < straightSprite.length; i++) {
      straightSprite[i] = loadImage("enemy_" + name + "_straight" + (i + 1) + ".png");
    }

  }
  
  //function that updates the enemy, typically for attacks
  void update() {
    executeAttacks();
  }

  //function that displays the enemy on the screen
  void display() {
    //change image mode so it draws in the middle
    imageMode(CENTER);
    rectMode(CENTER);

    //animation changes every 7 frames
    if (frameCount % 7 == 0) {
      frame = (frame + 1) % straightSprite.length;
    }

    //draw the enemy's sprite on screen
    image(straightSprite[frame], position.x, position.y);
    //rect(position.x, position.y, size, size);
  }
  
  void executeAttacks() {
    if (attacks.get(0) == "dustSpecks") {
      attackCore.dustSpecks();
    }
  }
}
