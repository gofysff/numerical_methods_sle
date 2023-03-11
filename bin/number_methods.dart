import 'package:number_methods/basic_classes/matrix.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';
import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/gause_with_main_element.dart';

class Oursolution extends SystemLinerEquations with GauseWithMainElement {
  Oursolution(Matrix matrix, List<num> vector) : super(matrix, vector);
  Oursolution.fromSystem(SystemLinerEquations system)
      : super(system.matrix, system.vector);
}

final List<List<num>> testMatrix = [
  [2, 4, 1],
  [5, 2, 1],
  [2, 3, 4],
];

final List<num> testVector = [36, 47, 37];
void main(List<String> arguments) {
  Oursolution testSystem = Oursolution(Matrix(testMatrix), testVector);
  testSystem.matrix.printMatrix();
  print(testSystem.solution());
}
