class Bullet{
  float[] tip = {0, 0};
  float[] source = {0, 0};
  float[] tipInPixels = {0, 0};
  float[] sourceInPixels = {0, 0};
  float sourceOffset = 0;                              //Aiming position
  float sourceOffsetPixels = 0;
  float theta = 0;
  float size = 3;
  boolean collided = false;
  boolean inScreen = true;
  Axes axes;
  
  
  Bullet(float cX, float cY, Axes theAxes)
  {
    axes = theAxes;
    source[0] = cX;
    source[1] = cY;
    sourceInPixels[0] = Utils.XAxesToPixels(source[0], axes);
    sourceInPixels[1] = Utils.YAxesToPixels(source[1], axes);
    
    
    
    sourceOffset = 0.5;
    sourceOffsetPixels = axes.pixelsPerTick[0] * sourceOffset;
  }
  
  
  public void aimMouse(){
    theta = atan2(Utils.YPixelsToAxes(mouseY, axes) - source[1], Utils.XPixelsToAxes(mouseX, axes) - source[0]);
    tip[0] = source[0] + sourceOffset*cos(theta);
    tip[1] = source[1] + sourceOffset*sin(theta);
  }
  
  
  public void aim(float theta_){
    //For use with a knob or something.
    
    theta = theta_;
    tip[0] = source[0] + sourceOffset*cos(theta);
    tip[1] = source[1] + sourceOffset*sin(theta);
  }
  

  
  public void shoot(Target target_){

      tip[0] = tip[0] + 0.2*cos(theta);
      tip[1] = tip[1] + 0.2*sin(theta);
  }
  
  
  
  public boolean hasCollided(Target target_){
    //Condition is: thetamin < atan2(yb, xb) < thetamax; dist(source, tip) == dist(target.source, target.tip);
    
    if(target_.arcStartStopTheta[0] <= atan2(tip[1] - source[1], tip[0] - source[0])){
      
      if(target_.arcStartStopTheta[1] >= atan2(tip[1] - source[1], tip[0] - source[0])){
        
        if(abs(dist(source[0], source[1], tip[0], tip[1]) - dist(target_.source[0], target_.source[1], target_.position[0], target_.position[1])) < 0.2){
          return true;
        }
        return false;
      }
      return false;
    }
    return false;
  }
  
  public boolean exitedScreen(){
    if(tipInPixels[0] > width ||tipInPixels[0] < 0)
    {
      return true;
    }
    else if(tipInPixels[1] > height ||tipInPixels[1] < 0)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  public void show(){
    tipInPixels[0] = Utils.XAxesToPixels(tip[0], axes);
    tipInPixels[1] = Utils.YAxesToPixels(tip[1], axes);
    stroke(0);
    fill(0);
    ellipse(tipInPixels[0], tipInPixels[1], size, size);
  }
  
  
  
}
