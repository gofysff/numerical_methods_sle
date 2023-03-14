import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/lu_decomposrition.dart';

void secondNumer() {
  LUDecomposition system = LUDecomposition.fromSystemInput(system2);

  List<double> solution = system.solution();
  print('Solution of the second system: $solution');

  double dicrepancy = system.dicrepancy(solution);
  print('dicrepancy of solution is $dicrepancy');
}

void main(List<String> arguments) {
  secondNumer();
}
