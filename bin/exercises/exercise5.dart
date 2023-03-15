import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/yacobi_method.dart';

void exercise5() {
  print('This is simple iteration method');
  YacobiMethod system = YacobiMethod.fromInputData(system1, eps: 0.001);
  List<double> x = system.solution();
  print('Solution:');
  print(x);
  print('\n\n');
}
