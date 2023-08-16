class ApiException implements Exception {
  ApiException(
    this.message,
  );

  String message;

  @override
  String toString() => message;
}
