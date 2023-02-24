class Target{
  float[] position = {0, 0};
  float[] source = {0, 0};
  float[] positionInPixels = {0, 0};
  float[] sourceInPixels = {0, 0};
  float errorThetaDegrees = 0;        //In degrees
  float pointTheta = 0;
  float[] arcStartStopTheta = {0, 0};    //In Radians
  float radiusInPixels = 0;
  private Axes axes;
  
  public Target(float positionX, float positionY,float sourceX, float sourceY, float theta, Axes theAxes){
    axes = theAxes;
    errorThetaDegrees = theta;
    pointTheta = atan2(positionY - sourceY, positionX - sourceX);


    position[0] = positionX;
    position[1] = positionY;
    source[0] = sourceX;
    source[1] = sourceY;
    positionInPixels[0] = Utils.XAxesToPixels(positionX, axes);
    positionInPixels[1] = Utils.YAxesToPixels(positionY, axes);
    sourceInPixels[0] = Utils.XAxesToPixels(sourceX, axes);
    sourceInPixels[1] = Utils.YAxesToPixels(sourceY, axes);
    radiusInPixels = dist(positionInPixels[0], positionInPixels[1], sourceInPixels[0], sourceInPixels[1]);

    computeThetas();
  }
  
  private void computeThetas()
  {
    arcStartStopTheta[0] = (pointTheta - radians(errorThetaDegrees));
    arcStartStopTheta[1] = (pointTheta + radians(errorThetaDegrees));
  }
  
  public void show(){
    stroke(0);
    fill(0);
    ellipse(positionInPixels[0], positionInPixels[1], 10, 10);
    strokeWeight(5);
    noFill();
    arc(sourceInPixels[0], sourceInPixels[1], 2*radiusInPixels, 2*radiusInPixels, TWO_PI -  arcStartStopTheta[1], TWO_PI -  arcStartStopTheta[0]);
    //The (2pi -)dis is because the arc function draws in a clockwise manner like a fucking idiot
  }
  
  
}
