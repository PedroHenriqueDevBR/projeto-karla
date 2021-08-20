class InvalidDataException implements Exception {
  List<String> message;
  InvalidDataException({
    required this.message,
  });
}
