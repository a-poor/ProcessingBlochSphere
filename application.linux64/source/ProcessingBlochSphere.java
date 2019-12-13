import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ProcessingBlochSphere extends PApplet {


BlochSphere sph;

float pad = 5;
float w = 30;
float h = w;
float x = 35;
float y = 50;
float txty = y;

int n_buttons = 110;

public float mod(float a, float b) {
  while (a < 0) a += b;
  return a % b;
}


public void setup() {
  
  sph = new BlochSphere();
}

public void draw() {
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

public void mouseClicked() {
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
/* BlockSphere.pde
 * created by Austin Poor 
 */

class BlochSphere {
  public QBit state;
  
  private float phase_delta, theta_delta;
  
  private Gate gHAD, gX, gY, gZ, gPhaseT, gPhaseS, gRootNOT;


  BlochSphere() {
    // Create the state qubit
    state = QBit.zero();
    
    // Create the gates
    gHAD = Gate.HAD();
    gX = Gate.PauliX();
    gY = Gate.PauliY();
    gZ = Gate.PauliZ();
    gPhaseT = Gate.PhaseT();
    gPhaseS = Gate.PhaseS();
    gRootNOT = Gate.RootNOT();
    
    phase_delta = 0.05f;
    theta_delta = 0.05f;
  }

  public void show() {
    push();

    // Move to the center of the canvas
    translate(width/2, height/2, -200);

    // Draw the base sphere
    push();
    noFill();
    stroke(255, 20);
    sphere(250);
    pop();

    // Draw a center sphere
    push();
    fill(100, 100, 200);
    noStroke();
    sphere(10);
    pop();

    // Draw the arrow
    push();
    rotateY(state.bloch_phase); // Relative phase
    rotateZ(state.bloch_theta); // theta (from |0> at North Pole to |1> at South Pole
    stroke(250, 100, 100, 75);
    strokeWeight(5);
    // Main arrow
    line(
      0, 0, 0, 
      0, -250, 0
      );
    // Tip of the arrow
    fill(100, 200, 100);
    noStroke();
    translate(0, -250, 0);
    sphere(5);
    pop();
    
    // Draw latitute and longitude circles
    push();
    rotateY(state.bloch_phase); // Relative phase
    noFill();
    stroke(255,100,100);
    ellipse(0,0,500,500);
    pop();
    push();
    noFill();
    stroke(255,100,100);
    
    float r = 250;
    float x, y;
    float t = state.bloch_theta;
    
    if (t < PI/2) {
      x = sin(t) * r;
      y = -cos(t) * r;
    } else if (t > PI/2) {
      x = sin(PI - t) * r;
      y = cos(PI - t) * r;
    } else {
      x = r;
      y = 0;
    }
    
    translate(0,y,0);
    rotateX(PI/2);
    ellipse(0,0,x*2,x*2);
    pop();

    push();
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(20);
    String braket_rep = "|Ψ> = "+state.strAB();
    text(braket_rep, 0, width/2+40, -10);
    pop();

    pop();

    push();
    textAlign(LEFT, CENTER);
    fill(255);
    textSize(20);
    //textAlign(CENTER,CENTER);
    String bloch_rep = "θ: " + state.bloch_theta + "\nΦ: " + state.bloch_phase;
    text(bloch_rep, 20, 50, 0);
    pop();
  }
  
  public void applyProbChange(float delta) {
    state = state.changeBlochTheta(delta);
  }
  public void thetaUp() {
    applyProbChange(theta_delta);
  }
  public void thetaDown() {
    applyProbChange(-theta_delta);
  }
  public void applyPhase(float delta) {
    state = state.changeBlochPhase(delta);
  }
  public void phaseUp() {
    applyPhase(phase_delta);
  }
  public void phaseDown() {
    applyPhase(-phase_delta);
  }

  // Qubit Gates
  public void setZero() {
    state = QBit.zero();
  }

  public void setOne() {
    state = QBit.one();
  }

  public void measure() {
    state = state.measure(random(1));
  }

  public void HAD() {
    state = gHAD.apply(state);
  }

  public void pauliX() {
    state = gX.apply(state);
  }

  public void pauliY() {
    state = gY.apply(state);
  }

  public void pauliZ() {
    state = gZ.apply(state);
  }

  public void phaseT() { // pi/4
  state = gPhaseT.apply(state);
  }

  public void phaseS() { // pi/2
  state = gPhaseS.apply(state);
  }

  public void rootNOT() {
    state = gRootNOT.apply(state);
  }
}

public static class Complex {
  float a, b, m, p;
  
  public static Complex fromMP(float m, float p) {
    float a = m * cos(p);
    float b = m * sin(p);
    return new Complex(a, b);
  }
  public static Complex zero() {
    return new Complex(0);
  }
  public static Complex one() {
    return new Complex(1);
  }
  
  public static float mod(float a, float b) {
    while (a < 0) a += b;
    return a % b;
  }
  public static float mod(float a) {
    return mod(a,TWO_PI);
  }
  
  Complex(float a_, float b_) {
    a = a_;
    b = b_;
    m = sqrt(
      a * a +
      b * b
    );
    p = mod(atan2(b,a),TWO_PI);
  }
  Complex(float a) {
    this(a, 0.0f);
  }
  Complex() {
    this(0.0f, 0.0f);
  }
  
  public Complex add(Complex other) {
    return new Complex(
      a + other.a,
      b + other.b
    );
  }
  public Complex sub(Complex other) {
    return new Complex(
      a - other.a,
      b - other.b
    );
  }
  public Complex scale(float s) {
    return new Complex(a * s, b * s);
  }
  public Complex mult(Complex other) {
    return new Complex(
      a*other.a - b*other.b,
      a*other.b + b*other.a
    );
  }
  public Complex div(Complex other) {
    Complex c = other.conjugate();
    Complex numerator = mult(c);
    float denomenator = other.mult(c).a;
    return new Complex(
      numerator.a / denomenator,
      numerator.b / denomenator
    );
  }
  
  public Complex conjugate() {
    return new Complex(a, -b);
  }
  public Complex sq() {
    return mult(this);
  }
  public float magSq() {
    return m * m;
  }
  
  public String strAB() {
    return String.format("%.3f+%.3fi",a,b);
  }
  public String strMP() {
    return String.format("%.3fe^(%.3fi)",m,p);
  }
  
}


public static class Gate {
  
  public static Gate HAD() {
    Complex c0 = new Complex( 1/sqrt(2));
    Complex c1 = new Complex( 1/sqrt(2));
    Complex c2 = new Complex( 1/sqrt(2));
    Complex c3 = new Complex(-1/sqrt(2));
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  public static Gate PauliX() {
    Complex c0 = new Complex(0);
    Complex c1 = new Complex(1);
    Complex c2 = new Complex(1);
    Complex c3 = new Complex(0);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  public static Gate PauliY() {
    Complex c0 = new Complex(0);
    Complex c1 = new Complex(0,-1);
    Complex c2 = new Complex(0, 1);
    Complex c3 = new Complex(0);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  public static Gate PauliZ() {
    Complex c0 = new Complex(1);
    Complex c1 = new Complex(0);
    Complex c2 = new Complex(0);
    Complex c3 = new Complex(-1);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  public static Gate RootNOT() {
    Complex c0 = new Complex(1, 1);
    Complex c1 = new Complex(1,-1);
    Complex c2 = new Complex(1,-1);
    Complex c3 = new Complex(1, 1);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return (new Gate(arr)).mult(1.0f/2.0f);
  }
  public static Gate PhaseT() {
    Complex c0 = new Complex(1);
    Complex c1 = new Complex(0);
    Complex c2 = new Complex(0);
    Complex c3 = Complex.fromMP(1,PI / 4);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  public static Gate PhaseS() {
    Complex c0 = new Complex(1);
    Complex c1 = new Complex(0);
    Complex c2 = new Complex(0);
    Complex c3 = Complex.fromMP(1,PI/2);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  
  public static Gate PhasePhi(float phi) {
    Complex c0 = new Complex(1);
    Complex c1 = new Complex(0);
    Complex c2 = new Complex(0);
    Complex c3 = Complex.fromMP(1,phi);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return new Gate(arr);
  }
  
  
  
  int rows = 2;
  int cols = 2;
  Complex[][] m;
  
  Gate(Complex[][] m_) {
    m = m_;
  }
  
  public QBit apply(QBit z) {
    // Compute the top
    Complex c0a = z.c0.mult(m[0][0]);
    Complex c0b = z.c1.mult(m[0][1]);
    Complex c0 = c0a.add(c0b);
    // Compute the bottom
    Complex c1a = z.c0.mult(m[1][0]);
    Complex c1b = z.c1.mult(m[1][1]);
    Complex c1 = c1a.add(c1b);
    // Return the new QBit
    return new QBit(c0,c1);
  }
  
  public Gate mult(float scalar) {
    Complex[][] arr = new Complex[2][2];
    arr[0][0] = m[0][0].scale(scalar);
    arr[0][1] = m[0][1].scale(scalar);
    arr[1][0] = m[1][0].scale(scalar);
    arr[1][1] = m[1][1].scale(scalar);
    return new Gate(arr);
  }
  
  public String toString() {
    return "[[ "+m[0][0].strAB()+" "+m[0][1].strAB()+" ]\n" +
      " [ "+m[1][0].strAB()+" "+m[1][1].strAB()+" ]]";
  }
  
}

public static class QBit {
  Complex c0, c1;
  float bloch_phase, bloch_theta;
  
  public static QBit zero() {
    return new QBit(1.0f,0.0f,0.0f,0.0f);
  }
  public static QBit one() {
    return new QBit(0.0f,0.0f,1.0f,0.0f);
  }
  
  //public static QBit fromBloch() {
  //  return new QBit();
  //}
  
  QBit(Complex c0_, Complex c1_) {
    // Store complex components
    c0 = c0_;
    c1 = c1_;
    // Find the bloch coordinates
    bloch_phase = Complex.mod(
      c1.p - c0.p,
      TWO_PI
    );
    bloch_theta = map(c1.magSq(),0,1,0,PI);
  }
  QBit(float a0, float b0, float a1, float b1) {
    this(new Complex(a0,b0), new Complex(a1,b1));
  }
  QBit() {
    this(1.0f,0.0f,0.0f,0.0f);
  }
  
  public String strAB() {
    return "("+c0.strAB()+")|0> + ("+c1.strAB()+")|1>";
  }
  public String strMP() {
    return c0.strMP()+"|0> + "+c1.strMP()+"|1>";
  }
  public String toString() {
    return strMP();
  }
  
  public QBit measure(float rand) {
    if (rand < c0.magSq()) return QBit.zero();
    else return QBit.one();
  }
  
  public QBit mult(float scalar) {
    Complex new_c0 = c0.scale(scalar);
    Complex new_c1 = c1.scale(scalar);
    return new QBit(new_c0, new_c1);
  }
  
  public QBit changeBlochPhase(float amount) {
    return Gate.PhasePhi(Complex.mod(amount)).apply(this);
  }
  
  public QBit changeBlochTheta(float amount) {
    float new_c0_msq = c0.magSq() + amount;
    float prob0 = sqrt(max(min(new_c0_msq,1),0));
    float prob1 = sqrt(max(min(1-new_c0_msq,1),0));
    Complex a = Complex.fromMP(prob0,c0.p);
    Complex b = Complex.fromMP(prob1, c1.p);
    return new QBit(a,b);
  }
  
}
  public void settings() {  size(600, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ProcessingBlochSphere" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
