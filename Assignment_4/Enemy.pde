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
  //variable for the max health of enemy
  int maxHealth;
  //array list that will hold the attacks of the enemy
  ArrayList<String> attacks = new ArrayList<String>();

  //constructor
  Enemy (String tempName, PVector tempPosition) {
    //set name to the parameter accepted
    name = tempName;

    //assign values to variables based on name
    //if enemy is waste
    if (name == "waste") {
      //starting spot of enemy is at the middle top, with normal velocity and standard acceleration (velocity and acceleration dont really matter rn)
      position = new PVector(640, 200);
      velocity = new PVector(10, 10);
      acceleration = new PVector(1, 1);
      
      //set size of hitbox
      size = 68;

      //set health and max health
      health = 100;
      maxHealth = 800;

      //add attacks
      attacks.add("dustSpecks");
      attacks.add("garbageDisposal");
      
    //if enemy is fodder used for waste's second attack
    } else if (name == "garbageCan") {
      //starting spot is defined by a attack function, but typically right side, then left side
      position = tempPosition;
      velocity = new PVector(5, 5);
      acceleration = new PVector (0, 0);
      
      //set size of hitbox
      size = 320;

      //set health and max health
      health = 300;
      maxHealth = 300;
      
      attacks.add("garbageCan");
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
    
    //when enemy health runs out
    if (health < 1) {
      //reset the attack core, resetting its timer and direction
      attackCore.reset();
      //remove the current attack from the array list
      attacks.remove(0);
      health = maxHealth;
    }
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

    //draw a red health bar of enemy
    fill(255, 0, 0);
    rect(position.x, position.y - 70, map(health, 0, maxHealth, 0, 200), 20);
  }

  //function that executes the attacks the enemy may have
  void executeAttacks() {
    if (attacks.get(0) == "dustSpecks") {
      attackCore.dustSpecks();
    }
    
    if (attacks.get(0) == "garbageDisposal") {
      attackCore.garbageDisposal();
    }
    
    if (attacks.get(0) == "garbageCan") {
      attackCore.garbageCan();
    }
  }
}
