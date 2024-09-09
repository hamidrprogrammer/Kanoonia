import 'package:kanooniha/domain/errorHandler/ErrorModel.dart';

abstract class AppState {
  static Idle idle = Idle();
  static Loading loading = Loading();

  static Error error(ErrorModel errorModel) {
    return Error(errorModel: errorModel);
  }

  static Success success<T>(T data) {
    return Success(successData: data);
  }

  static Fresh fresh(double time) {
    return Fresh(time: time);
  }
}

class Fresh extends AppState {
  final double time;

  Fresh({required this.time});
}

class Idle extends AppState {}

class Loading extends AppState {}

class Success<T> extends AppState {
  T? successData;

  Success({this.successData});
}

class Error extends AppState {
  ErrorModel errorModel;

  Error({required this.errorModel});
}
