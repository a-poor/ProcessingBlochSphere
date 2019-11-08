
BlochSphere sph;

float lastX = 0;
float lastY = 0;


void setup() {
  size(600,600,P3D);
  sph = new BlochSphere();
}

void draw() {
  background(50);
  sph.show();
  
  if (keyPressed && key == CODED) {
    if (keyCode == UP) {
      sph.thetaDown();
    } else if (keyCode == DOWN) {
      sph.thetaUp();
    } else if (keyCode == RIGHT) {
      sph.phaseUp();
    } else if (keyCode == LEFT) {
      sph.phaseDown();
    }
  }
}

void mouseDragged() {
  // Add code here to make the sphere
  // draggable...
  float dX = mouseX - lastX;
  float dY = mouseY - lastY;
  lastX = mouseX;
  lastY = mouseY;
  if (abs(dX) > abs(dY)) {
    // LR movement is greater
    if (dX > 0) {
      sph.phaseUp();
    } else {
      sph.phaseDown();
    }
  } else {
    // UD movement is greater
    if (dY > 0) {
      sph.thetaUp();
    } else {
      sph.thetaDown();
    }
  }
}
