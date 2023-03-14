import 'matrix.dart';

class SystemInput {
  final Matrix matrix;
  final List<double> vectorB;
  final double? epsilon;
  SystemInput(this.matrix, this.vectorB, {this.epsilon});
}
