import 'package:test/test.dart';
import 'package:number_methods/basic_classes/matrix.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';

import 'package:number_methods/methods_solving/gause_with_main_element.dart';

class Oursolution extends SystemLinerEquations with GauseWithMainElement {
  Oursolution(Matrix matrix, List<double> vector) : super(matrix, vector);
  Oursolution.fromSystem(SystemLinerEquations system)
      : super(system.matrix, system.vector);
}

final List<List<double>> testMatrix = [
  [2, 4, 1],
  [5, 2, 1],
  [2, 3, 4],
];

final List<double> testVector = [36, 47, 37];
void main(List<String> arguments) {
  group('Test_method', () {
    Oursolution testSystem = Oursolution(Matrix(testMatrix), testVector);
    // testSystem.matrix.printMatrix();
    // print(testSystem.solution());
    test('Test_method', () {
      expect(testSystem.solution(), [7.0, 5.0, 2.0]);
    });
  });
  Oursolution testSystem = Oursolution(Matrix(testMatrix), testVector);
  testSystem.matrix.printMatrix();
  print(testSystem.solution());
}
