import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/llt_decomposrition.dart';

void thirdNumber() {
  LLTDecomposition systemSecond = LLTDecomposition.fromInputData(system2);
  List<double> solution = systemSecond.solution();
  print('Solution of the first system: $solution');
}

void main(List<String> arguments) {
  thirdNumber();
}
