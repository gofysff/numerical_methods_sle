import 'package:number_methods/basic_classes/matrix.dart';
import 'package:number_methods/basic_classes/system_of_liner_equations.dart';
import 'package:number_methods/methods_solving/gause_with_main_element.dart';
import 'package:number_methods/input_data/exercises_transformed_data.dart';

class GauseMethod extends SystemLinerEquations with GauseWithMainElement {
  GauseMethod(Matrix matrix, List<double> vector) : super(matrix, vector);
  GauseMethod.fromSystem(SystemLinerEquations system)
      : super(system.matrix, system.vector);
}

void firstNumber() {
  GauseMethod systemFirst = GauseMethod.fromSystem(system1);
  List<double> solution = systemFirst.solution();
  print('Solution of the first system: $solution');
  double dicrepancy = systemFirst.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');

  print('\n\n');
  GauseMethod systemSecond = GauseMethod.fromSystem(system2);
  solution = systemSecond.solution();
  print('Solution of the second system: $solution');
  dicrepancy = systemSecond.dicrepancy(solution);
  print('Dicrepancy of the second system: $dicrepancy');
  print('\n\n');

  GauseMethod systemThird = GauseMethod.fromSystem(system3);
  solution = systemThird.solution();
  print('Solution of the third system: $solution');
  dicrepancy = systemThird.dicrepancy(solution);
  print('Dicrepancy of the third system: $dicrepancy');
}

void main(List<String> arguments) {
  firstNumber();
}
