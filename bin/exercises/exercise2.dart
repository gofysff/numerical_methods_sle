import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/lu_decomposrition_method.dart';

void exercise2() {
  print('this is LU decomposition method');
  LUDecomposition system = LUDecomposition.fromSystemInput(system2);

  List<double> solution = system.solution();
  print('Solution of the second system: $solution');

  double dicrepancy = system.dicrepancy(solution);
  print('dicrepancy of solution is $dicrepancy');
  print('\n\n');
}

void main(List<String> arguments) {
  exercise2();
}
