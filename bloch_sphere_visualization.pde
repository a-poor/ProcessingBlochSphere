
BlochSphere sph;


void setup() {
  size(500,500,P3D);
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
}
