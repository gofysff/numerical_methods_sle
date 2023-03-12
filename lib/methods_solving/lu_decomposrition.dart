import 'package:number_methods/basic_classes/input_system.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';

import '../basic_classes/matrix.dart';

class LUDecomposition extends SystemLinerEquations {
  LUDecomposition(super.matrix, super.vectorB);
  LUDecomposition.fromSystemInput(SystemInput systemInput)
      : super(systemInput.matrix, systemInput.vectorB);

  /// Return low-triangular of the LU decomposition method.
  /// by scheme of Holecky
  List<Matrix> get triangulesHolecky {
    List<List<double>> matr = matrix.data;
    List<List<double>> lower =
        List.generate(n, (i) => List.generate(n, (j) => 0.0), growable: false);
    List<List<double>> upper =
        List.generate(n, (i) => List.generate(n, (j) => 0.0), growable: false);

    // first column
    // l_i1
    for (int i = 0; i < n; i++) {
      lower[i][0] = matr[i][0];
    }
    // first row
    // u_1j
    for (var j = 0; j < n; j++) {
      upper[0][j] = matr[0][j] / lower[0][0];
    }

    // if i == j then u_ij = 1
    // if i >= j >= 0 then l_ij = a_ij - sum(l_ik * u_kj) for k = 1, 2, ..., j - 1
    // 0 <= i <= j <= n - 1 u_ij = 1/(u_ii)(a_ij - sum(l_ik * u_kj)) for k = 1, 2, ..., i - 1

    for (int i = 1; i < n; i++) {
      for (int j = 1; j < n; j++) {
        if (i == j) {
          upper[i][j] = 1;
          lower[i][j] = matr[i][j] -
              lower[i].sublist(0, j).asMap().entries.fold(
                  0.0,
                  (previousValue, element) =>
                      previousValue + element.value * upper[element.key][j]);
        } else if (i >= j) {
          lower[i][j] = matr[i][j] -
              lower[i].sublist(0, j).asMap().entries.fold(
                  0.0,
                  (previousValue, element) =>
                      previousValue + element.value * upper[element.key][j]);
        } else {
          upper[i][j] = (matr[i][j] -
                  lower[i].sublist(0, i).asMap().entries.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue +
                          element.value * upper[element.key][j])) /
              lower[i][i];
        }
      }
    }
    return [Matrix(lower), Matrix(upper)];
  }

  /// solving method by LU decomposition what count by scheme of Holecky
  /// return solution of system
  List<double> solution() {
    List<Matrix> triangules = triangulesHolecky;
    Matrix lower = triangules[0];
    Matrix upper = triangules[1];
    List<double> y = List.generate(n, (i) => 0.0);
    List<double> x = List.generate(n, (i) => 0.0);
    // solving system Ly = b
    // l system is lower-triangular what have meanings on diagonal and below other elements are 0
    // y is vector of unknowns
    // b is vector of right side of system
    // y_1 = b_1/l_11
    // y_2 = (b_2 - l_21 * y_1)/l_22
    // y_3 = (b_3 - l_31 * y_1 - l_32 * y_2)/l_33
    // y_i = (b_i - sum(l_ij * y_j))/l_ii for j = 1, 2, ..., i - 1
    // 0 <= i <= n - 1
    y[0] = vectorB[0] / lower.data[0][0];
    for (int i = 1; i < n; i++) {
      double sum = 0;
      for (int j = 0; j < i; j++) {
        sum += lower.data[i][j] * y[j];
      }
      y[i] = (vectorB[i] - sum) / lower.data[i][i];
    }

    // solving system Ux = y
    // u system is upper-triangular what have meanings above diagonal and on diagonal other elements are 1
    // x is vector of unknowns
    // y is vector of right side of system
    // x_n = y_n
    // x_(n - 1) = y_(n - 1) - u_(n - 1)(n) * x_n
    // x_(n - 2) = y_(n - 2) - u_(n - 2)(n - 1) * x_(n - 1) - u_(n - 2)(n) * x_n
    // x_i = y_i - sum(u_ij * x_j) for j = i + 1, i + 2, ..., n - 1
    // 0 <= i <= n - 1
    x[n - 1] = y[n - 1];
    for (int i = n - 2; i >= 0; i--) {
      double sum = 0;
      for (int j = i + 1; j < n; j++) {
        sum += upper.data[i][j] * x[j];
      }
      x[i] = y[i] - sum;
    }

    return x;
  }
}

void main(List<String> args) {
  List<List<double>> test = [
    [5, 8, 1],
    [3, -2, 6],
    [2, 1, -1],
  ];

  Matrix(test).printMatrix();
  LUDecomposition example = LUDecomposition(Matrix(test), [2, -7, -5]);
  var triangles = example.triangulesHolecky;
  triangles[0].printMatrix();
  triangles[1].printMatrix();
  print(example.solution());
}
