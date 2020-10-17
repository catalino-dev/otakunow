class ApiErrorMessage {

  final int status;
  final String type;
  final String message;
  final String error;

  const ApiErrorMessage(this.status, this.type, this.message, this.error);

  static ApiErrorMessage fromJson(dynamic json) {
    return ApiErrorMessage(
      json['status'] as int,
      json['type'] as String,
      json['message'] as String,
      json['error'] as String,
    );
  }
}
