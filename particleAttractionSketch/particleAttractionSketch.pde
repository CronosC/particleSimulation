


Visualizer visualizer;
State state;
int n = 0;

void setup() {
  fullScreen();
  this.state = new State(1440, 900);
  this.visualizer = new Visualizer();
  
  state.addRandomParticles("A");
  state.addRandomParticles("B");
  state.addRandomParticles("C");
  state.addRandomParticles("D");
  state.addRandomParticles("E");
  
  background(0, 0, 0, 0);
}

void draw() {
  this.visualizer.drawState(this.state);
  this.state.updateParticles();
  //if(n%1 == 0) saveFrame("Frame" + String.format("%08d", n) + ".png");
  n=n+1;
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
      state.settings.toggleAttractionFormula();
  }else if(key == 'l' || key == 'L'){
      visualizer.toggleDrawBorders();
  }
  
}
