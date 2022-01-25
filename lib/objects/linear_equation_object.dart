class LinearEquationObject {
  LinearEquationObject(this.m, this.c);

  final double m;
  final double c;

  @override
  String toString() {
    return 'y = $m*x + $c';
  }
}
