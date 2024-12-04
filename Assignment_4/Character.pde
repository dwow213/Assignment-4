class Character {

  Attacks attackCore; //variable that will allow attacks to be executed

  PImage straightSprite[] = new PImage[3]; //PImage array for the character animation
  int frame; //variable for the frame of animation

  PVector position; //variable for character position
  PVector velocity; //variable for how fast the character moves
  float speedMult; //variable for multiplies how fast character moves (used for slow down)

  String name; //variable for name of character
  int playerNum; //variable that determines whether character is P1 or P2
  int size; //variable for the size of hitbox

  int ammo; //variable that shows how much bullets character has left
  int maxAmmo; //variable for the max amount of bullets character can have
  boolean shootingExhaustion; //variable for disallowing shooting when using them all

  boolean deadState; //variable for determining whether character is dead
  int revivalProgress; //variable for the progress of revival when dead
  int deathTimer; //variable for the amount of time left to be revived before losing another life

  boolean invincibleState; //variable for determining whether character is invincible and cannot be damaged
  int invincibilityTimer; //variable for the duration of invincibility;

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

    //set up attacks for bombs, passing character's position into the Attack object
    attackCore = new Attacks(position);

    //character starts out alive when initialized
    deadState = false;
    revivalProgress = 0;
    deathTimer = 600; //death timer set to max time (10 seconds)

    //for loop that will load all frames of character sprite into array
    for (int i = 0; i < straightSprite.length; i++) {
      straightSprite[i] = loadImage(name + "_straight" + (i + 1) + ".png");
    }

    //set frame to be at start of animation
    frame = 0;

    //checks the character's name to set values for specific parameters
    //gen has more ammo then blu, but blu has a smaller hitbox
    if (name == "gen") {
      maxAmmo = 500;
      size = 10;
    } else if (name == "blu") {
      maxAmmo = 350;
      size = 7;
    }

    //starting ammo is set to max
    ammo = maxAmmo;

    //allow character to shoot at initialization
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

    //drawing the bar
    //when ammo is not full -
    if (ammo < maxAmmo) {
      //when character did not exhaust their shooting
      if (!shootingExhaustion) {
        //make the bar green
        fill(0, 255, 0, 100);

        //when the character did exhaust their shooting
      } else {
        //make the bar dark green
        fill(0, 65, 0, 100);
      }
      //draw the ammo bar as a rect
      rect(position.x - 65, position.y, 10, map(ammo, 0, maxAmmo, 0, 100));
    }

    //if character is invincible, indicate they're invincible by drawing a green outline around them
    if (invincibleState) {
      fill(0, 0, 0, 0);
      stroke(0, 255, 0);
      rect(position.x, position.y, 100, 100);
      stroke(0); //reset stroke back to 0 so it doesn't affect other shapes drawn
    }

    //if character is dead, draw the revival bar and death timer bar
    if (deadState) {
      //draw the red revival bar
      fill(255, 0, 0, 100);
      rect(position.x, position.y, 100, 100);
      //draw the red death timer bar, whose height is determined by deathTimer
      rect(position.x + 65, position.y, 10, map(deathTimer, 0, 600, 0, 100));
      //draw the green revival bar, whose width is determined by revivalProgress
      fill(0, 255, 0, 100);
      rect(position.x, position.y, map(revivalProgress, 0, 300, 0, 100), 100);
      fill(0); //reset fill back to 0
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
      rect(position.x, position.y, size, size);
    }
  }

  //function that updates the character such as command inputs, revival and invincibility
  void update() {
    //if character isn't dead, accept command input
    if (!deadState) {
      input();
    } else if (lives > 0) { //if character is dead
      //count down death timer by one every frame
      deathTimer -= 1;

      //when deathTimer reaches 0 and there is at least 1 life remaining
      if (deathTimer <= 0) {
        lives -= 1; //lose a life
        deathTimer = 600; //reset death timer
        revivalProgress = 0; //reset revival progress
      }
    }

    //when character has been revived for 5 seconds
    if (revivalProgress >= 300) {
      deadState = false; //revive character
      revivalProgress = 0; //reset the revival progress of character

      invincibleState = true; //turn character invincible
      invincibilityTimer = 0; //reset invincibility timer, so that the invincibility lasts for 3 seconds
    }

    //increase the invincibility timer by 1 every frame
    invincibilityTimer += 1;

    //when 3 seconds has passed, remove invincibility
    if (invincibilityTimer == 180) {
      invincibleState = false;
    }
  }

  //function that handles player input for the character
  void input() {

    //moving left
    if ((aPressed && playerNum == 1) || (leftPressed && playerNum == 2)) {
      //if player hasn't gone offscreen to the left, they can move left
      if (position.x - 32 > 0) {
        position.x -= velocity.x * speedMult;

        //otherwise, don't allow them to move left
      } else {
        position.x = 32;
      }
    }

    //moving right
    if ((dPressed && playerNum == 1) || (rightPressed && playerNum == 2)) {
      //if player hasn't gone offscreen to the right, they can move right
      if (position.x + 32 < 1280) {
        position.x += velocity.x * speedMult;

        //otherwise, don't allow them to move right
      } else {
        position.x = 1248;
      }
    }

    //moving up
    if ((wPressed && playerNum == 1) || (upPressed && playerNum == 2)) {
      //if player hasn't gone offscreen upwards, they can move upwards
      if (position.y - 45 > 0) {
        position.y -= velocity.y * speedMult;

        //otherwise, don't allow them to move up
      } else {
        position.y = 45;
      }
    }

    //moving down
    if ((sPressed && playerNum == 1) || (downPressed && playerNum == 2)) {
      //if player hasn't gone offscreen downwards, they can move downwards
      if (position.y + 90 < 1024) {
        position.y += velocity.y * speedMult;

        //otherwise, don't allow them to move down
      } else {
        position.y = 934;
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
      
      //gen's bullets
      if (name == "gen") {
        //shoots 3 bullets straight, left and right
        projectiles.add(new Projectile("friendly", position.copy(), new PVector(0, -20), new PVector(0, 0), 1, 6, color(0, 255, 0)));
        projectiles.add(new Projectile("friendly", position.copy(), new PVector(15, -20), new PVector(0, 0), 1, 6, color(0, 255, 0)));
        projectiles.add(new Projectile("friendly", position.copy(), new PVector(-15, -20), new PVector(0, 0), 1, 6, color(0, 255, 0)));
      
      //blu's bullets
      } else if (name == "blu") {
        //shoots 3 bullets straight
        projectiles.add(new Projectile("friendly", position.copy(), new PVector(0, -20), new PVector(0, 0), 1, 6, color(0, 255, 0)));
        projectiles.add(new Projectile("friendly", new PVector(position.x + 10, position.y), new PVector(0, -20), new PVector(0, 0), 1, 6, color(0, 255, 0)));
        projectiles.add(new Projectile("friendly", new PVector(position.x - 10, position.y), new PVector(0, -20), new PVector(0, 0), 1, 6, color(0, 255, 0)));
      }

      ammo -= 1; //decrease ammo

      //if ammo is completely depleted, don't allow player to shoot for some time
      if (ammo < 1) {
        shootingExhaustion = true;
      }
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
