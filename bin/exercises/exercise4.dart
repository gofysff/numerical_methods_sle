import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/sweep_method.dart';

void exercise4() {
  print('this is sweep method');
  SweepMethod systemSecond = SweepMethod.fromInputData(system3);
  List<double> solution = systemSecond.solution();
  print('Solution of the first system: $solution');
  double dicrepancy = systemSecond.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');
  print('\n\n');
}
