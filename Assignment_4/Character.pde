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
    //when a key is pressed

    //moving left
    if ((aPressed && playerNum == 1) || (leftPressed && playerNum == 2)) {
      position.x -= velocity.x * speedMult;
    }
    //moving right
    if ((dPressed && playerNum == 1) || (rightPressed && playerNum == 2)) {
      position.x += velocity.x * speedMult;
    }

    //moving up
    if ((wPressed && playerNum == 1) || (upPressed && playerNum == 2)) {
      position.y -= velocity.y * speedMult;
    }

    //moving down
    if ((sPressed && playerNum == 1) || (downPressed && playerNum == 2)) {
      position.y += velocity.y * speedMult;
    }
    
    //slowing down
    if ((bPressed && playerNum == 1) || (periodPressed && playerNum == 2)) {
      speedMult = 0.5;
    } else {
      speedMult = 1;
    }
  }
}
