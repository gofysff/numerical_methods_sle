import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/llt_decomposrition_method.dart';

void thirdNumber() {
  LLTDecomposition systemSecond = LLTDecomposition.fromInputData(system2);
  List<double> solution = systemSecond.solution();
  print('Solution of the first system: $solution');
  double dicrepancy = systemSecond.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');
}

void main(List<String> arguments) {
  thirdNumber();
}
