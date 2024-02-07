class ApiResponse {
  final int status;
  final String message;
  final dynamic params;

  ApiResponse({
    required this.status,
    required this.message,
    this.params,
  });
}
