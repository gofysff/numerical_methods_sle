import '../basic_classes/matrix.dart';
import '../basic_classes/system_of_liner_equations.dart';

mixin GauseWithMainElement on SystemLinerEquations {
  /// solve method for system of liner equations with Gause method
  /// with main element
  /// with comments for every logical block

  /// return list of solutions of system of liner equations( List<double> )
  List<double> solution() {
    int n = matrix.n; // number of equations
    List<double> x = List.filled(n, 0); // list of solutions
    List<List<double>> matrixA = matrix.data; // data of matrix
    List<double> b = vector; // vector of system of liner equations

    for (int k = 0; k < n; k++) {
      // print('new variable: $k');
      // Matrix(matrixA).printMatrix();
      // find indexes of main element in data using getter [rowWithMaxElementByModule] of class [Matrix]
      int indexMax = matrix.findRowWithMaxElementInColumnK(k);

      // swap rows in data of matrix using method [swapRows] of class [Matrix]
      if (k < indexMax) {
        matrix.swapRows(k, indexMax);
        // print('swapped rows: $k and $indexMax');
      }

      // swap elements in vector of system of liner equations
      double temp = b[k];
      b[k] = b[indexMax];
      b[indexMax] = temp;

      // find coefficients of equations and free members of equations
      // i = k + 1 because we don't wanna subststitute this row
      // Matrix(matrixA).printMatrix();

      for (int i = k + 1; i < n; i++) {
        // find coefficient of equation
        double coefficient = matrixA[i][k] /= matrixA[k][k];
        // this coefficient will be used in next loop for acting with other elements of matrix
        for (int j = k + 1; j < n; j++) {
          matrixA[i][j] -= coefficient * matrixA[k][j];
        }
        /* filling lower triangular matrix with
                 * zeros*/
        matrixA[i][k] = 0.0;
        b[i] -= coefficient * b[k]; // find free member of equation
        // Matrix(matrixA).printMatrix();
      }
    }

    //? uncomment  line beneath to see matrix after Gause method
    print('Matrix A after Gause method: ');
    Matrix(matrixA).printMatrix();

    // find solutions of system of liner equations

    // we have triangular matrix and we can find solutions
    // zeroes are below diagonal
    for (int i = n - 1; i >= 0; i--) {
      x[i] = b[i]; // start with the RHS of the equation (free member)

      /* Initialize j to i+1 since matrix is upper
              triangular*/
      for (int j = i + 1; j < n; j++) {
        //   subtract all the lhs values
        //   except the coefficient of the variable
        //   whose value is being calculated
        x[i] -= matrixA[i][j] * x[j];
      }

      // now finally divide the RHS by the coefficient
      x[i] /= matrixA[i][i];
    }
    print('Matrix b:');
    Matrix.fromList(b).printMatrix();
    return x;
  }
}
