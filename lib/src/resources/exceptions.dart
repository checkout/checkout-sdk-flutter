class UnauthorizedError implements Exception {
  UnauthorizedError();
}

class InvalidDataError {
  String requestId;
  String errorType;
  List<String> errorCodes;

  InvalidDataError({
    required this.requestId,
    required this.errorType,
    required this.errorCodes,
  });

  factory InvalidDataError.fromJson(Map<String, dynamic> json) =>
      InvalidDataError(
        requestId: json["request_id"],
        errorType: json["error_type"],
        errorCodes: List<String>.from(json["error_codes"].map((x) => x)),
      );
}
