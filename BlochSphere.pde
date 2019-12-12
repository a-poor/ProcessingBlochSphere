/* BlockSphere.pde
 * created by Austin Poor 
 */


// Note: Replace hard-coded screen-size-based
// translations with some varriable translations
// and/or sizes


class BlochSphere {
  // The traditional representations
  public QBit state;

  //private float state.bloch_phase, theta;
  private float phase_delta, theta_delta;

  private float min_theta = 0;
  private float max_theta = PI;

  private float phase_cycle = TWO_PI;

  //private String str_theta = "θ";
  //private String str_phi   = "Φ";
  //private String str_psi   = "Ψ";
  
  private Gate gHAD, gX, gY, gZ, gPhaseT, gPhaseS, gRootNOT;


  BlochSphere() {
    // Create the state qubit
    state = QBit.zero();
    
    // Create the bloch sphere coordinates
    //state.bloch_phase = state.bloch_phase;
    //theta = state.bloch_theta;
    
    // Create the gates
    gHAD = Gate.HAD();
    gX = Gate.PauliX();
    gY = Gate.PauliY();
    gZ = Gate.PauliZ();
    gPhaseT = Gate.PhaseT();
    gPhaseS = Gate.PhaseS();
    gRootNOT = Gate.RootNOT();
    
    
    // Old stuff...
    //state.bloch_phase = 0;
    //theta = 0;
    phase_delta = 0.05;
    theta_delta = 0.05;
  }

  //void setMP(float mag0, float phase0, float mag1, float phase1) {
  //  state.bloch_phase = abs(phase1 - phase0);
  //  theta = map(mag0*mag0, 0, 1, PI, 0);
  //  //theta = 2 * mag0; //cos(mag0 / 2);
  //}

  //void getMP(float c0[], float c1[]) {
  //  c0[0] = cos(theta/2);
  //  c0[1] = 0;
  //  c1[0] = sin(theta/2);
  //  c1[1] = state.bloch_phase;
  //}

  //void setAB(float a0, float b0, float a1, float b1) {
  //  float m0 = sqrt(a0*a0 + b0*b0);
  //  float p0 = atan2(a0, b0);
  //  float m1 = sqrt(a1*a1 + b1*b1);
  //  float p1 = atan2(a1, b1);
  //  setMP(m0, p0, m1, p1);
  //}

  //void getAB(float ab0[], float ab1[]) {
  //  float mp0[] = new float[2];
  //  float mp1[] = new float[2];
  //  getMP(mp0,mp1);
  //  ab0[0] = mp0[0] * cos(mp0[1]);
  //  ab0[1] = mp0[0] * sin(mp0[1]);
  //  ab1[0] = mp1[0] * cos(mp1[1]);
  //  ab1[1] = mp1[0] * sin(mp1[1]);
  //}

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

    push();
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(20);
    String braket_rep = "|Ψ> = "+state.strAB();
    //String bloch_rep = "θ: " + theta + "\nΦ: " + state.bloch_phase;
    text(braket_rep, 0, width/2, -10);
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

  //void thetaUp() {
  //  theta =  min(theta+theta_delta, max_theta);
  //}
  //void thetaDown() {
  //  theta = max(theta-theta_delta, min_theta);
  //}
  //void phaseUp() {
  //  float new_phase = (state.bloch_phase + phase_delta);
  //  while (new_phase < 0) {
  //    new_phase += phase_cycle;
  //  }
  //  state.bloch_phase = new_phase % phase_cycle;
  //}
  //void phaseDown() {
  //  float new_phase = (state.bloch_phase - phase_delta);
  //  while (new_phase < 0) {
  //    new_phase += phase_cycle;
  //  }
  //  state.bloch_phase = new_phase % phase_cycle;
  //}

  // Qubit Gates
  void setZero() {
    state = QBit.zero();
    //println("New qubit: " + state.toString());
    //println(state.bloch_phase+" "+state.bloch_theta);
    //println();
  }

  void setOne() {
    state = QBit.one();
    //println("New qubit: " + state.toString());
    //println(state.bloch_phase+" "+state.bloch_theta);
    //println();
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
