Visualizer visualizer;
State state;

void setup() {
  fullScreen();
  this.state = new State(1000, 600);
  this.visualizer = new Visualizer();
  
  //state.addParticles("A", 7, color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))));
  
  state.addParticles("A", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5));
  state.addParticles("B", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5));
  state.addParticles("C", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5));
  state.addParticles("D", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5));
  state.addParticles("E", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5));
  //state.addParticles("F", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5));
  //state.addParticles("G", int(random(100, 250)), color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))), int(random(2, 8)), random(0.5, 1.5))
}

void draw() {
  this.visualizer.drawState(this.state);
  this.state.updateParticles();
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
      state.settings.toggleAttractionFormula();
  }
}
