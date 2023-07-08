class Visualizer{
  State state;
  private int xOffset;
  private int yOffset;
  private boolean showBorders = false;
  
  public Visualizer(){
  }
  
  public void drawState(State state){
    fill(0, 10);
    noStroke();
    rect(0,0,width, height);

    this.setOffsets(state.universeWidth, state.universeHeight);
    if(this.showBorders){
      this.drawArea(state.universeWidth, state.universeHeight);
    }
    
    for (int x = -1; x<= 1; x++){
      for (int y = -1; y<= 1; y++){
        if(x!= 0 || y!=0){
          this.setGridOffsets(state.universeWidth, state.universeHeight, x, y);
          
          ArrayList<Particle> particles = state.particles;
          for(Particle particle : particles){
            this.drawParticle(particle);
          }
        }
      }
    }
    
    this.setGridOffsets(state.universeWidth, state.universeHeight, 0, 0);
    
    ArrayList<Particle> particles = state.particles;
    for(Particle particle : particles){
      this.drawParticle(particle);
    }
  }
  
  private void enableDrawBorders(){
    this.showBorders = true;
  }
  
  private void disableDrawBorders(){
    this.showBorders = false;
  }
  
  public void toggleDrawBorders(){
    this.showBorders = !this.showBorders;
  }
  
  private void drawArea(int areaWidth, int areaHeight){
    //fill(0, 0, 0, 255);
    stroke(255, 255, 255, 30);
    rect(this.xOffset, this.yOffset, areaWidth, areaHeight);
  }
  
  private void drawParticle(Particle particle){
    color fillColor = particle.fillColor;
    fill(red(fillColor), green(fillColor), blue(fillColor), 100);
    noStroke();
    pushMatrix();
    translate(this.xOffset + particle.position.x, this.yOffset + particle.position.y);
    circle(0, 0, particle.size);
    popMatrix();
  }
  
  private void setGridOffsets(int areaWidth, int areaHeight, int gridX, int gridY){
    if(gridX!= 0 || gridY != 0){
    
    }
    this.xOffset = width / 2 - ((areaWidth / 2) + gridX * areaWidth);
    this.yOffset = height / 2 - ((areaHeight / 2) + gridY * areaHeight);
  }
  
  private void setOffsets(int areaWidth, int areaHeight){
    this.xOffset = width / 2 - areaWidth / 2;
    this.yOffset = height / 2 - areaHeight / 2;
  }
  
}
