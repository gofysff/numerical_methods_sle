part of exercises;

void exercise1() {
  print('This is Gause method');
  GauseWithMainElement systemFirst =
      GauseWithMainElement.fromSystemInput(system1);
  List<double> solution = systemFirst.solution();
  print('Solution of the first system: $solution');
  double dicrepancy = systemFirst.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');

  print('\n\n');
  GauseWithMainElement systemSecond =
      GauseWithMainElement.fromSystemInput(system2);
  solution = systemSecond.solution();
  print('Solution of the second system: $solution');
  dicrepancy = systemSecond.dicrepancy(solution);
  print('Dicrepancy of the second system: $dicrepancy');
  print('\n\n');

  GauseWithMainElement systemThird =
      GauseWithMainElement.fromSystemInput(system3);
  solution = systemThird.solution();
  print('Solution of the third system: $solution');
  dicrepancy = systemThird.dicrepancy(solution);
  print('Dicrepancy of the third system: $dicrepancy');
  print('\n\n');
}

void main(List<String> arguments) {
  exercise1();
}
