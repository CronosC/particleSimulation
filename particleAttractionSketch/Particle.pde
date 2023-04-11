class Particle{
  PVector position = new PVector(0, 0);
  PVector velocity = new PVector(random(-1, 1), random(-1, 1));
  float size;
  float mass;
  String type;
  
  color fillColor;
  
  public Particle(String type, PVector initialPosition, color fillColor, int size, float densityFactor){
    this.position = initialPosition;
    this.type = type;
    this.size = size;
    this.mass = pow(this.size, 2) * densityFactor;
    
    this.fillColor = fillColor;
  }
  
  public void apply(PVector force){
    this.velocity.add(force);
    this.velocity.mult(0.5);
  }
  
  public void update(int maxWidth, int maxHeight){
    this.position.add(this.velocity);
    
    if(position.x > maxWidth) {
      position.x = position.x - maxWidth;
    }
    if(position.y > maxHeight) {
      position.y = position.y - maxHeight;
    }
    if(position.x < 0) {
      position.x = position.x + maxWidth;
    }
    if(position.y < 0) {
      position.y = position.y + maxHeight;
    }
  }
}
