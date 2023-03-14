import '../basic_classes/input_system.dart';
import '../basic_classes/matrix.dart';
import '../basic_classes/system_of_liner_equations.dart';

class GauseWithMainElement extends SystemLinerEquations {
  GauseWithMainElement(super.matrix, super.vectorB);
  GauseWithMainElement.fromSystemInput(SystemInput systemInput)
      : super(systemInput.matrix, systemInput.vectorB);

  /// solve method for system of liner equations with Gause method
  /// with main element
  /// with comments for every logical block

  /// return list of solutions of system of liner equations( List<double> )
  @override
  List<double> solution() {
    int n = matrix.n; // number of equations
    /// [0] - x1, [1] - x2, [2] - x3, ...
    List<int> indexesOfResult = List.generate(n, (index) => index);
    List<double> x = List.filled(n, 0); // list of solutions
    List<List<double>> matrixA = matrix.data; // data of matrix
    List<double> b = vectorB; // vector of system of liner equations

    for (int k = 0; k < n; k++) {
      // find indexes of main element in data using getter [rowWithMaxElementByModule] of class [Matrix]
      List<num> infoAboutMaxElement =
          matrix.findMaxElementInSubMatrix(beginIndRow: k, beginIndColumn: k);
      // double maxElem = infoAboutMaxElement[0].toDouble();
      // print(maxElem);
      int indexMaxRow = infoAboutMaxElement[1].toInt();
      int indexMaxColumn = infoAboutMaxElement[2].toInt();

      // swap rows in data of matrix using method [swapRows] of class [Matrix]
      if (k < indexMaxRow) {
        matrix.swapRows(k, indexMaxRow);
        // swap elements in vector of system of liner equations
        double temp = b[k];
        b[k] = b[indexMaxRow];
        b[indexMaxRow] = temp;
        // print('swapped rows: $k and $indexMax');
      }

      // int indexMaxColumn =
      //     matrix.findColumnWithMaxElementInRowK(k, beginIndColumn: k);

      if (k < indexMaxColumn) {
        //swap data in colums of indexes of result
        int temp = indexesOfResult[k];
        indexesOfResult[k] = indexesOfResult[indexMaxColumn];
        indexesOfResult[indexMaxColumn] = temp;
        // swap columns in data of matrix
        matrix.swapColumns(k, indexMaxColumn);
      }

      // find coefficients of equations and free members of equations
      // i = k + 1 because we don't wanna subststitute this row

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
      print('after changing: ');
      matrix.printMatrix();
    }

    //? uncomment  line beneath to see matrix after Gause method
    // print('Matrix A after Gause method: ');
    // Matrix(matrixA).printMatrix();

    // find solutions of system of liner equations

    // we have triangular matrix and we can find solutions
    // zeroes are below diagonal

    // x[n - 1] = b[n - 1] / matrixA[n - 1][n - 1];
    // x[n - 2] = (b[n - 2] - matrixA[n - 2][n - 1] * x[n - 1])
    //    / matrixA[n - 2][n - 2];
    // x[n - 3] = (b[n - 3] - matrixA[n - 3][n - 1] * x[n - 1] -
    //         matrixA[n - 3][n - 2] * x[n - 2]) /
    //     matrixA[n - 3][n - 3];

    for (int i = n - 1; i >= 0; i--) {
      x[i] = b[i];
      for (int j = i + 1; j < n; j++) {
        //   /* Initialize j to i+1 since matrix is upper
        x[i] -= matrixA[i][j] * x[j];
      }
      x[i] /= matrixA[i][i];
    }

    // rearrange order of solutions according to indexes of result
    // print(x);
    // print(indexesOfResult);
    List<double> result = List.filled(n, 0);
    for (int i = 0; i < n; i++) {
      result[indexesOfResult[i]] = x[i];
    }
    return result;
  }
}

void main(List<String> args) {
  List<List<double>> matrix = [
    [1.001, 2.001, 3.001],
    [4.001, 5.001, 6.001],
    [7.001, 8.001, 9.001],
  ];
  List<double> vectorB = [2.001, 5.001, 8.001];
  SystemInput system = SystemInput(Matrix(matrix), vectorB);
  GauseWithMainElement gauseSys = GauseWithMainElement.fromSystemInput(system);
  var res = gauseSys.solution();
  print(res);
}
