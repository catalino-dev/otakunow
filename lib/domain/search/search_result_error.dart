class ApiErrorMessage {

  final int status;
  final String type;
  final String message;
  final String error;

  const ApiErrorMessage({this.status, this.type, this.message, this.error});

  static ApiErrorMessage fromJson(dynamic json) {
    return ApiErrorMessage(
      status: json['status'] as int,
      type: json['type'] as String,
      message: json['message'] as String,
      error: json['error'] as String,
    );
  }
}
