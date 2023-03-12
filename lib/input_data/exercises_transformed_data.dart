import 'package:number_methods/basic_classes/input_system.dart';

import '../basic_classes/matrix.dart';
import './exercises_poor_data.dart' as poor_data;

Matrix matrix1 = Matrix(poor_data.matrix1);
Matrix matrix2 = Matrix(poor_data.matrix2);
Matrix matrix3 = Matrix(poor_data.matrix3);

SystemInput system1 = SystemInput(matrix1, poor_data.b1);
SystemInput system2 = SystemInput(matrix2, poor_data.b2);
SystemInput system3 = SystemInput(matrix3, poor_data.b3);
