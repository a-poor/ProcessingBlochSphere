

class BlochSphere {
  // The traditional representations
  //float p1, m1, p2, m2;
  
  
  private float relative_phase, theta;
  private float phase_delta, theta_delta;
  
  private float min_theta = 0;
  private float max_theta = PI;
  
  private float phase_cycle = TWO_PI;
  
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
  
  void show() {
    push();
    
    // Move to the center of the canvas
    translate(width/2,height/2,-200);
    
    // Draw the base sphere
    push();
    noFill();
    stroke(255,20);
    sphere(250);
    pop();
    
    // Draw a center sphere
    push();
    fill(100,100,200);
    noStroke();
    sphere(10);
    pop();
    
    // Draw the arrow
    push();
    rotateY(relative_phase); // Relative phase
    rotateZ(theta); // theta (from |0> at North Pole to |1> at South Pole
    stroke(250,100,100,75);
    strokeWeight(5);
    // Main arrow
    line(
      0,0,0,
      0,-250,0
    );
    // Tip of the arrow
    push();
    fill(100,200,100);
    noStroke();
    translate(0,-250,0);
    sphere(5);
    pop();
    
    pop();
    
    pop();
  }
  
  void thetaUp() {
    theta =  min(theta+theta_delta, max_theta);
  }
   void thetaDown() {
     theta = max(theta-theta_delta, min_theta);
   }
   void phaseUp() {
     relative_phase = (relative_phase + phase_delta) % phase_cycle;
   }
   void phaseDown() {
     relative_phase = (relative_phase - phase_delta) % phase_cycle;
   }
   
   
}
