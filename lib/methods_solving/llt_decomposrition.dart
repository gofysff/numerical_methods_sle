import 'package:number_methods/basic_classes/input_system.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';
import 'dart:math';

import '../basic_classes/matrix.dart';

class LLTDecomposition extends SystemLinerEquations {
  LLTDecomposition.fromInputData(super.input) : super.fromInputData();
  // constructor

  // get lower triangular matrix
  // Matrix get lowerTriangle {
  //   // get matrix data
  //   List<List<double>> matr = matrix.data;
  //   // create lower triangular matrix
  //   List<List<double>> lower =
  //       List.generate(n, (i) => List.generate(n, (j) => 0.0), growable: false);

  //   // l_11 = sqrt(a_11)
  //   // l_j1 = a_j1 / l_11 for j = 2, 3, ..., n
  //   matrix.printMatrix();
  //   lower[0][0] = sqrt(matr[0][0]);
  //   for (int j = 1; j < n; j++) {
  //     lower[j][0] = matr[j][0] / lower[0][0];
  //   }
  //   // l_ii = sqrt(a_ii - sum(l_ij^2) for j = 1, 2, ..., i - 1)
  //   // l_ji = 1/l_ii(a_ji - sum(l_jk * l_ik) for k = 1, 2, ..., i - 1) for j = i + 1, i + 2, ..., n

  //   // Matrix(lower).printMatrix();
  //   for (int i = 1; i < n; i++) {
  //     // if (lower[3][3].isNaN) {
  //     //   print('before');
  //     // }

  //     // Matrix(lower).printMatrix();
  //     print(lower[i].sublist(0, i));

  //     double sum = lower[i].sublist(0, i).asMap().entries.fold(0.0,
  //         (previousValue, element) => previousValue + pow(element.value, 2));

  //     lower[i][i] = sqrt(matr[i][i] - sum);

  //     // if (lower[3][3].isNaN) {
  //     //   print(lower[i].sublist(0, i));
  //     //   print('middle$i');
  //     //   Matrix(lower).printMatrix();
  //     // }
  //     for (int j = i + 1; j < n; j++) {
  //       // if (j == 3 && i == 2) {
  //       //   print('before');
  //       // }
  //       double sum2 = lower[j].sublist(0, i).asMap().entries.fold(
  //               0.0,
  //               (previousValue, element) =>
  //                   previousValue + element.value * lower[i][element.key]) /
  //           lower[i][i];
  //       lower[j][i] = (matr[j][i] - sum2);

  //       // if (lower[3][3].isNaN) {
  //       //   print('after');
  //       // }
  //     }
  //   }
  //   return Matrix(lower);
  // }

  Matrix get lowerTriangle {
    /// lower matrix
    List<List<double>> L =
        List.generate(n, (i) => List.generate(n, (j) => 0.0), growable: false);
    List<List<double>> A = matrix.data;
    for (int i = 0; i < n; i++) {
      double temp;
      //Сначала вычисляем значения элементов слева от диагонального элемента,
      //так как эти значения используются при вычислении диагонального элемента.
      for (int j = 0; j < i; j++) {
        temp = 0;
        for (int k = 0; k < j; k++) {
          temp += L[i][k] * L[j][k];
        }
        L[i][j] = (A[i][j] - temp) / L[j][j];
      }

      //Находим значение диагонального элемента
      temp = A[i][i];
      for (int k = 0; k < i; k++) {
        temp -= L[i][k] * L[i][k];
      }
      L[i][i] = sqrt(temp);
    }

    return Matrix(L);
  }

  @override
  List<double> solution() {
    // get lower triangular matrix
    Matrix lower = lowerTriangle;
    Matrix lowerTransposed = lower.transposed;
    // create list of solutions y
    List<double> y = List.filled(n, 0);
    // create list of solutions
    List<double> x = List.filled(n, 0);
    // find solutions

    print('Lower triangular matrix:');
    lower.printMatrix();

    print('Lower transposed matrix:');
    lowerTransposed.printMatrix();
    // same logic as in [LUDecomposition] class
    y[0] = vectorB[0] / lower.data[0][0];
    for (int i = 1; i < n; i++) {
      double sum = 0;
      for (int j = 0; j < i; j++) {
        sum += lower.data[i][j] * y[j];
      }
      y[i] = (vectorB[i] - sum) / lower.data[i][i];
    }

    x[n - 1] = y[n - 1];
    for (int i = n - 2; i >= 0; i--) {
      double sum = 0;
      for (int j = i + 1; j < n; j++) {
        sum += lowerTransposed.data[i][j] * x[j];
      }
      x[i] = y[i] - sum;
    }

    return x;
  }
}

void main(List<String> args) {
  // create input data
  List<List<double>> matr = [
    // [4, 12, -16],
    // [12, 37, -43],
    // [-16, -43, 98]
    [25, 25, -10, 25],
    [25, 41, -30, 33],
    [-10, -30, 45, -16],
    [25, 33, -16, 34]
  ];
  List<double> vectorB = [160, -12, 331, 155];
  // create system of liner equations
  LLTDecomposition system =
      LLTDecomposition.fromInputData(SystemInput(Matrix(matr), vectorB));
  // get lower triangular matrix
  Matrix lower = system.lowerTriangle;
  // print result
  print('Lower triangular matrix:');
  lower.printMatrix();
  print('LT matrix');
  lower.transposed.printMatrix();
  var res = lower * lower.transposed;
  print('REs');
  // lower.transposed.printMatrix();
  res.printMatrix();
}
