part of exercises;

void exercise2() {
  print('this is LU decomposition method');
  LUDecomposition system = LUDecomposition.fromSystemInput(system2);

  List<double> solution = system.solution();
  print('Solution of the second system: $solution');

  double dicrepancy = system.dicrepancy(solution);
  print('dicrepancy of solution is $dicrepancy');
  print('\n\n');
}
