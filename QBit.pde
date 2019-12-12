
public static class QBit {
  Complex c0, c1;
  float bloch_phase, bloch_theta;
  
  public static QBit zero() {
    return new QBit(1.0,0.0,0.0,0.0);
  }
  public static QBit one() {
    return new QBit(0.0,0.0,1.0,0.0);
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
    this(1.0,0.0,0.0,0.0);
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
    return new QBit();
  }
  
  public QBit changeBlochTheta(float amount) {
    return new QBit();
  }
  
}
