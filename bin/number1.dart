import 'package:number_methods/methods_solving/gause_with_main_element.dart';
import 'package:number_methods/input_data/exercises_transformed_data.dart';

void firstNumber() {
  GauseWithMainElement systemFirst =
      GauseWithMainElement.fromSystemInput(system1);
  List<double> solution = systemFirst.solution();
  print('Solution of the first system: $solution');
  double dicrepancy = systemFirst.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');

  print('\n\n');
  GauseWithMainElement systemSecond =
      GauseWithMainElement.fromSystemInput(system2);
  solution = systemSecond.solution();
  print('Solution of the second system: $solution');
  dicrepancy = systemSecond.dicrepancy(solution);
  print('Dicrepancy of the second system: $dicrepancy');
  print('\n\n');

  GauseWithMainElement systemThird =
      GauseWithMainElement.fromSystemInput(system3);
  solution = systemThird.solution();
  print('Solution of the third system: $solution');
  dicrepancy = systemThird.dicrepancy(solution);
  print('Dicrepancy of the third system: $dicrepancy');
}

void main(List<String> arguments) {
  firstNumber();
}
