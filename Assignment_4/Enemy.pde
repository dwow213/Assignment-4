class Enemy {

  //PImage array for the character animation
  PImage straightSprite[] = new PImage[4];
  //variable for the frame of animation
  int frame;
  //variables for projectile position, velocity and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;
  //variable for the name of enemy
  String name;
  //variable for the health of enemy
  int health;

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
    }
    
    //for loop that will load all frames of enemy sprite into array
    for (int i = 0; i < straightSprite.length; i++) {
      straightSprite[i] = loadImage("enemy_" + name + "_straight" + (i + 1) + ".png");
    }

  }

  //function that displays the enemy on the screen
  void display() {
    //change image mode so it draws in the middle
    imageMode(CENTER);

    //animation changes every 7 frames
    if (frameCount % 7 == 0) {
      frame = (frame + 1) % straightSprite.length;
    }

    //draw the enemy's sprite on screen
    image(straightSprite[frame], position.x, position.y);
  }
}
