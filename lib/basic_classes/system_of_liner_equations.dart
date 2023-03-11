import 'package:number_methods/Exceptions/matrix_is_not_square.dart';

import '../Exceptions/matrix_and_vector_are_not_compatible.dart';
import 'matrix.dart';

class SystemLinerEquations {
  Matrix matrix;
  List<double> vector;
  final int n;
  SystemLinerEquations(this.matrix, this.vector) : n = matrix.n {
    if (!areCompatible) {
      throw MatrixAndVectorAreNotCompatible();
    }
    if (matrix.isSquare == false) {
      throw MatrixIsNotSquare();
    }
  }

  bool get areCompatible => matrix.n == vector.length;

  Matrix get transportedMatrix => matrix.transported;

  // solution discrepancy
  double dicrepancy(List<double> solution) {
    Matrix r = matrix * Matrix.fromList(solution).transported -
        Matrix.fromList(vector).transported;

    // r.printMatrix();
    r = r.transported;
    // r.printMatrix();
    // we got vector of discrepancy
    // we need to find sqrt of sum of squares of discrepancy
    double result = 0;
    for (int i = 0; i < n; i++) {
      result += r.data[0][i] * r.data[0][i];
    }
    return result * result;
  }
}
