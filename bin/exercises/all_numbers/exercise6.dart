part of exercises;

void exercise6() {
  print('this is Zeidel method');
  ZeidelMethod system = ZeidelMethod.fromInputData(system1, eps: 0.001);
  List<double> x = system.solution();
  print('Solution:');
  print(x);
  print('\n\n');
}
