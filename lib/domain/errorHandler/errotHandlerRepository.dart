import 'package:core/network/response/KanoonHttpResponse.dart';
import 'package:kanooniha/domain/errorHandler/ErrorModel.dart';

abstract class ErrorHandlerRepository {
  ErrorModel makeError(KanoonHttpResponse response);

  ErrorModel makeErrorByStatusCode(int statusCode);
}
