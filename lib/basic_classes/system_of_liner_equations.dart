import 'package:number_methods/Exceptions/matrix_is_not_square.dart';

import '../Exceptions/matrix_and_vector_are_not_compatible.dart';
import 'matrix.dart';

class SystemLinerEquations {
  Matrix matrix;
  List<num> vector;
  final int n;
  SystemLinerEquations(this.matrix, this.vector) : n = matrix.n {
    if (!areCompatible) {
      throw MatrixAndVectorAreNotCompatible();
    }
    if (matrix.isSquare == false) {
      throw MatrixIsNotSquare();
    }
  }

  bool get areCompatible => matrix.n == vector.length;

  Matrix get transportedMatrix => matrix.transported;
}
