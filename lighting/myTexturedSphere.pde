class myTexturedSphere{
  private PShape mySphere;
  private PImage metalTexture;
  
  myTexturedSphere(float radius){
    metalTexture = loadImage("./assets/t11.jpeg");
    mySphere = createShape(SPHERE, radius); 
    mySphere.setTexture(metalTexture);
  }
  
  public void draw(){
    shape(mySphere);
  }
  
}
