class ErrorModel {
  const ErrorModel({required this.state,required this.message});

  final String message;
  final ErrorState state;
}

enum ErrorState {
  UnAuthorization, Message, Empty;
}
