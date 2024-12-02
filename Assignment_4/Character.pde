class Character {

  //PImage array for the character animation
  PImage straightSprite[] = new PImage[3];
  //variable for the frame of animation
  int frame;
  //variable for character position
  PVector position;
  //variable for how fast the character moves
  PVector velocity;
  //variable for multiplies how fast character moves (used for slow down)
  float speedMult;
  //variable for name of character
  String name;
  //variable that shows how much bullets character has left
  int ammo;
  //variable for the max amount of bullets character can have
  int maxAmmo;
  //variable for disallowing shooting when using them all
  boolean shootingExhaustion;
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
    //set the speed multiplier to 1, not affecting velocity at all
    speedMult = 1;

    //for loop that will load all frames of character sprite into array
    for (int i = 0; i < straightSprite.length; i++) {
      straightSprite[i] = loadImage(name + "_straight" + (i + 1) + ".png");
    }

    //set frame to be at start of animation
    frame = 0;

    //checks the character's name to set values for specific parameters
    if (name == "gen") {
      maxAmmo = 500;
    }

    //starting ammo is set to max
    ammo = maxAmmo;
    
    shootingExhaustion = false;

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
    rectMode(CENTER);

    //animation changes every 7 frames
    if (frameCount % 7 == 0) {
      frame = (frame + 1) % straightSprite.length;
    }

    //draw the character's sprite on screen with rotation in mind
    //set up for rotation with pushing matrix and translating
    pushMatrix();
    translate(position.x, position.y);

    //if character is moving to the left, rotate sprite to the left
    if ((aPressed && playerNum == 1) || (leftPressed && playerNum == 2)) {
      rotate(radians(-45));

      //if character is moving to the right, rotate sprite to the right
    } else if ((dPressed && playerNum == 1) || (rightPressed && playerNum == 2)) {
      rotate(radians(45));
    }

    //draw the character's sprite on screen
    image(straightSprite[frame], 0, 0);

    popMatrix(); //end of matrix

    //draw the hitbox on character
    //if character is slowing down
    if (speedMult < 1) {
      //draw a red rect in the middle of character
      fill(255, 0, 0);
      rect(position.x, position.y, 10, 10);
    }
  }

  //function that updates the character (currently only used for move)
  void update() {
    move();
  }

  //function that handles the movement of the character
  void move() {

    //moving left
    if ((aPressed && playerNum == 1) || (leftPressed && playerNum == 2)) {
      //if player hasn't gone offscreen to the left, they can move left
      if (position.x > 0) {
        position.x -= velocity.x * speedMult;

        //otherwise, don't allow them to move left
      } else {
        position.x = 0;
      }
    }

    //moving right
    if ((dPressed && playerNum == 1) || (rightPressed && playerNum == 2)) {
      //if player hasn't gone offscreen to the right, they can move right
      if (position.x < 1280) {
        position.x += velocity.x * speedMult;

        //otherwise, don't allow them to move right
      } else {
        position.x = 1280;
      }
    }

    //moving up
    if ((wPressed && playerNum == 1) || (upPressed && playerNum == 2)) {
      //if player hasn't gone offscreen upwards, they can move upwards
      if (position.y > 0) {
        position.y -= velocity.y * speedMult;

        //otherwise, don't allow them to move up
      } else {
        position.y = 0;
      }
    }

    //moving down
    if ((sPressed && playerNum == 1) || (downPressed && playerNum == 2)) {
      //if player hasn't gone offscreen downwards, they can move downwards
      if (position.y < 1024) {
        position.y += velocity.y * speedMult;

        //otherwise, don't allow them to move down
      } else {
        position.y = 1024;
      }
    }

    //slowing down
    if ((bPressed && playerNum == 1) || (periodPressed && playerNum == 2)) {
      speedMult = 0.5;

    //reset speed back to normal when not pressing the slow down key
    } else {
      speedMult = 1;
    }
    
    //shooting
    //only shoots when ammo is over 0
    if (((vPressed && playerNum == 1) || (slashPressed && playerNum == 2)) && ammo > 0 && !shootingExhaustion) {
      projectiles.add(new Projectile("friendly", position.copy(), new PVector(0, -20), new PVector(0, 1), 1, 5, color(0, 255, 0)));
      ammo -= 1; //decrease ammo
      
      if (ammo < 1) {
        shootingExhaustion = true;
      }
      
      println(ammo);
    } else { //regenerates ammo when not shooting
      //every second, ammo will be restored
      if (frameCount % 60 == 0) {
        //if ammo is not full
        if (ammo < maxAmmo) {
          //restore 10% of ammo
          ammo += (maxAmmo * 0.1);
        } else { //set ammo to max so it doesn't regenerate over the max
          ammo = maxAmmo;
        }
      }
      
      //when ammo is at 50%, allow character to shoot again
      if (ammo >= (maxAmmo * 0.5)) {
        shootingExhaustion = false;
      }
    }
  }
}
