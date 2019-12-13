
BlochSphere sph;

float pad = 5;
float w = 30;
float h = w;
float x = 35;
float y = 50;
float txty = y;

int n_buttons = 110;

float mod(float a, float b) {
  while (a < 0) a += b;
  return a % b;
}


void setup() {
  size(600, 600, P3D);
  sph = new BlochSphere();
}

void draw() {
  background(50);
  sph.show();

  if (keyPressed && key == CODED) {
    if (keyCode == UP) {
      sph.thetaUp();
    } else if (keyCode == DOWN) {
      sph.thetaDown();
    } else if (keyCode == RIGHT) {
      sph.phaseUp();
    } else if (keyCode == LEFT) {
      sph.phaseDown();
    }
  }


  push();

  fill(25);
  rectMode(CENTER);
  rect(width-(x+0*(pad+w)), y, w, h);
  rect(width-(x+1*(pad+w)), y, w, h);
  rect(width-(x+2*(pad+w)), y, w, h);
  rect(width-(x+3*(pad+w)), y, w, h);
  rect(width-(x+4*(pad+w)), y, w, h);
  rect(width-(x+5*(pad+w)), y, w, h);
  rect(width-(x+6*(pad+w)), y, w, h);
  rect(width-(x+7*(pad+w)), y, w, h);
  rect(width-(x+8*(pad+w)), y, w, h);
  rect(width-(x+9*(pad+w)), y, w, h);
  fill(255);
  textSize(12);
  textAlign(CENTER, CENTER);
  text("|0>", width-(x+9*(pad+w)), txty);
  text("|1>", width-(x+8*(pad+w)), txty);
  text("H", width-(x+7*(pad+w)), txty);
  text("X", width-(x+6*(pad+w)), txty);
  text("Y", width-(x+5*(pad+w)), txty);
  text("Z", width-(x+4*(pad+w)), txty);
  text("T", width-(x+3*(pad+w)), txty);
  text("S", width-(x+2*(pad+w)), txty);
  text("√X", width-(x+1*(pad+w)), txty);
  text("M", width-(x+0*(pad+w)), txty);
  pop();
}

void mouseClicked() {
  if (mouseY < y + (w/2)) {
    int b = (int)((width-mouseX-x) / (pad+w));
    //println("Pressing button: " + b);
    switch (b) {
    case 0:
      println("Measure Gate");
      sph.measure();
      break;
    case 1:
      println("√NOT Gate");
      sph.rootNOT();
      break;
    case 2:
      println("S Gate");
      sph.phaseS();
      break;
    case 3:
      println("T Gate");
      sph.phaseT();
      break;
    case 4:
      println("Z Gate");
      sph.pauliZ();
      break;
    case 5:
      println("Y Gate");
      sph.pauliY();
      break;
    case 6:
      println("X Gate");
      sph.pauliX();
      break;
    case 7:
      println("HAD Gate");
      sph.HAD();
      break;
    case 8:
      println("Set |1>");
      sph.setOne();
      break;
    case 9:
      println("Set |0>");
      sph.setZero();
      break;
    default:
      break;
    }
  }
  println("New qubit: " + sph.state.strAB());
  println();
}
