import 'package:number_methods/basic_classes/matrix.dart';

import 'package:number_methods/methods_solving/gause_with_main_element_method.dart';

final List<List<double>> testMatrix = [
  [2, 4, 1],
  [5, 2, 1],
  [2, 3, 4],
];

final List<double> testVector = [36, 47, 37];
void main(List<String> arguments) {
  //TODO: make invocation of every number
  GauseWithMainElement testSystem =
      GauseWithMainElement(Matrix(testMatrix), testVector);
  testSystem.matrix.printMatrix();
  print(testSystem.solution());
}
