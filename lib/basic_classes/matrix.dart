import 'dart:math';

import 'package:number_methods/Exceptions/matrix_is_not_square.dart';

import '../Exceptions/wrong_size_matrix.dart';

class Matrix {
  List<List<num>> data;

  /// height
  final int n;

  /// width
  final int m;

  Matrix(this.data)
      : n = data.length,
        m = data[0].length;

  @override
  String toString() {
    List<String> result = [];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        result.add('${data[i][j]}\t');
      }
      result.add('\n');
    }
    return result.join();
  }

  void printMatrix() {
    print(toString());
  }

  bool get isSquare => n == m;

  /// return true if matrix is nonsingular (determinant != 0) (невырожденная матрица)
  bool get isNonsingular => isSquare && (determinant != 0);

  // equal check for two matrices by comparing their data
  @override
  bool operator ==(Object other) // ignore: hash_and_equals
  {
    if (other is Matrix) {
      if (n != other.n || m != other.m) {
        return false;
      }
      for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
          if (data[i][j] != other.data[i][j]) {
            return false;
          }
        }
      }
      return true;
    }
    return false;
  }

  bool get isMatrixSymmetrical => this == transported;

  Matrix cofactor(int iExclude, int jExclude, Matrix matrix) {
    // iExclude and jExclude are the indexes what we wanna exclude from matrix
    List<List<num>> newData = [];
    for (int i = 0; i < matrix.n; i++) {
      if (i == iExclude) {
        continue;
      }
      List<num> row = [];
      for (int j = 0; j < matrix.m; j++) {
        if (j == jExclude) {
          continue;
        }
        row.add(matrix.data[i][j]);
      }
      newData.add(row);
    }
    return Matrix(newData);
  }

  Matrix get transported {
    List<List<num>> newData = [];
    for (int i = 0; i < m; i++) {
      List<num> row = [];
      for (int j = 0; j < n; j++) {
        row.add(data[j][i]);
      }
      newData.add(row);
    }
    return Matrix(newData);
  }

  /// return submatrix from rows and columns
  /// rows and columns are the indexes of the elements in the original matrix
  Matrix subMatrixFromRowsAndColumns(
      {required List<int> rows, required List<int> columns}) {
    List<List<num>> newData = [];
    for (int i = 0; i < rows.length; i++) {
      List<num> row = [];
      for (int j = 0; j < columns.length; j++) {
        row.add(data[rows[i]][columns[j]]);
      }
      newData.add(row);
    }
    return Matrix(newData);
  }

  num get determinant2x2 {
    // default math formules
    if (m != 2 || n != 2) {
      throw WrongSizeOfMatrix();
    }
    return data[0][0] * data[1][1] - data[0][1] * data[1][0];
  }

  num get determinant3x3 {
    // default math formules
    if (m != 3 || n != 3) {
      throw WrongSizeOfMatrix();
    }
    return data[0][0] * data[1][1] * data[2][2] +
        data[0][1] * data[1][2] * data[2][0] +
        data[0][2] * data[1][0] * data[2][1] -
        data[0][2] * data[1][1] * data[2][0] -
        data[0][1] * data[1][0] * data[2][2] -
        data[0][0] * data[1][2] * data[2][1];
  }

  num get determinant {
    if (isSquare == false) {
      throw MatrixIsNotSquare();
    }
    if (n == 1) {
      return data[0][0];
    } else if (n == 2) {
      return determinant2x2;
    } else if (n == 3) {
      return determinant3x3;
    } else {
      double det = 0;
      for (int i = 0; i < n; i++) {
        det += pow(-1, i + 2) * data[0][i] * cofactor(0, i, this).determinant;
      }
      return det;
    }
  }

  /// nethod that plus/minus one specific row to another multiplied by a double number (k)
  /// if k is positive, then we add, if k is negative, then we subtract
  void plusMinusRowToAnother(
      int executableRowIndex, int performedRowIndex, double k) {
    for (int i = 0; i < m; i++) {
      data[executableRowIndex][i] += k * data[performedRowIndex][i];
    }
  }

  /// get the row with the maximum element by module
  /// return only one integer - the index of the row
  ///
  /// if there are several rows with the same maximum element by module,
  /// then the first row is returned
  int get rowWithMaxElementByModule {
    int maxRowIndex = 0;
    num maxElement = data[0][0];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if (data[i][j].abs() > maxElement.abs()) {
          maxElement = data[i][j];
          maxRowIndex = i;
        }
      }
    }
    return maxRowIndex;
  }

  /// return index of row where is located maximum element by module in column k
  /// if there are several rows with the same maximum element by **module**,
  /// then the first row is returned

  int findRowWithMaxElementInColumnK(int k) {
    int maxRowIndex = 0;
    num maxElement = data[0][k];
    for (int i = 0; i < n; i++) {
      if (data[i][k].abs() > maxElement.abs()) {
        maxElement = data[i][k];
        maxRowIndex = i;
      }
    }
    return maxRowIndex;
  }

  void swapRows(int firstRowIndex, int secondRowIndex) {
    List<num> temp = data[firstRowIndex];
    data[firstRowIndex] = data[secondRowIndex];
    data[secondRowIndex] = temp;
  }
}
