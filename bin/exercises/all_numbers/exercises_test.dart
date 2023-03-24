// import 'package:number_methods/basic_classes/matrix.dart';
// import 'package:number_methods/basic_classes/system_input.dart';
// import 'package:number_methods/methods_solving/gause_with_main_element_method.dart';
// import 'package:number_methods/methods_solving/llt_decomposrition_method.dart';
// import 'package:number_methods/methods_solving/lu_decomposrition_method.dart';
// import 'package:number_methods/methods_solving/sweep_method.dart';

part of exercises;

final List<List<double>> testValues = [
  [9.0, -3, -12, 9],
  [-3, 26, 24, 7],
  [-12, 24, 57, 16],
  [9, 7, 16, 45],
];

final List<double> btest = [-84, -162, -275, -476];

final List<List<double>> sweepData = [
  [5, -10, 0, 0],
  [-5, 15, -5, 0],
  [0, -3, -4, 23],
  [0, 0, -1, 2]
];

final List<double> sweepBTest = [-10, -15, 104, 5];

final List<List<double>> iterationdata = [
  [16, 0, -8],
  [0, 1, -5],
  [-8, -5, 54]
];

final List<double> iterationBVector = [56, -10, 97];

void testFunc() {
  SystemInput testData = SystemInput(Matrix(testValues), btest);

  print('\nGause');
  GauseWithMainElement testGaus =
      GauseWithMainElement.fromSystemInput(testData);
  List<double> solution = testGaus.solution();
  print('Solution of the first system: $solution');
  double dicrepancy = testGaus.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');

  print('\nLLt');

  LLTDecomposition testLLt = LLTDecomposition.fromInputData(testData);
  solution = testLLt.solution();
  print('Solution of the first system: $solution');
  dicrepancy = testLLt.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');

  print('\nLU');
  LUDecomposition testLU = LUDecomposition.fromSystemInput(testData);
  solution = testLU.solution();
  print('Solution of the first system: $solution');
  dicrepancy = testLU.dicrepancy(solution);
  print('Dicrepancy of the first system: $dicrepancy');

  print('SweepMethod');
  SweepMethod testSweep =
      SweepMethod.fromInputData(SystemInput(Matrix(sweepData), sweepBTest));
  solution = testSweep.solution();
  print('Solution of the 2 system: $solution');
  dicrepancy = testSweep.dicrepancy(solution);
  print('Dicrepancy of the 2 system: $dicrepancy');

  SystemInput testIterationData =
      SystemInput(Matrix(iterationdata), iterationBVector);

  print('\nYacobi method');
  YacobiMethod testYacobi =
      YacobiMethod.fromInputData(testIterationData, eps: 0.0001);
  solution = testYacobi.solution();
  print('Solution of the 3 system: $solution');

  print('\nZeidel method');
  ZeidelMethod testZeidel =
      ZeidelMethod.fromInputData(testIterationData, eps: 0.0001);
  solution = testZeidel.solution();
  print('Solution of the 3 system: $solution');
}
