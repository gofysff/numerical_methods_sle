import '../basic_classes/matrix.dart';
import '../basic_classes/system_of_liner_equations.dart';
import './exercises_poor_data.dart' as poor_data;

Matrix matrix1 = Matrix(poor_data.matrix1);
Matrix matrix2 = Matrix(poor_data.matrix2);
Matrix matrix3 = Matrix(poor_data.matrix3);

SystemLinerEquations system1 = SystemLinerEquations(matrix1, poor_data.b1);
SystemLinerEquations system2 = SystemLinerEquations(matrix2, poor_data.b2);
SystemLinerEquations system3 = SystemLinerEquations(matrix3, poor_data.b3);
