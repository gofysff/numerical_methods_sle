import 'package:number_methods/basic_classes/matrix.dart';
import 'package:number_methods/basic_classes/system_input.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';

class YacobiMethod extends SystemLinerEquations {
  YacobiMethod.fromInputData(super.input, {super.eps}) : super.fromInputData();

  @override
  List<double> solution() {
    if (eps == null) {
      throw Exception('Epsilon is not set');
    }
    // List<double> x = List.filled(n, 0);

    Matrix a = matrix.copy();
    SystemInput recombinated = recombinateByColumn;
    a = recombinated.matrix;
    List<double> b = recombinated.vectorB;

    Matrix d = Matrix(List.generate(n, (index) => List.filled(n, 0.0)));
    Matrix dReversed = Matrix(List.generate(n, (index) => List.filled(n, 0.0)));
    Matrix f = Matrix(List.generate(n, (index) => List.filled(n, 0.0)));

    // dill d, d_reversed, f
    for (int i = 0; i < n; i++) {
      d.data[i][i] = a.data[i][i];
      dReversed.data[i][i] = 1 / a.data[i][i];
      for (int j = 0; j < n; j++) {
        if (i != j) {
          f.data[i][j] = a.data[i][j];
        }
      }
    }

    Matrix c = -dReversed * f;
    Matrix dSmall = dReversed * Matrix.fromList(b).transposed;

    Matrix xPrevious = dSmall;
    Matrix xCurrent;
    int counter = 0;

    while (true) {
      counter++;
      xCurrent = c * xPrevious + dSmall;

      double normC = c.normCommon;

      if (normC / (1 - normC) * (xCurrent - xPrevious).normCommon < eps!) {
        break;
      }
      xPrevious = xCurrent;
    }
    print('amount of iterations $counter');

    return xCurrent.transposed.data[0]; // 1* n matrix
  }

  // @override
  // List<double> solution({double epsilon=0.001}) {

  // }
}
