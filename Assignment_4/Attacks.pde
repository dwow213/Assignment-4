class Attacks {

  //variables for the position of the character or enemy in order to make attacks that start from attacker if needed
  PVector originPosition;

  //a variable that count up every frame, determining whether certain actions should performed based on time
  int timer;

  //constructor is empty
  Attacks (PVector tempPos) {
    originPosition = tempPos;
  }

  //waste's first phase attack
  void dustSpecks() {
    //in all attack functions, the timer increments by one every time their functions are called (ideally every frame)
    timer += 1;

    if (timer % 1 == 0) {
      for (int i = 0; i < 5; i++) {
        projectiles.add(new Projectile("hostile", originPosition.copy(), new PVector(int(random(-50, 50)), -1), new PVector(random(-0.5, 0.5), 0.5), 20, 20, color(170)));
      }
    }
  }

  //reset the timer (used when new attacks appear)
  void reset() {
    timer = 0;
  }
}
