import ashwin.userinterface.*;
import ashwin.geometry.*;

Axes axes;
Target t;
Bullet b;
int mode = 1;
int problem = 1;
float sourcex;
float sourcey;
float targetx;
float targety;

void setup() {
  size(1024, 768);
  axes = new Axes(0, 0, 1024, 768, this);
  axes.setPixelsPerTick(50, 50);
    //axes.setTickSizes(2, 2);

  sourcex = floor(random(-10, 11));
  sourcey = floor(random(-10, 11));
  targetx = floor(random(-10, 11));
  targety = floor(random(-10, 11));
  t = new Target(targetx, targety, sourcex, sourcey, 5, axes);
  b = new Bullet(sourcex, sourcey, axes);
}


void draw() {
  background(125);

  
  axes.display();
  axes.showTicks();
  axes.showGrid();
  t.show();
  
  if (mode == 1){
    
    b.aimMouse();
    if(mousePressed && mouseButton == LEFT)  mode = mode + 1;
  }
  
  else if (mode == 2){
    b.shoot(t);
    if(b.hasCollided(t) || b.exitedScreen())
    {
      nextLevel();
    }
  }
  
  
  
  
  b.show();
  
  

}

public void nextLevel(){
  mode = 1;
  
}
