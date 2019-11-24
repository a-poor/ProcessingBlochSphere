/* BlockSphere.pde
 * created by Austin Poor 
 */


// Note: Replace hard-coded screen-size-based
// translations with some varriable translations
// and/or sizes


class BlochSphere {
  // The traditional representations
  //float p1, m1, p2, m2;

  private float relative_phase, theta;
  private float phase_delta, theta_delta;

  private float min_theta = 0;
  private float max_theta = PI;

  private float phase_cycle = TWO_PI;

  //private String str_theta = "θ";
  //private String str_phi   = "Φ";
  //private String str_psi   = "Ψ";


  BlochSphere() {
    relative_phase = 0;
    theta = 0;

    phase_delta = 0.05;
    theta_delta = 0.05;
  }

  void set(float new_phase, float new_theta) {
    relative_phase = new_phase;
    theta = new_theta;
  }

  void setMP(float mag0, float phase0, float mag1, float phase1) {
    relative_phase = abs(phase1 - phase0);
    theta = map(mag0*mag0, 0, 1, PI, 0);
    //theta = 2 * mag0; //cos(mag0 / 2);
  }

  void getMP(float c0[], float c1[]) {
    c0[0] = cos(theta/2);
    c0[1] = 0;
    c1[0] = sin(theta/2);
    c1[1] = relative_phase;
  }

  void setAB(float a0, float b0, float a1, float b1) {
    float m0 = sqrt(a0*a0 + b0*b0);
    float p0 = atan2(a0, b0);
    float m1 = sqrt(a1*a1 + b1*b1);
    float p1 = atan2(a1, b1);
    setMP(m0, p0, m1, p1);
  }

  void getAB(float ab0[], float ab1[]) {
    float mp0[] = new float[2];
    float mp1[] = new float[2];
    getMP(mp0,mp1);
    ab0[0] = mp0[0] * cos(mp0[1]);
    ab0[1] = mp0[0] * sin(mp0[1]);
    ab1[0] = mp1[0] * cos(mp1[1]);
    ab1[1] = mp1[0] * sin(mp1[1]);
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
    rotateY(relative_phase); // Relative phase
    rotateZ(theta); // theta (from |0> at North Pole to |1> at South Pole
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
    float c1 = cos(theta/2);
    float c2_real = sin(theta/2);
    String braket_rep = "|Ψ> = "+c1+"|0> + "+c2_real+"e^("+relative_phase+"i)|1>";
    //String bloch_rep = "θ: " + theta + "\nΦ: " + relative_phase;
    text(braket_rep, 0, width/2, -10);
    pop();

    pop();

    push();
    textAlign(LEFT, CENTER);
    fill(255);
    textSize(20);
    //textAlign(CENTER,CENTER);
    //String bloch_rep = "|Ψ> = θ: " + theta + " Φ: " + relative_phase;
    String bloch_rep = "θ: " + theta + "\nΦ: " + relative_phase;
    text(bloch_rep, 20, 50, 0);
    pop();
  }

  void thetaUp() {
    theta =  min(theta+theta_delta, max_theta);
  }
  void thetaDown() {
    theta = max(theta-theta_delta, min_theta);
  }
  void phaseUp() {
    float new_phase = (relative_phase + phase_delta);
    while (new_phase < 0) {
      new_phase += phase_cycle;
    }
    relative_phase = new_phase % phase_cycle;
  }
  void phaseDown() {
    float new_phase = (relative_phase - phase_delta);
    while (new_phase < 0) {
      new_phase += phase_cycle;
    }
    relative_phase = new_phase % phase_cycle;
  }

  // Qubit Gates
  void setZero() {
    set(0, 0);
  }

  void setOne() {
    set(0, PI);
  }

  void measure() {
    if (random(1) < cos(theta/2)) {
      setZero();
      println("Measured |0>");
    } else {
      setOne();
      println("Measured |1>");
    }
  }

  void HAD() {
    float c0[] = {0,0};
    float c1[] = {0,0};
    getMP(c0,c1);
    c0[0] = c0[0] / sqrt(2) + c1[0] / sqrt(2);
    c1[0] = c0[0] / sqrt(2) - c1[0] / sqrt(2);
    setMP(c0[0],c0[1],c1[0],c1[1]);
  }

  void pauliX() {
    float c0[] = {0,0};
    float c1[] = {0,0};
    getMP(c0,c1);
    setMP(c1[0],c1[1],c0[0],c0[1]);
  }

  void pauliY() {
  }

  void pauliZ() {
  }

  void phaseT() { // pi/4
  }

  void phaseS() { // pi/2
  }

  void rootNot() {
  }
}
