myCamera mc;
myTexturedSphere texturedSphere;
myCubeWall cubeWall;
boolean [] movementKeys;
boolean showSphere;
PImage hud_default, hud_B_Selected;
PImage hud;

void setup() {
  fullScreen(P3D);
  //size(700, 700, P3D);
  noStroke();
  texturedSphere = new myTexturedSphere(5);
  showSphere = false;
  
  //cube wall config
  int xCubes = 80;
  int yCubes = 80;
  float cubeSize = 25;
  float amplitude = cubeSize * 11;  
  cubeWall = new myCubeWall(xCubes, yCubes, cubeSize, amplitude);
  
  //camera config
  mc = new myCamera(new PVector(cubeWall.getWidth()/2,-200,0), 0, 5.8);
  mc.enableMovement(true);
  
  //keys config
  movementKeys = new boolean[]{false, false, false, false, false, false};
  
  hud_default = loadImage("./assets/HUD.png");
  hud_B_Selected = loadImage("./assets/HUD-B-Selected.png");
  
  hud = hud_default;
}

void draw () {
  background(0);
  
  mc.setupCamera();
  
  lightFalloff(.5, 0, 0.000008);
  drawPointOfLight();
  if(showSphere) drawSphere();
  drawWall();
  
  
  drawHUD();
  mc.updateCameraPosition(movementKeys[0],movementKeys[1],movementKeys[2],movementKeys[3],movementKeys[4],movementKeys[5]);
}

void drawPointOfLight(){
  pushStyle();
  pushMatrix();
  translate(cubeWall.getWidth()/2, -100, -cubeWall.getHeight()/2);
  emissive(150,150,150);
  sphere(50);
  //pointLight(250,250,250,0,0,0);
  ambientLight(250,250,250);
  popMatrix();
  popStyle();
}

void drawHUD(){
  noLights();
  hint(DISABLE_DEPTH_TEST);
  mc.beginOnCameraView();
  
  float imageWidth = hud.width/10;
  float imageHeight = hud.height/10;
  
  translate(0, 0, mc.getDistFromCameraToTarget()+1);
  image(hud, imageWidth * 8/9, -imageHeight * 21/6 , imageWidth, imageHeight);
  mc.endOnCameraView();
  hint(ENABLE_DEPTH_TEST);
}

void drawSphere(){
  pushStyle();
  mc.beginOnCameraView();
  translate(0,0,-100);
  texturedSphere.draw();
  emissive(250);
  circle(0,0,10.5);
  mc.endOnCameraView();
  popStyle();
}

void drawWall(){
  pushMatrix();
  rotateX(radians(-90));
  cubeWall.draw();
  popMatrix();
}

void keyReleased() {
  //CAMERA MOVEMENT
  if (keyCode == 87) movementKeys[0] = false;  //UP
  if (keyCode == 83) movementKeys[1] = false;  //DOWN
  if (keyCode == 65) movementKeys[2] = false;  //LEFT
  if (keyCode == 68) movementKeys[3] = false;  //RIGHT

  if (keyCode == 32) movementKeys[4] = false;  //SPACE
  if (keyCode == 17) movementKeys[5] = false;  //CRTL
}

void keyPressed() {
  //CAMERA MOVEMENT
  if (keyCode == 87) movementKeys[0] = true;  //UP
  if (keyCode == 83) movementKeys[1] = true;  //DOWN
  if (keyCode == 65) movementKeys[2] = true;  //LEFT
  if (keyCode == 68) movementKeys[3] = true;  //RIGHT

  if (keyCode == 32) movementKeys[4] = true;  //SPACE
  if (keyCode == 17) movementKeys[5] = true;  //CRTL
  
  if (keyCode == 66){
    showSphere = !showSphere;//B
    if (showSphere){
      hud = hud_B_Selected;
    } else {
      hud = hud_default;
    }
  }
}

void mouseDragged() {
  float dx = mouseX - pmouseX;
  float dy = mouseY - pmouseY;
  mc.updateRotation(dx, dy);
}
