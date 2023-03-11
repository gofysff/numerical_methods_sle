import 'package:test/test.dart';
import 'package:number_methods/basic_classes/matrix.dart';

void main() {
  //  test for all public methods of Matrix class
  group('Matrix', () {
    test('Matrix is square', () {
      final matrix = Matrix([
        [1.31, 9.63, -4.45],
        [6.1, -1.7, -2.56],
        [1.27, -0.05, 8.07],
      ]);
      expect(matrix.isSquare, true);
    });
    test('Matrix is not square', () {
      final matrix = Matrix([
        [1.31, 9.63, -4.45],
        [6.1, -1.7, -2.56],
      ]);
      expect(matrix.isSquare, false);
    });

    group('Matrix determinant checks', () {
      test('Matrix determinant 2x2', () {
        final matrix = Matrix([
          [1.31, 9.63],
          [6.1, -1.7],
        ]);
        expect(matrix.determinant, -60.97);
      });
      test('Matrix determinant 1x1', () {
        final matrix = Matrix([
          [1.31],
        ]);
        expect(matrix.determinant, 1.31);
      });
      test('Matrix determinant 3x3', () {
        final matrix = Matrix([
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9],
        ]);
        expect(matrix.determinant, 0);
      });

      test('Matrix determinant 3x3', () {
        final matrix = Matrix([
          [1, 2, 3],
          [4, 50, 6],
          [7, 8, 9],
        ]);
        expect(matrix.determinant, -540.0);
      });

      test('Matrix determinant 4x4', () {
        final matrix = Matrix([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16],
        ]);
        expect(matrix.determinant, 0);
      });

      test('Matrix determinant 4x4', () {
        final matrix = Matrix([
          [1, 2, 3, 4],
          [5, 6, 72, 8],
          [91, 10, 11, 12],
          [13, 14, 15, 16],
        ]);
        expect(matrix.determinant, -127920);
      });
    });

    group('TestSymmetricalFunctional', () {
      test('Matrix is symmetrical', () {
        final matrix = Matrix([
          [1, 2, 3],
          [2, 5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.isMatrixSymmetrical, true);
      });

      // another one test with matrix that not symmetrical
      test('Matrix is not symmetrical', () {
        final matrix = Matrix([
          [1, 5, 3],
          [2, 5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.isMatrixSymmetrical, false);
      });
    });

    group('check isNonsingularProperty', () {
      test('Matrix is singular', () {
        final matrix = Matrix([
          [1, 2, 3],
          [2, 5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.isNonsingular, false);
      });

      test('Matrix is Nonsingular', () {
        final matrix = Matrix([
          [1, 2, 32],
          [21, 5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.isNonsingular, true);
      });
    });

    group('find  position of maxinal element ', () {
      // find (row) position of maxinal element
      test('find row position of maxinal element', () {
        final matrix = Matrix([
          [1, 2, 32],
          [21, 5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.rowWithMaxElementByModule, 0);
      });

      test('find row position of maxinal element', () {
        final matrix = Matrix([
          [1, 2, -32],
          [21, -5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.rowWithMaxElementByModule, 0);
      });

      test('find row position of maxinal element', () {
        final matrix = Matrix([
          [21, -5, 6],
          [3, 6, 9],
          [1, 2, -32],
        ]);
        expect(matrix.rowWithMaxElementByModule, 2);
      });
    });

    group('swap rows ', () {
      // test for [swapRows] method of class [Matrix]
      test('swap rows', () {
        final matrix = Matrix([
          [1, 2, 32],
          [21, 5, 6],
          [3, 6, 9],
        ]);
        matrix.swapRows(0, 2);
        expect(matrix.data, [
          [3, 6, 9],
          [21, 5, 6],
          [1, 2, 32],
        ]);
      });
    });

    group('find row with max element in column k', () {
      // test for [findRowWithMaxElementInColumnK] method of class [Matrix]
      test('find row with max element in column k', () {
        final matrix = Matrix([
          [1, 2, 32],
          [21, 5, 6],
          [3, 6, 9],
        ]);
        expect(matrix.findRowWithMaxElementInColumnK(0), 1);
      });
    });
  });
}
