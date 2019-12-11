

public class Gate {
  int rows = 2;
  int cols = 2;
  Complex[][] m;
  
  Gate(Complex[][] m_) {
    m = m_;
  }
  
  QBit op(QBit z) {
    // Compute the top
    Complex c0a = z.c0.mult(m[0][0]);
    Complex c0b = z.c1.mult(m[0][1]);
    Complex c0 = c0a.add(c0b);
    // Compute the bottom
    Complex c1a = z.c0.mult(m[1][0]);
    Complex c1b = z.c1.mult(m[1][1]);
    Complex c1 = c0a.add(c0b);
    // Return the new QBit
    return new QBit(c0,c1);
  }
  
}
