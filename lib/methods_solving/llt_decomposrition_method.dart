import 'package:number_methods/basic_classes/system_input.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';
import 'dart:math';

import '../basic_classes/matrix.dart';

class LLTDecomposition extends SystemLinerEquations {
  LLTDecomposition.fromInputData(super.input) : super.fromInputData();
  // constructor

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

    // print('Lower triangular matrix:');
    // lower.printMatrix();

    // print('Lower transposed matrix:');
    // lowerTransposed.printMatrix();

    // same logic as in [LUDecomposition] class
    // Обратный ход (Поиск решений) (Нижнетреугольная)

    for (int i = 0; i < n; i++) {
      double sum = 0;
      for (int j = 0; j < i; j++) {
        sum += lower.data[i][j] * y[j];
      }
      y[i] = (vectorB[i] - sum) / lower.data[i][i];
    }

    // Обратный ход (Поиск решений)

    for (int i = n - 1; i >= 0; i--) {
      double sum = 0;
      for (int j = i + 1; j < n; j++) {
        sum += lowerTransposed.data[i][j] * x[j];
      }
      x[i] = (y[i] - sum) / lowerTransposed.data[i][i];
    }

    return x;
  }
}

void main(List<String> args) {
  // create input data
  List<List<double>> matr = [
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
  print('Lower triangular matrix2:');

  print('LT matrix');
  lower.transposed.printMatrix();
  // var res = lower * lower.transposed;
  print('REs');
  // lower.transposed.printMatrix();
  // res.printMatrix();

  print(system.solution());
}
