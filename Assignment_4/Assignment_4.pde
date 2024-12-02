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

//array list that holds the all the enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

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
  frameRate(60);
  //set up game and make it ready for play
  reset();
}

void draw() {
  background(100);
  //display and update the player characters
  P1.display();
  P1.update();
  P2.display();
  P2.update();

  //display and update boss enemy

  //for loop that display and update enemies
  for (int a = 0; a < enemies.size(); a++) {
    enemies.get(a).display();
    enemies.get(a).update();

    //for loop that handles the projectiles
    for (int i = 0; i < projectiles.size(); i++) {
      //displays and updates all of the projectiles
      projectiles.get(i).display();
      projectiles.get(i).update();

      //if a projectile is offscreen, destroy it
      if (projectiles.get(i).position.x < -200 || projectiles.get(i).position.x > 1500 || projectiles.get(i).position.y < -200 || projectiles.get(i).position.y > 1300) {
        projectiles.remove(i);
      } else { //otherwise, check if it is in a hitbox

        //if the projectile is a player bullet
        if (projectiles.get(i).type == "friendly") {

          //check if the bullet is within the enemy's hitbox
          if (projectiles.get(i).position.x + projectiles.get(i).size / 2 > enemies.get(a).position.x - enemies.get(a).size / 2 && projectiles.get(i).position.x - projectiles.get(i).size / 2 < enemies.get(a).position.x + enemies.get(a).size / 2 && projectiles.get(i).position.y + projectiles.get(i).size / 2 > enemies.get(a).position.y - enemies.get(a).size / 2 && projectiles.get(i).position.y - projectiles.get(i).size / 2 < enemies.get(a).position.y + enemies.get(a).size / 2) {
            projectiles.remove(i); //remove the projectile
            enemies.get(a).health -= 1; //decrease the boss's hp
            println("hit enemy");
          }

          //if the projectile is an enemy bullet
        } else if (projectiles.get(i).type == "hostile") {

          //check if the bullet is within P1's hitbox
          if (projectiles.get(i).position.x + projectiles.get(i).size / 2 > P1.position.x - P1.size / 2 && projectiles.get(i).position.x - projectiles.get(i).size / 2 < P1.position.x + P1.size / 2 && projectiles.get(i).position.y + projectiles.get(i).size / 2 > P1.position.y - P1.size / 2 && projectiles.get(i).position.y - projectiles.get(i).size / 2 < P1.position.y + P1.size / 2) {
            projectiles.remove(i); //remove the projectile
            lives -= 1; //decrease the amount of lives
            println("hit player 1");

            //check if the bullet is within P2's hitbox
          } else if (projectiles.get(i).position.x + projectiles.get(i).size / 2 > P2.position.x - P2.size / 2 && projectiles.get(i).position.x - projectiles.get(i).size / 2 < P2.position.x + P2.size / 2 && projectiles.get(i).position.y + projectiles.get(i).size / 2 > P2.position.y - P2.size / 2 && projectiles.get(i).position.y - projectiles.get(i).size / 2 < P2.position.y + P2.size / 2) {
            projectiles.remove(i); //remove the projectile
            lives -= 1; //decrease the amount of lives
            println("hit player 2");
          }
        }
      }
    }

    //if an enemy is offscreen or has no more attacks (lost all hp), destroy it
    if ((enemies.get(a).position.x < -200 || enemies.get(a).position.x > 1500 || enemies.get(a).position.y < -200 || enemies.get(a).position.y > 1300) || enemies.get(a).attacks.isEmpty()) {
      enemies.remove(a);
    }
  }
}

//function that sets up the game and makes it ready for play
void reset() {
  lives = 5;
  //instantiate characters and boss
  P1 = new Character("gen", 1);
  P2 = new Character("gen", 2);

  enemies.add(new Enemy("waste", null));
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
