import 'matrix.dart';

class SystemLinerEquations {
  Matrix matrix;
  List<double> vector;
  final int n;
  SystemLinerEquations(this.matrix, this.vector) : n = matrix.n;

  bool get areCompatible => matrix.n == vector.length;

  Matrix get transportedMatrix => matrix.transported;
}
