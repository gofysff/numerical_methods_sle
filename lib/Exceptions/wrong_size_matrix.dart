class WrongSizeOfMatrix implements Exception {
  final String? message;
  WrongSizeOfMatrix({this.message});
  @override
  String toString() => 'Wrong size of matrix\n$message';
}
