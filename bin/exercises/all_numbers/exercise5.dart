part of exercises;

void exercise5() {
  print('This is simple iteration method');
  YacobiMethod system = YacobiMethod.fromInputData(system1, eps: 0.001);
  List<double> x = system.solution();
  print('Solution:');
  print(x);
  print('\n\n');
}
