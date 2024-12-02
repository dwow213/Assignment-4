class Projectile {
  
  //variables for projectile position, velocity and acceleration
  PVector position;
  PVector velocity;
  PVector acceleration;
  int accelRate; 
  //variable for the type of projectile (hostile, friendly, pickup)
  String type;
  //variable for the color of the projectile
  color colour;
  //variable for the size of the projectile
  int size;
  
  //constructor
  Projectile (String tempType, PVector tempPosition, PVector tempVelocity, PVector tempAcceleration, int tempAccelRate, int tempSize, color tempColor) {
    //all variables will accept a parameter
    type = tempType;
    position = tempPosition;
    velocity = tempVelocity;
    acceleration = tempAcceleration;
    accelRate = tempAccelRate;
    size = tempSize;
    colour = tempColor;
  }
  
  //function that displays the projectile on screen
  void display() {
    //drawing the projectile as a rectangle
    rectMode(CENTER);
    fill(colour);
    rect(position.x, position.y, size, size);
  }
  
  //function that updates the position, velocity and acceleration of the projectile
  void update() {
    //updates position based on velocity
    position.x += velocity.x;
    position.y += velocity.y;
    
    //when frame count is a multiple of the accel rate
    if (frameCount % accelRate == 0) {
      //update the velocity based on acceleration
      velocity.x += acceleration.x;
      velocity.y += acceleration.y;
    }
  }
}
