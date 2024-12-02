//Assignment 4
//Assignment 4
//Assignment 4

//variables for player 1 character and player 2 character
Character P1;
Character P2;

//variable for the amount of lives
int lives;

//array list that holds all the projectiles
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

//boolean variables for whether a movement key is pressed
//P1
boolean wPressed = false;
boolean aPressed = false;
boolean sPressed = false;
boolean dPressed = false;

//P2
boolean upPressed = false;
boolean leftPressed = false;
boolean downPressed = false;
boolean rightPressed = false;

//boolean variables for whether slow down is pressed
boolean bPressed = false; //P1
boolean periodPressed = false; //P2

//boolean variables for whether a shooting key is pressed
boolean vPressed = false; //P1
boolean slashPressed = false; //P2

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
  
  for (int i = 0; i < projectiles.size(); i++) {
    projectiles.get(i).display();
    projectiles.get(i).update();
  }
}

//function that sets up the game and makes it ready for play
void reset() {
  lives = 5;
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

  //P1 slowing down
  if (key == 'B' || key == 'b') {
    bPressed = true;
  }

  //P2 slowing down
  if (key == '.') {
    periodPressed = true;
  }

  //P1 shooting
  if (key == 'V' || key == 'v') {
    vPressed = true;
  }

  //P2 shooting
  if (key == '/') {
    slashPressed = true;
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

  //P1 slowing down
  if (key == 'B' || key == 'b') {
    bPressed = false;
  }

  //P2 slowing down
  if (key == '.') {
    periodPressed = false;
  }

  //P1 shooting
  if (key == 'V' || key == 'v') {
    vPressed = false;
  }

  //P2 shooting
  if (key == '/') {
    slashPressed = false;
  }
}
