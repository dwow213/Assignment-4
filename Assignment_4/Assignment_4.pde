//Assignment 4
//Assignment 4
//Assignment 4

//boolean variable that determines whether the game is being played
boolean playingGame = false;
//variable that specifies which menu should be shown
int menu = 1;

//load menu images
PImage mainMenu;
PImage gameOverMenu;
PImage gameWinMenu;

//variables for player 1 character and player 2 character
Character P1;
Character P2;

//variable for the amount of lives
int lives;

//array list that holds all the projectiles
ArrayList<Projectile> projectiles;

//array list that holds the all the enemies
ArrayList<Enemy> enemies;

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
  //set resolution and frame rate
  size(1280, 1024);
  frameRate(60);

  //load menu images
  mainMenu = loadImage("main menu.png");
  gameOverMenu = loadImage("game over.png");
  gameWinMenu = loadImage("game win.png");
}

void draw() {
  background(100);
  //when the game is not being played and we are in the menu
  imageMode(CORNER);

  //if we are on menus (the game is not being played)
  if (!playingGame) {

    //displaying menus
    //on the main menu
    if (menu == 1) {

      //display the main menu
      image(mainMenu, 0, 0);

      //when any key is pressed
      if (key == 'Z' || key == 'z') {
        playingGame = true; //change game state to now playing the game
        reset(); //setup for the game
      }

      //on the game win menu
    } else if (menu == 2) {
      
      //display the game win menu
      image(gameWinMenu, 0, 0);

      //when any key is pressed
      if (key == ' ') {
        menu = 1; //change menu to main menu
      }

      //on the game over menu
    } else if (menu == 3) {
      
      //display the game over menu
      image(gameOverMenu, 0, 0);

      //when any key is pressed
      if (key == ' ') {
        menu = 1; //change menu to main menu
      }
    }

    //when the game is being played
  } else {

    //if there are no more lives remaining and both P1 and P2 are dead
    if (lives <= 0 && P1.deadState && P2.deadState) {
      //the game is over and you lose
      playingGame = false;
      menu = 3; //game over menu
    }

    //if all enemies are dead
    if (enemies.size() <= 0) {
      //the game is over and you win!!!
      playingGame = false;
      menu = 2; //game win menu
    }

    //display the amount of lives left at the top left corner of the screen
    textSize(50);
    fill(185);
    text("Lives: " + lives, 25, 60);

    //display and update the player characters
    P1.display();
    P1.update();
    P2.display();
    P2.update();

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
            }

            //if the projectile is an enemy bullet
          } else if (projectiles.get(i).type == "hostile") {

            //check if the bullet is within P1's hitbox and if P1 is not dead
            if (projectiles.get(i).position.x + projectiles.get(i).size / 2 > P1.position.x - P1.size / 2 && projectiles.get(i).position.x - projectiles.get(i).size / 2 < P1.position.x + P1.size / 2 && projectiles.get(i).position.y + projectiles.get(i).size / 2 > P1.position.y - P1.size / 2 && projectiles.get(i).position.y - projectiles.get(i).size / 2 < P1.position.y + P1.size / 2 && !P1.deadState && !P1.invincibleState) {
              projectiles.remove(i); //remove the projectile
              lives -= 1; //decrease the amount of lives
              P1.deadState = true; //make P1 dead
              P1.deathTimer = 600; //reset P1 death timer to max
              println("hit player 1");

              //check if the bullet is within P2's hitbox and if P2 is not dead
            } else if (projectiles.get(i).position.x + projectiles.get(i).size / 2 > P2.position.x - P2.size / 2 && projectiles.get(i).position.x - projectiles.get(i).size / 2 < P2.position.x + P2.size / 2 && projectiles.get(i).position.y + projectiles.get(i).size / 2 > P2.position.y - P2.size / 2 && projectiles.get(i).position.y - projectiles.get(i).size / 2 < P2.position.y + P2.size / 2 && !P2.deadState && !P2.invincibleState) {
              projectiles.remove(i); //remove the projectile
              lives -= 1; //decrease the amount of lives
              P2.deadState = true; //make P2 dead
              P2.deathTimer = 600; //reset P1 death timer to max
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

    //revive characters if needed
    revive();
  }
}

//function that sets up the game and makes it ready for play
void reset() {
  //initialize projectiles and enemies
  projectiles = new ArrayList<Projectile>();
  enemies = new ArrayList<Enemy>();

  //set lives to 5, allowing for 5 deaths
  lives = 1;
  //instantiate characters and boss
  P1 = new Character("gen", 1);
  P2 = new Character("blu", 2);
  enemies.add(new Enemy("waste", null, true));
}

//function for the reviving of players
void revive() {

  //when both players are dead
  if (P1.deadState && P2.deadState) {
    //immediately revive both of them
    P1.revivalProgress = 300;
    P2.revivalProgress = 300;
    //set their position back
    P1.position = new PVector(600, 900);
    P2.position = new PVector(680, 900);
  }

  //players can only be revived if there are some lives remaining
  if (lives > 0) {
    //if P1 is dead
    if (P1.deadState) {
      //if P2's hitbox is within P2's revive hitbox
      if (P2.position.x - P2.size / 2 > P1.position.x - 100 && P2.position.x + P2.size / 2 < P1.position.x + 100 && P2.position.y - P2.size / 2 > P1.position.y - 100 && P2.position.y + P2.size / 2 < P1.position.y + 100) {
        P1.revivalProgress += 1; //build revival progress for P1
        P1.deathTimer += 1; //increase P1's death timer by 1, freezing it in place
      }
      //if P2 is dead
    } else if (P2.deadState) {
      //if P1's hitbox is within P2's revive hitbox
      if (P1.position.x - P1.size > P2.position.x - 100 && P1.position.x + P1.size < P2.position.x + 100 && P1.position.y - P1.size > P2.position.y - 100 && P1.position.y + P1.size < P2.position.y + 100) {
        P2.revivalProgress += 1; //build revival progress for P2
        P2.deathTimer += 1; //increase P2's death timer by 1, freezing it in place
      }
    }
  }
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
