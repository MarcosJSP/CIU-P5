class myCubeWall {
  private int xCubes, yCubes;
  private float cubeSize;
  private float amplitude;
  private ArrayList<myCube> cubes;

  myCubeWall(int xCubes, int yCubes, float cubeSize, float amplitude) {
    this.xCubes = xCubes;
    this.yCubes = yCubes;
    this.cubeSize = cubeSize;
    this.amplitude = amplitude;
    this.cubes = new ArrayList<myCube>();
    generateCubeWall();
  }
  
  public float getHeight(){
    return this.yCubes * cubeSize;
  }
  
  public float getWidth(){
    return this.xCubes * cubeSize;
  }

  private void generateCubeWall() {
    float yoff = 0;
    for (float x=0; x < xCubes; x++) {
      float xoff=0;
      for (float y=0; y < yCubes; y++) {
        float z = map(noise(xoff, yoff), 0, 1, 0, amplitude);
        PVector point = new PVector((x+1)*cubeSize, (y+1)*cubeSize, z);
        cubes.add(new myCube(point, cubeSize, amplitude));
        xoff+=0.05;
      }
      yoff+=0.05;
    }
  }

  public void draw() {
    for (myCube cube : cubes) {
      pushMatrix();
      PVector position = cube.getPosition();
      translate(position.x, position.y, position.z);
      box(cube.getSize());
      popMatrix();
      cube.updateAmplitude();
    }
  }
}
