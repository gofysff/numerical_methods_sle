import 'dart:math';

import 'package:number_methods/Exceptions/matrix_is_not_square.dart';

import '../Exceptions/matrix_and_vector_are_not_compatible.dart';
import 'input_system.dart';
import 'matrix.dart';

abstract class Solution {
  List<double> solution();
}

abstract class SystemLinerEquations implements Solution {
  Matrix matrix;
  List<double> vectorB;
  final int n;
  SystemLinerEquations(this.matrix, this.vectorB) : n = matrix.n {
    if (!areCompatible) {
      throw MatrixAndVectorAreNotCompatible();
    }
    if (matrix.isSquare == false) {
      throw MatrixIsNotSquare();
    }
  }

  SystemLinerEquations.fromInputData(SystemInput input)
      : matrix = input.matrix,
        vectorB = input.vectorB,
        n = input.matrix.n {
    if (!areCompatible) {
      throw MatrixAndVectorAreNotCompatible();
    }
    if (matrix.isSquare == false) {
      throw MatrixIsNotSquare();
    }
  }

  bool get areCompatible => matrix.n == vectorB.length;

  Matrix get transportedMatrix => matrix.transposed;

  // solution discrepancy
  double dicrepancy(List<double> solution) {
    Matrix r = matrix * Matrix.fromList(solution).transposed -
        Matrix.fromList(vectorB).transposed;

    r = r.transposed;
    // we got vector of discrepancy
    // we need to find sqrt of sum of squares of discrepancy
    double result = 0;
    for (int i = 0; i < n; i++) {
      result += r.data[0][i] * r.data[0][i];
    }
    return sqrt(result);
  }
}
