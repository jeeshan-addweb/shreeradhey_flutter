class NetworkException implements Exception {
  String? message;
  int? statusCode;

  NetworkException({this.message, this.statusCode});
}

class ApiException extends NetworkException {
  ApiException({message, statusCode})
      : super(message: message, statusCode: statusCode);
}
