import 'package:number_methods/input_data/exercises_transformed_data.dart';
import 'package:number_methods/methods_solving/zeidel_method.dart';

void exercise6() {
  print('this is Zeidel method');
  ZeidelMethod system = ZeidelMethod.fromInputData(system1, eps: 0.001);
  List<double> x = system.solution();
  print('Solution:');
  print(x);
  print('\n\n');
}
