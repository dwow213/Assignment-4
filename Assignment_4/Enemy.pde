class Enemy {

  Attacks attackCore; //variable that will allow attacks to be executed

  PImage straightSprite[] = new PImage[4];//PImage array for the character animation
  int frame;//variable for the frame of animation

  //variables for projectile position, velocity and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;

  int size; //variable for the hitbox size of enemy
  String name; //variable for the name of enemy
  boolean bossEnemy; //boolean variable for whether enemy object is a boss enemy or not

  int health; //variable for the health of enemy
  int maxHealth; //variable for the max health of enemy

  //array list that will hold the attacks of the enemy
  ArrayList<String> attacks = new ArrayList<String>();

  //constructor
  Enemy (String tempName, PVector tempPosition, boolean tempBossEnemy) {
    //set name to the parameter accepted
    name = tempName;

    //determine if enemy is fodder or a boss based on accepted parameter
    bossEnemy = tempBossEnemy;

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
      health = 800;
      maxHealth = 800;

      //add attacks
      attacks.add("trashAttack");
      attacks.add("discardedMound");
      attacks.add("garbageDisposal");
      attacks.add("scatteredLitter");
      attacks.add("dustSpecks");

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
      
      //add attacks
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
      //reset hp back to max
      health = maxHealth;

      //check if the enemy is waste
      if (bossEnemy) {
        //remove all hostile projectiles if they are
        for (int i = 0; i < projectiles.size(); i++) {
          if (projectiles.get(i).type == "hostile") {
            projectiles.remove(i);
          }
        }

        //remove all fodder enemies
        for (int i = 0; i < enemies.size(); i++) {
          if (!enemies.get(i).bossEnemy) {
            enemies.remove(i);
          }
        }
      }
    }
  }

  //function that displays the enemy on the screen
  void display() {
    //change image and rect mode so it draws in the middle
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

  //function that executes the first attack enemy has in their attacks array list
  void executeAttacks() {
    if (attacks.get(0) == "trashAttack") {
      attackCore.trashAttack();
    }

    if (attacks.get(0) == "dustSpecks") {
      attackCore.dustSpecks();
    }

    if (attacks.get(0) == "garbageDisposal") {
      attackCore.garbageDisposal();
    }

    if (attacks.get(0) == "garbageCan") {
      attackCore.garbageCan();
    }

    if (attacks.get(0) == "scatteredLitter") {
      attackCore.scatteredLitter();
    }
    
    if (attacks.get(0) == "discardedMound") {
      attackCore.discardedMound();
    }
  }
}
