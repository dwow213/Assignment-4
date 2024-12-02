//Assignment 4
//Assignment 4
//Assignment 4

Character P1;
Character P2;

boolean wPressed = false;
boolean aPressed = false;
boolean sPressed = false;
boolean dPressed = false;

boolean upPressed = false;
boolean leftPressed = false;
boolean downPressed = false;
boolean rightPressed = false;

void setup() {
  size(1280, 1024);

  P1 = new Character("gen", 1);
  P2 = new Character("gen", 2);
}

void draw() {
  background(0);
  P1.display();
  P1.update();
  P2.display();
  P2.update();
}

//function that will set booleans for whether specific keys are pressed to true
void keyPressed() {
  
  //P1 moving upwards
  if (key == 'W' || key == 'w') {
    wPressed = true;
  }
  
  //P2 moving upwards
  if (keyCode == UP) {
    upPressed = true;
  }
  
  //P1 moving left
  if (key == 'A' || key == 'a') {
    aPressed = true;
  }
  
  //P2 moving left
  if (keyCode == LEFT) {
    leftPressed = true;
  }

  //P1 moving downwards
  if (key == 'S' || key == 's') {
    sPressed = true;
  }

  //P2 moving downwards
  if (keyCode == DOWN) {
    downPressed = true;
  }

  //P1 moving right
  if (key == 'D' || key == 'd') {
    dPressed = true;
  }

  //P2 moving right
  if (keyCode == RIGHT) {
    rightPressed = true;
  }
}

//function that will set booleans for whether specific keys are pressed to false
//structured the same exact way as key pressed
void keyReleased() {
  if (key == 'W' || key == 'w') {
    wPressed = false;
  }

  if (keyCode == UP) {
    upPressed = false;
  }

  if (key == 'A' || key == 'a') {
    aPressed = false;
  }

  if (keyCode == LEFT) {
    leftPressed = false;
  }

  if (key == 'S' || key == 's') {
    sPressed = false;
  }

  if (keyCode == DOWN) {
    downPressed = false;
  }

  if (key == 'D' || key == 'd') {
    dPressed = false;
  }

  if (keyCode == RIGHT) {
    rightPressed = false;
  }
}
