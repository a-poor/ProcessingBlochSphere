
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
    c0 = c0_;
    c1 = c1_;
  }
  QBit(float a0, float b0, float a1, float b1) {
    this(new Complex(a0,b0), new Complex(a1,b1));
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
  
  public float measure(float rand) {
    if (rand < c0.magSq()) return 0.0;
    else return 1.0;
  }
  
  public QBit mult(float scalar) {
    Complex new_c0 = new Complex(c0.mult(scalar));
    Complex new_c1 = new Complex(c1.mult(scalar));
    return new QBit(new_c0, new_c1);
  }
  
}
