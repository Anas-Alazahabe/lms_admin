abstract class ApiSuccess {
  final String message;

  const ApiSuccess(this.message);
}

class ServerSuccess extends ApiSuccess {
  ServerSuccess(super.message);

  factory ServerSuccess.fromResponse(dynamic response) {
    return ServerSuccess(response['message']);
  }
}
