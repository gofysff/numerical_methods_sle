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
  // SystemInput get recombinateByColumn {
  //   Matrix tempMatrix = matrix.copy();
  //   List<double> tempVectorB = List.from(vectorB);
  //   for (var k = 0; k < n; k++) {
  //     // find row with max element in column k
  //     int rowWithMaxElement = tempMatrix.findRowWithMaxElementInColumnK(k);
  //     // swap rows
  //     if (k < rowWithMaxElement) {
  //       tempMatrix.swapRows(k, rowWithMaxElement);
  //       // swap b vector
  //       double temp = tempVectorB[k];
  //       tempVectorB[k] = tempVectorB[rowWithMaxElement];
  //       tempVectorB[rowWithMaxElement] = temp;
  //     }
  //   }
  //   return SystemInput(tempMatrix, tempVectorB);
  // }

  // SystemInput get recombinateByColumn {
  //   List<int> indexesOfResult = List.generate(n, (index) => index);

  //   Matrix tempMatrix = matrix.copy();
  //   // List<List<double>> matrixA = tempMatrix.data; // data of matrix
  //   List<double> b = List.from(vectorB); // vector of system of liner equations

  //   for (int k = 0; k < n; k++) {
  //     // find indexes of main element in data using getter [rowWithMaxElementByModule] of class [Matrix]
  //     List<num> infoAboutMaxElement =
  //         matrix.findMaxElementInSubMatrix(beginIndRow: k, beginIndColumn: k);
  //     // double maxElem = infoAboutMaxElement[0].toDouble();
  //     // print(maxElem);
  //     int indexMaxRow = infoAboutMaxElement[1].toInt();
  //     int indexMaxColumn = infoAboutMaxElement[2].toInt();

  //     // swap rows in data of matrix using method [swapRows] of class [Matrix]
  //     if (k < indexMaxRow) {
  //       tempMatrix.swapRows(k, indexMaxRow);

  //       // swap elements in vector of system of liner equations
  //       double temp = b[k];
  //       b[k] = b[indexMaxRow];
  //       b[indexMaxRow] = temp;
  //       // print('swapped rows: $k and $indexMax');
  //     }

  //     if (k < indexMaxColumn) {
  //       //swap data in colums of indexes of result
  //       int temp = indexesOfResult[k];
  //       indexesOfResult[k] = indexesOfResult[indexMaxColumn];
  //       indexesOfResult[indexMaxColumn] = temp;
  //       // swap columns in data of matrix
  //       tempMatrix.swapColumns(k, indexMaxColumn);
  //     }

  //     // matrixA = tempMatrix.data;
  //   }
  //   List<double> resultB = List.filled(n, 0);
  //   for (int i = 0; i < n; i++) {
  //     resultB[indexesOfResult[i]] = b[i];
  //   }
  //   return SystemInput(tempMatrix, resultB);
  // }

  /// mehtod that return recombinated matrix and vector b recombinated in same way
  /// where every biggest element in column k by module element of column is located on the diagonal

  SystemInput get recombinateByColumn {
    List<int> indexesOfResult = List.generate(n, (index) => index);

    Matrix tempMatrix = matrix.copy();
    List<List<double>> matrixA = tempMatrix.data; // data of matrix
    List<double> b = List.from(vectorB); // vector of system of liner equations

    for (int k = 0; k < n; k++) {
      // print('k is: $k');
      // tempMatrix.printMatrix();
      // print('b is: $b');
      // find indexes of main element in data using getter [rowWithMaxElementByModule] of class [Matrix]
      List<num> infoAboutMaxElement =
          matrix.findMaxElementInSubMatrix(beginIndRow: k, beginIndColumn: k);
      // double maxElem = infoAboutMaxElement[0].toDouble();
      // print(maxElem);
      int indexMaxRow = infoAboutMaxElement[1].toInt();
      int indexMaxColumn = infoAboutMaxElement[2].toInt();

      // swap rows in data of matrix using method [swapRows] of class [Matrix]
      if (k < indexMaxRow) {
        tempMatrix.swapRows(k, indexMaxRow);

        // swap elements in vector of system of liner equations
        double temp = b[k];
        b[k] = b[indexMaxRow];
        b[indexMaxRow] = temp;
        // print('matrix if we swap rows');
        // tempMatrix.printMatrix();
        // print('b is: $b');
        // print('swapped rows: $k and $indexMax');
      }

      if (k < indexMaxColumn) {
        //swap data in colums of indexes of result
        int temp = indexesOfResult[k];
        indexesOfResult[k] = indexesOfResult[indexMaxColumn];
        indexesOfResult[indexMaxColumn] = temp;
        // swap columns in data of matrix
        // tempMatrix.swapColumns(k, indexMaxColumn);
        // print('matrix if we swap columns');
        // tempMatrix.printMatrix();
        // print('b is: $b');
      }
      for (int i = k + 1; i < n; i++) {
        // find coefficient of equation
        double coefficient = matrixA[i][k] / matrixA[k][k];

        // this coefficient will be used in next loop for acting with other elements of matrix
        for (int j = k; j < n; j++) {
          // k+1
          matrixA[i][j] -= coefficient * matrixA[k][j];
        }
        /* filling lower triangular matrix with
                 * zeros*/
        matrixA[i][k] = 0.0;
        b[i] -= coefficient * b[k]; // find free member of equation
        // Matrix(matrixA).printMatrix();
      }
      // matrixA = tempMatrix.data;
    }
    return SystemInput(tempMatrix, b);
  }
}
