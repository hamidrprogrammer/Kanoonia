import 'package:dio/dio.dart';

class KanoonHttpResponse {
  final int responseStatusCode;
  final String responseBody;

  int get statusCode => responseStatusCode;

  String get body => responseBody;

  const KanoonHttpResponse({
    required this.responseBody,
    required this.responseStatusCode,
  });
}

extension KanoonHttpExtension on Response {
  KanoonHttpResponse get createKanoonResponse => KanoonHttpResponse(
      responseBody: toString(), responseStatusCode: statusCode ?? 0);
}


extension KanoonHttpExtension2 on KanoonHttpResponse{
  bool get isSuccessful => statusCode == 200;
}