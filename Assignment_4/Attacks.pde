class Attacks {

  //variables for the position of the character or enemy in order to make attacks that start from attacker if needed
  PVector originPosition;

  //a variable that count up every frame, determining whether certain actions should performed based on time
  int timer;
  
  //a variable used for the direction enemy or character will move
  int direction;

  //constructor is empty
  Attacks (PVector tempPos) {
    originPosition = tempPos;
    timer = 0;
    direction = 1;
  }
  
  //waste's first phase attack
  void dustSpecks() {
    //in all attack functions, the timer increments by one every time their functions are called (ideally every frame)
    timer += 1;
    
    //on every frame -
    if (timer % 1 == 0) {
      //shoot grey enemy projectiles from attacker's position, going upwards at first before going downwards, and with a random x velocity and x acceleration
      for (int i = 0; i < 5; i++) {
        projectiles.add(new Projectile("hostile", originPosition.copy(), new PVector(int(random(-50, 50)), -1), new PVector(random(-0.5, 0.5), 0.5), 20, 20, color(170)));
      }
    }
  }
  
  //waste's second phase attack
  void garbageDisposal() {
    timer += 1;
    
    //at the beginning of the attack, create a new fodder enemy
    if (timer == 1) {
      enemies.add(new Enemy("garbageCan", new PVector(180, -200)));
    }
    
    //every 30 frames, shoot 10 grey enemy projectiles from attacker's position, with a random x acceleration
    if (timer % 30 == 0) {
      for (int i = -10; i <= 10; i += 5) {
        projectiles.add(new Projectile("hostile", originPosition.copy(), new PVector(i, 1), new PVector(random(-0.5, 0.5), 0), 20, 20, color(170)));
      }
    }
    
    //reset the attack by setting the timer to 0 after 11 seconds pass
    if (timer == 660) {
      timer = 0;
    }
    
  }
  
  //attack used by garbage can fodder enemies during waste's second phase attack
  void garbageCan() {
    timer += 1;
    
    //move fodder enemy downwards over the course of ten seconds
    if (timer < 600) {
      originPosition.y += 3;
    }
    
    //after 5 seconds, garbage can starts shooting bullets every 20 frames
    if (timer > 300 && timer % 20 == 0) {
      for (int i = 0; i <= 10; i++) {
        projectiles.add(new Projectile("hostile", originPosition.copy(), new PVector(10, random(-1, 1)), new PVector(0, random(-0.5, 0.5)), 1, 20, color(170)));
      }
      
    }
  }

  //reset the timer (used when new attacks appear)
  void reset() {
    timer = 0;
    direction = 1;
  }
}
