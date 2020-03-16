class myCube{
  private PVector position;
  private float size;
  private float maxAmplitude;
  private float amplitudeIncrement;
  boolean increaseAmplitude;
  
  myCube(PVector position, float size, float maxAmplitude){
    this.position = position.copy();
    this.size = size;
    this.maxAmplitude = maxAmplitude;
    this.amplitudeIncrement = 1;
    increaseAmplitude = true;
  }
  
  PVector getPosition(){
    return this.position;
  }
  
  float getSize(){
    return size;
  }
  
  void updateAmplitude(){
    if(increaseAmplitude){
      position.z+=amplitudeIncrement;
      if(position.z > maxAmplitude){
        increaseAmplitude=false;
      }
    }else{
      position.z-=amplitudeIncrement;
      if(position.z < 0){
        increaseAmplitude=true;
      }
    }    
  }
}
