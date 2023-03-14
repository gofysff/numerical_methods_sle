import 'package:number_methods/basic_classes/input_system.dart';
import 'package:number_methods/basic_classes/matrix.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';

class SweepMethod extends SystemLinerEquations {
  SweepMethod.fromInputData(super.input) : super.fromInputData();

  @override
  List<double> solution() {
    // get matrix data
    List<List<double>> matr = matrix.copy().data;
    // create list of solutions
    List<double> x = List.filled(n, 0);
    // find solutions

    // coefficients v and u
    // v equal c(from lecture)
    // u equal d(from lecture)
    List<double> v = List.filled(n, 0);
    List<double> u = List.filled(n, 0);
    // find v and u
    // 1st row
    v[0] = -matr[0][1] / matr[0][0];
    u[0] = vectorB[0] / matr[0][0];

    // all except first and last
    for (var i = 1; i < n - 1; i++) {
      v[i] = matr[i][i + 1] / (-matr[i][i] - matr[i][i - 1] * v[i - 1]);
      u[i] = (matr[i][i - 1] * u[i - 1] - vectorB[i]) /
          (-matr[i][i] - matr[i][i - 1] * v[i - 1]);
    }

    // for last (n -1)
    v[n - 1] = 0;
    u[n - 1] = (matr[n - 1][n - 2] * u[n - 2] - vectorB[n - 1]) /
        (-matr[n - 1][n - 1] - matr[n - 1][n - 2] * v[n - 2]);

    // reverse steps
    x[n - 1] = u[n - 1];
    for (int i = n - 1; i > 0; i--) {
      x[i - 1] = v[i - 1] * x[i] + u[i - 1];
    }
    return x;
  }
}

void main(List<String> args) {
  List<List<double>> a = [
    [10.8000, 0.0475, 0, 0],
    [0.0321, 9.9000, 0.0523, 0],
    [0, 0.0369, 9.0000, 0.0570],
    [0, 0, 0.0416, 8.1000]
  ];
  List<double> b = [12.1430, 13.0897, 13.6744, 13.8972];

  SweepMethod system = SweepMethod.fromInputData(SystemInput(Matrix(a), b));
  List<double> x = system.solution();
  print('Solution:');
  print(x);
}
