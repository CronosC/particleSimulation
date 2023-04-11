class Settings{
  boolean originalAttractionFormula = true;
  float G = 0.01;
  int interactionDistance = 200;
  
  public Settings(){}
  
  public void toggleAttractionFormula(){
    this.originalAttractionFormula = !originalAttractionFormula;
  }
  
  public void changeG(float value){
    this.G += value;
  }
  
  public void changeInteractionDistance(int value){
    this.interactionDistance += value;
  }
}
