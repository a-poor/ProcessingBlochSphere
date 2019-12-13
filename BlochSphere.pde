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
    
    phase_delta = 0.05;
    theta_delta = 0.05;
  }

  void show() {
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
  
  void applyProbChange(float delta) {
    state = state.changeBlochTheta(delta);
  }
  void thetaUp() {
    applyProbChange(theta_delta);
  }
  void thetaDown() {
    applyProbChange(-theta_delta);
  }
  void applyPhase(float delta) {
    state = state.changeBlochPhase(delta);
  }
  void phaseUp() {
    applyPhase(phase_delta);
  }
  void phaseDown() {
    applyPhase(-phase_delta);
  }

  // Qubit Gates
  void setZero() {
    state = QBit.zero();
  }

  void setOne() {
    state = QBit.one();
  }

  void measure() {
    state = state.measure(random(1));
  }

  void HAD() {
    state = gHAD.apply(state);
  }

  void pauliX() {
    state = gX.apply(state);
  }

  void pauliY() {
    state = gY.apply(state);
  }

  void pauliZ() {
    state = gZ.apply(state);
  }

  void phaseT() { // pi/4
  state = gPhaseT.apply(state);
  }

  void phaseS() { // pi/2
  state = gPhaseS.apply(state);
  }

  void rootNOT() {
    state = gRootNOT.apply(state);
  }
}
