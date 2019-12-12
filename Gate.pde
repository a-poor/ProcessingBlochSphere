

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
    return (new Gate(arr)).mult(1.0/sqrt(2.0));
  }
  public static Gate PhaseT() {
    Complex c0 = new Complex(1);
    Complex c1 = new Complex(0);
    Complex c2 = new Complex(0);
    Complex c3 = Complex.fromMP(1,PI / 4);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return (new Gate(arr)).mult(1.0/2.0);
  }
  public static Gate PhaseS() {
    Complex c0 = new Complex(1);
    Complex c1 = new Complex(0);
    Complex c2 = new Complex(0);
    Complex c3 = Complex.fromMP(1,PI/2);
    Complex[][] arr = {{c0,c1},{c2,c3}}; 
    return (new Gate(arr)).mult(1.0/2.0);
  }
  
  
  
  int rows = 2;
  int cols = 2;
  Complex[][] m;
  
  Gate(Complex[][] m_) {
    m = m_;
  }
  
  QBit apply(QBit z) {
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
  
}
