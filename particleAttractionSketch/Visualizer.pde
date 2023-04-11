class Visualizer{
  State state;
  private int xOffset;
  private int yOffset;
  
  public Visualizer(){
  }
  
  public void drawState(State state){
    background(100, 100, 100);
    this.setOffsets(state.universeWidth, state.universeHeight);
    this.drawArea(state.universeWidth, state.universeHeight);
    
    for (int x = -1; x<= 1; x++){
      for (int y = -1; y<= 1; y++){
        if(x!= 0 || y!=0){
          this.setGridOffsets(state.universeWidth, state.universeHeight, x, y);
          this.drawArea(state.universeWidth, state.universeHeight);
          
          ArrayList<Particle> particles = state.particles;
          for(Particle particle : particles){
            this.drawParticle(particle);
          }
        }
      }
    }
    
    this.setGridOffsets(state.universeWidth, state.universeHeight, 0, 0);
    fill(0,0,0,150);
    rect(-10000, -10000, 20000, 20000);
    this.drawArea(state.universeWidth, state.universeHeight);
    
    ArrayList<Particle> particles = state.particles;
    for(Particle particle : particles){
      this.drawParticle(particle);
    }
  }
  
  private void drawArea(int areaWidth, int areaHeight){
    fill(0, 0, 0, 255);
    stroke(255, 255, 255, 10);
    rect(this.xOffset, this.yOffset, areaWidth, areaHeight);
  }
  
  private void drawParticle(Particle particle){
    color fillColor = particle.fillColor;
    fill(fillColor);
    stroke(fillColor);
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
