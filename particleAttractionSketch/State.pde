import java.util.Collections;

class State{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int universeWidth;
  int universeHeight;
  Settings settings = new Settings();
  HashMap<String, HashMap<String, Float>> forceMap = new HashMap();
  
  public State(int creationWidth, int creationHeight){
    this.universeWidth = creationWidth;
    this.universeHeight = creationHeight;
    
    String[] possibleParticles = {"A", "B", "C", "D", "E", "F", "G", "H"};
    
    for (String particle1Type : possibleParticles){
      HashMap<String, Float> particleMap = new HashMap();
      for (String particle2Type : possibleParticles){
        float attractionForce = random(-1, 1);
        particleMap.put(particle2Type, attractionForce);
      }
      this.forceMap.put(particle1Type, particleMap);
    }
  }
  
  public void addParticle(String type, color fillColor, int size, float densityFactor){
    PVector particlePosition = new PVector(random(0, this.universeWidth), random(0, this.universeHeight));
    particles.add(new Particle(type, particlePosition, fillColor, size, densityFactor));
  }
  
  public void addRandomParticles(String type){
    int n = int(random(100, 500));
    color fillColor = color(int(random(50, 250)), int(random(50, 250)), int(random(50, 250)));
    int size = int(random(2, 8));
    float densityFactor = random(0.25, 1.75);
    this.addParticles(type, n, fillColor, size, densityFactor);
  }
  
  public void addParticles(String type, int n, color fillColor, int size, float densityFactor){
    for(int i = 1; i < n;i++){
      this.addParticle(type, fillColor, size, densityFactor);
    }
  }
  
  public void updateParticles(){
    for(Particle particle : particles){
      PVector totalAttraction = new PVector(0, 0);
      for(Particle otherParticle : particles){
        if(particle != otherParticle){
         totalAttraction.add(calculateAttraction(particle, otherParticle));
        }
      }
      particle.apply(totalAttraction);
    }
    
    
    for (int i = 0; i < particles.size();i++){
      for(int j = i+1; j < particles.size();j++){
        collisionCheck(particles.get(i), particles.get(j));
      }
    }
    
    for (Particle particle : particles){
      particle.update(this.universeWidth, this.universeHeight);
    }
  }
  
  private PVector getRelativePosition(Particle A, Particle B){
    float transformedX = A.position.x;
    float transformedY = A.position.y;
    

    if(abs((A.position.x + this.universeWidth) - B.position.x) < this.universeWidth/2){
      transformedX = transformedX + this.universeWidth;
    }else if(abs((A.position.x - this.universeWidth) - B.position.x) < this.universeWidth/2){
      transformedX = transformedX - this.universeWidth;
    }
    
    if(abs((A.position.y + this.universeHeight) - B.position.y) < this.universeHeight/2){
      transformedY = transformedY + this.universeHeight;
    }else if(abs((A.position.y - this.universeHeight) - B.position.y) < this.universeHeight/2){
      transformedY = transformedY - this.universeHeight;
    }
    
    PVector transformedPosition = new PVector(transformedX, transformedY);
    return transformedPosition;
  }
  
  private PVector calculateAttraction(Particle A, Particle B){
    PVector transformedPosition = this.getRelativePosition(A, B);
    float distance = abs(PVector.dist(transformedPosition, B.position));
    
    float attraction;
    if(distance < settings.interactionDistance && distance >  (A.size + B.size) / 2){
      
      if(settings.originalAttractionFormula) {
        attraction = settings.G * ((A.mass * B.mass) / pow(distance, 1)) * (forceMap.get(A.type).get(B.type));
      }else{
        attraction = 50 * settings.G * (A.mass / (A.mass + B.mass)) * pow((settings.interactionDistance - distance) / settings.interactionDistance, 2) * (forceMap.get(A.type).get(B.type));
      }
     
    } else {
      attraction = 0;
    }
    
    PVector attractionVector = PVector.sub(B.position, transformedPosition).normalize().mult(attraction);
    return attractionVector;
  }
  
  private void collisionCheck(Particle A, Particle B){
    PVector transformedPosition = this.getRelativePosition(A, B);
    float distance = abs(PVector.dist(transformedPosition, B.position));
    
    if (distance <= (A.size + B.size)/2){
      PVector newVelocityA = A.velocity.copy();
      PVector newVelocityB = B.velocity.copy();
      
      float totalM = A.mass + B.mass;
      
      PVector V1V2 = PVector.sub(A.velocity, B.velocity);
      PVector P1P2 = PVector.sub(A.position, B.position);
      PVector P1mP2 = PVector.sub(A.position, B.position);
      float absP1mP2 = PVector.sub(A.position, B.position).magSq();
      float massFactorA = (B.mass * 2) / totalM;
      
      float term1A = V1V2.dot(P1P2) / absP1mP2;
      newVelocityA.sub(P1mP2.mult(massFactorA * term1A));
      
      //newVelocityA.sub(V1V2.cross(P1P2).div(absP1mP2).cross(P1mP2).mult(massFactorA));
      
      PVector V2V1 = PVector.sub(B.velocity, A.velocity);
      PVector P2P1 = PVector.sub(B.position, A.position);
      PVector P2mP1 = PVector.sub(B.position, A.position);
      float absP2mP1 = PVector.sub(B.position, A.position).magSq();
      float massFactorB = (A.mass * 2) / totalM;
      
      float term1B = V2V1.dot(P2P1) / absP2mP1;
      newVelocityB.sub(P2mP1.mult(massFactorB * term1B));
      //newVelocityB.sub(V2V1.dot(P2P1).div(absP2mP1).cross(P2mP1).mult(massFactorB));
      
      A.velocity = newVelocityA;
      B.velocity = newVelocityB;
    }
  }
}
