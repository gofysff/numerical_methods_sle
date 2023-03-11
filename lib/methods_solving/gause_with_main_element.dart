import '../basic_classes/system_of_liner_equations.dart';

mixin GauseWithMainElement on SystemLinerEquations {
  /// solve method for system of liner equations with Gause method
  /// with main element
  /// with comments for every logical block

  /// return list of solutions of system of liner equations( List<num> )
  List<num> solution() {
    int n = matrix.n; // number of equations
    List<num> x = List.filled(n, 0); // list of solutions
    List<List<num>> a = matrix.data; // data of matrix
    List<num> b = vector; // vector of system of liner equations

    for (int k = 0; k < n; k++) {
      // find indexes of main element in data using getter [rowWithMaxElementByModule] of class [Matrix]
      int indexMax = matrix.findRowWithMaxElementInColumnK(k);

      // swap rows in data of matrix using method [swapRows] of class [Matrix]
      matrix.swapRows(k, indexMax);

      // swap elements in vector of system of liner equations
      num temp = b[k];
      b[k] = b[indexMax];
      b[indexMax] = temp;

      // find coefficients of equations

      // write commas in this block
      for (int i = k + 1; i < n; i++) {
        a[i][k] /= a[k][k]; // find coefficient of equation
        for (int j = k + 1; j < n; j++) {
          a[i][j] -= a[i][k] * a[k][j];
        }
        b[i] -= a[i][k] * b[k]; // find free member of equation
      }
    }
    // find solutions of system of liner equations
    for (int i = n - 1; i >= 0; i--) {
      x[i] = b[i];
      for (int j = i + 1; j < n; j++) {
        x[i] -= a[i][j] * x[j];
      }
      x[i] /= a[i][i];
    }

    return x;
  }
}
