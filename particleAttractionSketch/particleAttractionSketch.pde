Visualizer visualizer;
State state;

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
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
      state.settings.toggleAttractionFormula();
  }else if(key == 'l' || key == 'L'){
      visualizer.toggleDrawBorders();
  }
  
}
