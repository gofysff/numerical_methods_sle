part of exercises;

void exercise3() {
  print('This is LLT decomposition method');
  LLTDecomposition systemSecond = LLTDecomposition.fromInputData(system2);
  List<double> solution = systemSecond.solution();
  print('Solution of the second system: $solution');
  double dicrepancy = systemSecond.dicrepancy(solution);
  print('Dicrepancy of the second system: $dicrepancy');
  print('\n\n');
}
