
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
    this(a, 0.0);
  }
  Complex() {
    this(0.0, 0.0);
  }
  
  Complex add(Complex other) {
    return new Complex(
      a + other.a,
      b + other.b
    );
  }
  Complex sub(Complex other) {
    return new Complex(
      a - other.a,
      b - other.b
    );
  }
  Complex scale(float s) {
    return new Complex(a * s, b * s);
  }
  Complex mult(Complex other) {
    return new Complex(
      a*other.a - b*other.b,
      a*other.b + b*other.a
    );
  }
  Complex div(Complex other) {
    Complex c = other.conjugate();
    Complex numerator = mult(c);
    float denomenator = other.mult(c).a;
    return new Complex(
      numerator.a / denomenator,
      numerator.b / denomenator
    );
  }
  
  Complex conjugate() {
    return new Complex(a, -b);
  }
  Complex sq() {
    return mult(this);
  }
  float magSq() {
    return m * m;
  }
  
  String strAB() {
    return String.format("%.3f+%.3fi",a,b);
  }
  String strMP() {
    return String.format("%.3fe^(%.3fi)",m,p);
  }
  
}
