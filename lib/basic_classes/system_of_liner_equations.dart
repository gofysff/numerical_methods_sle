import 'dart:math';

import 'package:number_methods/Exceptions/matrix_is_not_square.dart';

import '../Exceptions/matrix_and_vector_are_not_compatible.dart';
import 'system_input.dart';
import 'matrix.dart';

abstract class SystemLinerEquations {
  double? eps;
  Matrix matrix;
  List<double> vectorB;
  final int n;
  SystemLinerEquations(this.matrix, this.vectorB, {eps}) : n = matrix.n {
    if (!areCompatible) {
      throw MatrixAndVectorAreNotCompatible();
    }
    if (matrix.isSquare == false) {
      throw MatrixIsNotSquare();
    }
  }

  List<double> solution();

  SystemLinerEquations.fromInputData(SystemInput input, {this.eps})
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

    // print('matrix');
    // matrix.printMatrix();
    // print('solution');
    // Matrix.fromList(solution).transposed.printMatrix();
    // (matrix * Matrix.fromList(solution).transposed).printMatrix();
    // print('b');
    // Matrix.fromList(vectorB).printMatrix();
    // print('r');
    // r.printMatrix();
    r = r.transposed;

    // we got vector of discrepancy
    // we need to find sqrt of sum of squares of discrepancy
    double result = 0;
    for (int i = 0; i < n; i++) {
      result += r.data[0][i] * r.data[0][i];
    }
    return sqrt(result);
  }

  /// method that recombinate matrix so that every biggest element in column k
  ///  by module element of column is located on the diagonal
  ///
  /// we use [findRowWithMaxElementInColumnK] method of [Matrix] class to find row with max element in column k
  /// we use [swapRows] method  of [Matrix] class to do this and also swap b vector in same order
  /// if we already swapped this row we don't need to swap it again
  ///
  SystemInput get recombinateByColumn {
    Matrix tempMatrix = matrix.copy();
    List<double> tempVectorB = List.from(vectorB);
    for (var k = 0; k < n; k++) {
      // find row with max element in column k
      int rowWithMaxElement = tempMatrix.findRowWithMaxElementInColumnK(k);
      // swap rows
      if (k < rowWithMaxElement) {
        tempMatrix.swapRows(k, rowWithMaxElement);
        // swap b vector
        double temp = tempVectorB[k];
        tempVectorB[k] = tempVectorB[rowWithMaxElement];
        tempVectorB[rowWithMaxElement] = temp;
      }
    }
    return SystemInput(tempMatrix, tempVectorB);
  }
}
