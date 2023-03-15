// TODO: create zeidel method
import 'package:number_methods/basic_classes/matrix.dart';
import 'package:number_methods/basic_classes/system_input.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';

class ZeidelMethod extends SystemLinerEquations {
  ZeidelMethod.fromInputData(super.input, {super.eps}) : super.fromInputData();

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

    List<List<double>> x = [];
    List<double> x0 = [];
    for (int i = 0; i < n; i++) {
      x0.add(b[i] / a.data[i][i]);
    }
    x.add(x0);
    int iteration = 0;
    while (true) {
      iteration++;
      List<double> xTemp = [];
      for (int i = 0; i < n; i++) {
        double sum = 0;
        for (int j = 0; j < n; j++) {
          if (i != j) {
            sum += x[iteration - 1][j] * a.data[i][j];
          }
        }

        double xCurrent = (b[i] - (sum)) / a.data[i][i];
        xTemp.add(xCurrent);
      }
      x.add(xTemp);
      // xTemp.clear();

      List<double> delta = [];
      bool flag = false;
      for (int i = 0; i < n; i++) {
        delta.add((x[iteration][i] - x[iteration - 1][i]).abs() /
            (x[iteration][i]).abs());
        if (delta[i] > eps!) {
          flag = true;
        }
      }

      if (flag == false) {
        break;
      }
    }
    return x[iteration];
  }
}
